# Flutter Application

#Flutter Sdk : 3.24.1

This project is a Flutter application designed to demonstrate a basic architecture pattern for organizing Flutter code. It follows the Model-View-Controller (MVC) pattern to separate concerns and enhance maintainability.

## Project Structure

The project is organized into the following directories:

- **`/lib`**: Contains all the Dart code for the application.
    - **`/controllers`**: Contains the controller files responsible for handling user interactions and managing the state of the application. Example: `home_controller.dart`.
    - **`/models`**: Contains the data models representing the structure of the data used in the app. Example: `post.dart`.
    - **`/services`**: Contains the service files responsible for managing data operations, such as API calls. Example: `api_service.dart`.
    - **`/views`**: Contains the UI files for the application, responsible for presenting data to the user. Examples: `home_screen.dart`, `detail_screen.dart`.
    - **`main.dart`**: The entry point of the application that sets up the initial route and app-wide configurations.

## Architectural Choices

### MVC Pattern
- **Model**: Represents the data and business logic of the application. In this project, models are located in the `/models` directory.
- **View**: Represents the user interface of the application. Views are defined in the `/views` directory.
- **Controller**: Manages the communication between the Model and View. It processes user inputs, manipulates the data, and updates the view accordingly. Controllers are found in the `/controllers` directory.

### Separation of Concerns
This architecture helps in separating different aspects of the application:
- **Models** handle data structure and logic.
- **Controllers** manage the state and application logic.
- **Views** handle the presentation and user interactions.
- **Services** encapsulate the business logic related to external resources, like APIs.