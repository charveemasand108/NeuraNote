import SwiftUI
import Vision

struct ContentView: View {
    @State private var scannedText = ""
    @State private var explanation = ""
    @State private var showCamera = false
    @State private var isProcessing = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {

                    // Header
                    VStack(spacing: 5) {
                        Text("NeuraNote")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Scan. Understand. Learn.")
                            .foregroundColor(.gray)
                    }

                    // SCANNED TEXT CARD
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Scanned Text", systemImage: "doc.text.viewfinder")
                            .font(.headline)

                        ScrollView {
                            Text(scannedText.isEmpty ? "Scan your notes to see text here..." : scannedText)
                                .foregroundColor(scannedText.isEmpty ? .gray : .primary)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 5)

                    // EXPLANATION CARD
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Explanation", systemImage: "brain.head.profile")
                            .font(.headline)

                        ScrollView {
                            if isProcessing {
                                ProgressView("Thinking...")
                                    .padding()
                            } else {
                                Text(explanation.isEmpty ? "Generate explanation to see results..." : explanation)
                                    .foregroundColor(explanation.isEmpty ? .gray : .primary)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 5)

                    Spacer()

                    // BUTTONS
                    HStack(spacing: 15) {

                        Button(action: {
                            showCamera = true
                        }) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("Scan")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }

                        Button(action: {
                            generateExplanation()
                        }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Explain")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                        .disabled(scannedText.isEmpty)
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showCamera) {
                CameraView { image in
                    recognizeText(from: image)
                }
            }
        }
    }

    // MARK: - OCR
    func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest { request, error in
            guard let results = request.results as? [VNRecognizedTextObservation] else { return }

            let text = results.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: "\n")

            DispatchQueue.main.async {
                self.scannedText = text
                self.explanation = ""
            }
        }

        request.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }

    // MARK: - AI Simulation
    func generateExplanation() {
        isProcessing = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            explanation = summarizeText(scannedText)
            isProcessing = false
        }
    }

    func summarizeText(_ text: String) -> String {
        let sentences = text.components(separatedBy: ".")
        let short = sentences.prefix(2).joined(separator: ".")

        return """
        📌 Summary:
        \(short)

        💡 Explanation:
        This content mainly talks about: \(extractKeywords(text))
        """
    }

    func extractKeywords(_ text: String) -> String {
        let words = text.lowercased().components(separatedBy: " ")
        let common = ["the","is","and","of","to","in","a","for","on","with"]

        let filtered = words.filter {
            !common.contains($0) && $0.count > 4
        }

        return filtered.prefix(3).joined(separator: ", ")
    }
}
