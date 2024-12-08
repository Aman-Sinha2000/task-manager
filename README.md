# Task Tracker with User Management

## Description

A Flutter application designed for managing tasks with user authentication and task categorization.
The application uses BLoC for state management and SQLite for local data persistence.
It provides a responsive UI that adapts to both mobile and tablet devices, with features like theme switching based on system preferences and comprehensive error handling.

## Features

### User Login

- Users can log in using a mock API with the following credentials:
  - **Email:** Tarun@example.com
  - **Password:** Tarun@123
- Invalid credentials result in an error message: "Invalid email and password."
- Successful login navigates to the Home Page.

### Navigation Bar

The navigation bar includes:

1. **Home**
2. **Add Task**
3. **Profile**

### Home Page

Displays tasks categorized into:

1. **Pending Tasks** - Tasks with a status of "Pending."
2. **In Progress Tasks** - Tasks with a status of "In Progress."
3. **Completed Tasks** - Tasks with a status of "Completed." The completion date is shown instead of the due date.
4. **Expired Tasks** - Tasks with a due date earlier than the current date. The status of expired tasks cannot be edited.

### Task Details Page

- Shows detailed information about the selected task:
  - **Task Name**
  - **Description**
  - **Due Date**
  - **Current Status**
- Users can update the task's status, which is immediately reflected in the database.

### Add Task Page

- Allows users to create a new task with the following fields:
  - **Task Title**
  - **Description**
  - **Due Date** (Cannot select past dates)
- The status is always set to "Pending" on task creation.
- All fields are mandatory; validation ensures proper inputs.

### Profile Page

- Displays user information:
  - **Name**
  - **Email**
- Includes a logout option to clear user information and navigate back to the Login Page.

### Theme and Responsiveness

- Supports dark and light themes based on system preferences.
- Fully responsive for mobile and tablet devices.

### Local Data Storage

- Uses SQLite for task management.
- SharedPreferences are used for storing user information and handling logout functionality.

## APKs Provided

- **Debug APK:** For testing and development purposes. It includes debugging tools and logging capabilities to assist in identifying and resolving issues during the development phase.
- **Release APK:** Optimized for production use. This APK is signed, optimized, and free of debugging tools, ensuring better performance and security.

## Steps to Run the Project

1. Clone the repository from GitHub.
2. Open the project in your preferred IDE (e.g., Android Studio or VS Code).
3. Run `flutter pub get` to install dependencies.
4. For Debug APK:
   - Use the command `flutter build apk --debug`.
   - The APK will be generated in the `build/app/outputs/app-debug.apk` directory.
5. Install the APK on a device or emulator to test the application.

## Assumptions

- Mock API is used for user authentication with hardcoded credentials.
- SQLite database preloads tasks using initial mock data.
- Users cannot edit the status of expired tasks.

## Explanation of Architecture

### Clean Architecture

- **Presentation Layer:** Uses BLoC for efficient state management and separation of concerns.
- **Domain Layer:** Contains the business logic and task categorization.
- **Data Layer:** Handles interactions with SQLite and the mock API.

### State Management

- Implemented using BLoC to manage the state of the application efficiently.
- Ensures smooth UI updates and clear separation between business logic and UI.

### Local Persistence

- **SQLite:** Stores task-related data locally for offline access.
- **SharedPreferences:** Manages user login state and preferences.

### Error Handling

- Comprehensive error messages for invalid inputs, API failures, and other issues.

---

For any queries or feedback, feel free to contact me.
