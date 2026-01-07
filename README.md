
---

# 📱 Flutter Video Session App

A 2-screen Flutter application demonstrating **GetX state management**, **Firebase Firestore integration**, **runtime permission handling**, and a **mock video call interface with a real-time stopwatch**.

This project was built as part of a technical evaluation task.

---

## ✨ Features

### ✅ Screen 1 – Appointments

* Fetches **Upcoming Sessions** from Firebase Firestore
* Displays sessions in a clean, card-based UI
* **Join Session** button for each upcoming session
* Runtime permission check for:

    * Camera
    * Microphone
* Updates session status to **`ongoing`** in Firestore on join

---

### ✅ Screen 2 – Video Interface (Mock)

* Mock video call UI (no real video SDK)
* Live **stopwatch** tracking session duration
* Camera ON/OFF toggle (UI + state)
* Microphone ON/OFF toggle (UI + state)
* **End Call** button
* Saves:

    * Total session duration
    * Final session status (**`completed`**) to Firestore

---

## 🛠 Tech Stack

* **Flutter**
* **GetX** – State management & navigation
* **Firebase Firestore** – Backend database
* **permission_handler** – Camera & Microphone permissions

---

## 📂 Project Structure

```
lib/
│── controllers/
│   ├── session_controller.dart
│   └── call_controller.dart
│
│── screens/
│   ├── appointments_screen.dart
│   └── video_call_screen.dart
│
│── widgets/
│   ├── app_drawer.dart
│   └── self_camera_preview.dart
│
│── utils/
│   └── permissions.dart
│
│── main.dart
```

---

## 🗃 Firestore Schema

**Collection:** `sessions`

```json
{
  "title": "Flutter Consultation",
  "scheduledAt": "10:00 AM - 11:00 AM",
  "status": "upcoming",
  "durationInSeconds": 0
}
```

### Session Status Flow

```
upcoming → ongoing → completed
```

---

## 🔐 Permissions

The app requests the following runtime permissions before joining a session:

* Camera
* Microphone

If permissions are denied:

* A user-friendly message is shown
* App settings are opened if permissions are permanently denied

---

## ▶️ Application Flow

1. App launches and loads upcoming sessions from Firestore
2. User taps **Join Session**
3. Camera & Microphone permissions are requested
4. Session status updates to `ongoing`
5. Video interface opens and stopwatch starts
6. User ends call
7. Session duration and status (`completed`) are saved to Firestore
8. User navigates back to Appointments screen

---

## 🚀 How to Run

1. Clone the repository
2. Configure Firebase for the project
3. Enable Firestore in Firebase Console
4. Add sample documents to `sessions` collection
5. Run:

```bash
flutter pub get
flutter run
```

---

## 🧠 Notes

* This app uses a **mock video interface** as required
* No real video calling SDK (WebRTC / Agora / Jitsi) is integrated
* Focus is on:

    * State management
    * Firestore lifecycle
    * Permissions
    * UI structure
    * Clean architecture

---

## 📌 Possible Enhancements

* Real video SDK integration
* Authentication
* Session scheduling
* Call reconnection handling
* Background call support

---

## 👤 Author

**Yash Dipke**

---

## ✅ Task Status

✔ All requirements implemented
✔ Clean GetX architecture
✔ Firestore lifecycle handled correctly
✔ Interview-ready implementation

---


