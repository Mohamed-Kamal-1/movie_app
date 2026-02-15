# Movie App 🎬

A movie discovery and details application built with the **Flutter** framework and structured based on **Clean Architecture** principles, ensuring high scalability, maintainability, and code efficiency.

## ✨ Key Features

  * **Movie Browsing:** View curated lists of Popular and Top Rated Movies.
  * **Detailed Information:** Access comprehensive details for each film, including synopsis, ratings, and release dates.
  * **High Performance:** Enjoy a fast and smooth user experience due to Flutter's native compilation.
  * **Effective State Management:** Utilizes the BLoC/Cubit pattern for reliable and testable data flow.

## 🛠 Technology Stack

This project is built using a modern and robust set of tools within the Flutter ecosystem:

| Category | Technology | Description |
| :--- | :--- | :--- |
| **Framework** | **[Flutter](https://flutter.dev/)** | Cross-platform UI toolkit. |
| **Language** | **[Dart](https://dart.dev/)** | The core programming language for the application. |
| **State Management** | **[BLoC / Cubit](https://bloclibrary.dev/)** | Predictable and scalable state management. |
| **Networking** | **[Dio](https://pub.dev/packages/dio)** | HTTP client for executing **REST API** requests. |
| **Architecture** | **Clean Architecture** | Architectural blueprint for separating application layers. |
| **Dependency Injection** | **[GetIt](https://pub.dev/packages/get_it)** | Service locator for easy access to shared services. |
| **Local Storage** | **[Hive](https://pub.dev/packages/hive)** | Lightweight and blazing fast key-value database. |
| **OTA Updates** | **[Shorebird](https://shorebird.dev/)** | Code Push for instant app updates without App Store review. |
| **Notifications** | **[FCM](https://firebase.google.com/docs/cloud-messaging)** | Firebase Cloud Messaging for push notifications. |

## 📐 Project Architecture

The project adheres to the **Clean Architecture Pattern** to ensure a strong separation of concerns. The code is divided into key layers:

1.  **Presentation:** Contains the UI components and BLoC/Cubit files for managing screen state.
2.  **Domain:** Holds the core business logic, including Entities and Use Cases.
3.  **Data:** Manages the Repositories and Remote Data Sources for interacting with the external REST API.

This structure significantly improves the codebase's testability, maintainability, and long-term scalability.

## 🚀 Getting Started

To clone and run this project on your local machine, follow these simple steps:

### Prerequisites

Ensure you have the following installed:

  * [Flutter SDK](https://flutter.dev/docs/get-started/install) (Latest stable version recommended).
  * A valid **API Key** for the movie service used (e.g., The Movie Database - TMDB).

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Mohamed-Kamal-1/movie_app.git
    cd movie_app
    ```

2.  **Install the dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Set up the API Key:**

      * You must place your API key in the designated constants or environment file within the project structure to enable network requests.

4.  **Run the application:**

    ```bash
    flutter run
    ```
    ## 🤝 Contributing

We welcome contributions! If you have suggestions or want to improve the project, please follow these steps:
1.  Fork the repository.
2.  Create a new feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.
