# Holbegram

Holbegram is a comprehensive Flutter project developed as part of the Holberton School curriculum. It leverages Google's Flutter framework along with Firebase to build a social media application tailored for showcasing images. This project integrates various Firebase services, including Authentication, Firestore, and Storage, to create a dynamic and responsive user experience.

## Features

- **User Authentication**: Sign up and log in functionality with email and password.
- **Image Upload**: Users can upload images from their device's gallery or camera.
- **Real-time Database**: Utilize Firestore for real-time data storage and retrieval.
- **Cloud Storage**: Images are stored in Firebase Cloud Storage.
- **Interactive UI**: Custom widgets and a responsive design enhance user interaction.

## Screens

- **Login Screen**: Secure login with email and password.
- **Sign Up Screen**: User registration page.
- **Image Upload Screen**: Interface to upload images to the platform.

## Dependencies

- Firebase Auth
- Cloud Firestore
- Firebase Storage
- Image Picker
- BottomNavyBar
- Provider
- UUID
- Cached Network Image
- Flutter Pull To Refresh

## Setup

1. Clone the repository:
git clone [repository-url]

2. Navigate to the project directory:
cd holbegram

3. Install the required packages:
flutter pub get

4. Run the project:
flutter run

## Configuration

To connect the app to Firebase:

1. Create a Firebase project at [Firebase Console](https://firebase.google.com/).
2. Register the app with Android and iOS in Firebase.
3. Download `google-services.json` and `GoogleService-Info.plist` for Android and iOS respectively and place them in their respective folders.
4. Update project settings in `build.gradle` and `Info.plist` as per Firebase setup instructions.

## Structure

- `lib/main.dart`: Entry point of the application that initializes Firebase.
- `lib/screens/`: Contains the UI screens of the application.
- `lib/widgets/`: Reusable widgets like custom text fields.
- `lib/models/`: Data models for users and posts.
- `lib/methods/`: Backend logic including authentication and storage methods.

## Contributing

Feel free to fork the repository and submit pull requests. For major changes, please open an issue first to discuss what you would like to change
