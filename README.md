# CaribPay

CaribPay is a lightweight mobile application built with Flutter for sending and receiving money. It was developed as part of an evaluation assignment and demonstrates core concepts in mobile architecture, API integration, and UI/UX design. While not fully implemented, it provides the fundamental structure and features of a financial transaction app.

---

## Features

- Send & receive money (basic flow)
- Dark mode support
- Custom themes & UI
- Animations for enhanced UX
- Persistent bottom navigation
- Secure API integration using bearer tokens

---

## Tech Stack

### Frontend

- **Framework:** Flutter
- **Architecture:** MVVM
- **State Management:** Provider
- **Networking:** Dio with a custom API service
- **Routing:** Navigator + persistent bottom navigator
- **UI/UX:** Custom design, animations, and responsive layout

### Backend

- **API:** Custom-built RESTful API
- **Auth:** Token-based (Bearer token headers)
- **Docs:** [Link or folder path to API docs if hosted](https://github.com/mck311um/caribpay-api)

## Project Architecture

The app follows MVVM architecture with clean folder separation:

---

## API Integration

- The app uses Dio for all API requests.
- A custom service automatically attaches bearer tokens to headers.
- Endpoints support basic CRUD operations for sending/receiving funds.
- Refer to the `services/api_service.dart` for request handling.

---

## Navigation

- App uses `Navigator` for screen transitions.
- Persistent navigation is implemented using a custom bottom navigation bar for seamless tab switching.

---

## Theming & UI

- Light and dark themes included
- Custom widget library for reusable components
- UI designed for mobile-first experience with animations for visual feedback

---

## Setup Instructions

1. Install Dependencies

```bash
flutter pub get
```

2. Set up environment variables for your API base URL and auth tokens if needed.

3. Run the app:

```bash
flutter run
```

## Authentication

- Secure API endpoints via token-based auth
- Login flow saves the token locally and applies it to each API call via an interceptor

## Future Enhancements

- Implement full transaction history
- Add biometric login
- Complete money request flow
- Integrate push notifications
- Add unit and widget tests

## API Documentation

See [API_DOCUMENTATION.md](https://github.com/mck311um/caribpay-api) for full details on endpoints, request formats, and example responses.

## About

Created by Mc Kellum Lawrence
