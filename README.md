# 🧠 NeuraNote

> **Scan. Understand. Learn.**

NeuraNote is an iOS app that turns your handwritten or printed notes into instant AI-powered explanations. Just point your camera at any notes, and NeuraNote scans the text and breaks it down for you — making studying faster, smarter, and effortless.

---

## ✨ Features

- 📷 **Camera Scanning** — Capture handwritten or printed notes directly from your camera or photo library
- 🔍 **On-Device OCR** — Extracts text accurately using Apple's Vision framework, with no internet required
- 🤖 **AI Explanation Engine** — Instantly summarizes and explains scanned content, highlighting key concepts and keywords
- ⚡ **Clean Two-Panel UI** — Side-by-side scanned text and explanation cards for a distraction-free study experience
- 🌙 **Beautiful Design** — Glassmorphism cards with a blue-purple gradient, built natively in SwiftUI

---

## 🏗️ Architecture

NeuraNote is built with a lightweight single-view architecture powered by SwiftUI's reactive state system:

- `ContentView` manages all UI state via `@State` properties and drives OCR and explanation logic directly
- `CameraView` is a `UIViewControllerRepresentable` wrapper around `UIImagePickerController`, with graceful fallback to the photo library on simulators
- Text recognition runs via `VNRecognizeTextRequest` from Apple's Vision framework, with `.accurate` recognition level for maximum precision
- The AI explanation pipeline extracts key sentences and filters meaningful keywords to generate a clean, structured summary

---

## 📂 File Structure

- `NeuraNoteApp.swift` — App entry point (`@main`)
- `ContentView.swift` — Main screen with OCR, explanation logic, and full UI
- `Camera View.swift` — Camera/photo picker using `UIViewControllerRepresentable`
- `Assets.xcassets/` — App icons and accent colors
- `Info.plist` — Camera and photo library usage permissions

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| State Management | @State |
| Text Recognition | Vision (`VNRecognizeTextRequest`) |
| Camera Integration | UIKit (`UIImagePickerController`) |
| Language | Swift 5.9 |
| Min iOS | iOS 16.0+ |

---

## 🚀 Getting Started

1. Clone the repo — `git clone https://github.com/charveemasand108/NeuraNote.git`
2. Open `NeuraNote.xcodeproj` in Xcode
3. Select a real device (camera features work best on device)
4. Hit **Run** ▶️

---

## 🗺️ Roadmap

- 🧠 **Live AI Integration** — Connect to OpenAI or a local LLM for richer, real explanations
- 🗂️ **Save & Organize Notes** — Persist scanned notes with SwiftData or CoreData
- 🌍 **Multi-language OCR** — Support scanning notes in multiple languages
- 📤 **Export** — Share summaries as PDFs or copy to clipboard
- 🎙️ **Voice Playback** — Read explanations aloud using AVSpeechSynthesizer

---

## 👩‍💻 Author

**Charvee Masand** — [@charveemasand108](https://github.com/charveemasand108)

---

## 📄 License

MIT License — free to use, fork, and build on.
