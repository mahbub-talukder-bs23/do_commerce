# Do Commerce 🛒

**Do Commerce** is a modern e-commerce application built with Flutter, leveraging the [dummyJson](https://dummyjson.com/docs) API. The project is designed to showcase best practices in mobile development, focusing on **Clean Architecture** principles and robust state management using **Riverpod**.

## 🚀 Features

* **Product Catalog:** Browse products by categories with pagination.
* **Product Details:** In-depth view of items including image carousels and reviews.
* **Cart Management:** Add, remove, and update item quantities.
* **Search & Filter:** Find specific products efficiently.
* **User Profiles:** Dummy authentication and profile management.

## 🛠 Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Riverpod](https://riverpod.dev/) (Functional Providers & Notifiers)
* **Networking:** [Dio](https://pub.dev/packages/dio)
* **Service Locator:** Riverpod (for dependency injection)
* **API:** [dummyJson](https://dummyjson.com/)

---

## 🏗 Architecture

This project follows **Clean Architecture** to ensure a strict separation of concerns, making the code easier to test and modify.

### The Three Layers:

1. **Data Layer:**
* **Data Sources:** Direct communication with the dummyJson API (Remote) or local database.
* **Models:** JSON serialization/deserialization logic.
* **Repositories (Implementation):** Implements the contracts defined in the Domain layer.


2. **Domain Layer:**
* **Entities:** Simple Dart objects representing the core business data.
* **Use Cases:** Specific business logic/rules (e.g., `GetProductDetails`, `AddToCart`).
* **Repositories (Interfaces):** Abstract classes defining what the data layer must do.


3. **Presentation Layer:**
* **UI (Widgets/Pages):** Flutter widgets and layouts.
* **Providers (Riverpod):** Manages the state of the UI and interacts with Use Cases.


---

## 📂 Project Structure

```text
lib/src/
├── core/           # Core utilities and dependency injection
├── domain/         # Business logic and entities
├── data/           # Data sources and repository implementations  
└── presentation/   # UI components and state management
```

---

## 🚦 Getting Started

### Prerequisites

* Flutter SDK: `>=3.38.2`
* Dart SDK: `>=3.10.0`

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/your-username/do_commerce.git

```


2. **Navigate to the project folder:**
```bash
cd do_commerce

```


3. **Install dependencies:**
```bash
flutter pub get

```


4. **Run the application:**
```bash
flutter run

```



---

## 🧪 Testing

* **Unit Tests:** Testing Use Cases and Repositories.
* **Widget Tests:** Ensuring UI components render correctly.
* **Provider Tests:** Testing Riverpod state transitions.
