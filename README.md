# Bochord - Smart Library

Bochord is a smart library application designed to enhance the digital library experience for students and educators. It integrates Google Books API for easy access to e-books, offers an offline catalog for efficient book tracking, and includes a chatbot for user assistance. Whether you're a student looking for resources or an educator managing a library, Bochord streamlines the process and provides a seamless, user-friendly experience.


## Tech Stack

**Frontend:** Dart, Flutter

**Backend:** Firebase

**API:** Google books API, Dialogflow
## Features

- **Google Books Integration:** Access a vast collection of e-books.
- **Offline Book Catalog:** Efficient tracking of book availability.
- **Book Issuance and Return:** Streamlined processes via a dedicated - admin page.
- **User Assistance Chatbot:** Powered by Dialogflow to handle library-related queries.
- **Smooth Animations:** Enhances user experience with seamless transitions.
- **User-Friendly Interface:** Intuitive and easy-to-navigate design.


## Run Locally

Pre requisite
- Ensure you have Flutter installed on your machine. Follow the Flutter installation guide if you haven't set it up yet.
- Install Dart SDK if it's not already included with Flutter.

Clone the project

```bash
  git clone https://github.com/Krish-Choudhary/Bochord-Smart-Library.git
```

Go to the project directory

```bash
  cd Bochord-Smart-Library
```

Install dependencies

```bash
  flutter pub get
```

Set up Firebase
- Create a Firebase project in the Firebase Console.
- Add an Android and/or iOS app to your Firebase project.
- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files and place them in the appropriate directories:
    - android/app/google-services.json
    - ios/Runner/GoogleService-Info.plist

Configure the Google Books API:

Obtain an API key from the Google Developers Console.
Add the API key to the project.

Configure Dialogflow:

- Create a Dialogflow agent in the Dialogflow Console.
- Obtain the service account key and add it to your project.

Running the Application
- Run the app on your preferred device or emulator
```bash
  flutter run
```

Note
- Ensure your development environment is properly set up with the necessary Android/iOS emulators or connected physical devices.
