# 🛒 Shopora - Modern E-Commerce App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Provider](https://img.shields.io/badge/Provider-State%20Management-blueviolet)](https://pub.dev/packages/provider)

**Shopora** is a premium, fully-functional E-Commerce mobile application built using **Flutter**. It provides a seamless shopping experience with real-time data integration, smart search, and a modern UI.

This project uses **DummyJSON REST API** for product data and **Provider** for efficient state management, ensuring high performance without the need for a backend like Firebase.

---

## 🚀 Features

- ⚡ **Modern UI/UX**: Premium Deep Orange theme with Material 3 and Poppins font.
- 📦 **Live Product Data**: Fetches real-time products from **DummyJSON API**.
- 🔍 **Smart Search**: Real-time product search with instant results.
- 📂 **Categorized Browsing**: Filter products by categories like Fashion, Electronics, etc.
- 🛒 **Advanced Cart**: Manage items, adjust quantities, and calculate real-time totals (Tax + Delivery).
- ❤️ **Favorites System**: Save your favorite products for quick access.
- 💳 **Payment Integration**: Simulated checkout process with **Razorpay** support.
- 📱 **Responsive Design**: Fully optimized for all screen sizes (Mobile, Tablet).

---

## 📸 App Screenshots

### 🔹 Experience & Auth
| Splash Screen | Login Screen | Register Screen |
| :---: | :---: | :---: |
| <img src="screenshots/splash_screen.png" width="200"> | <img src="screenshots/login.png" width="200"> | <img src="screenshots/register.png" width="200"> |

### 🔹 Discovery
| Home Screen | Categories | Search Filter |
| :---: | :---: | :---: |
| <img src="screenshots/home_screen.png" width="200"> | <img src="screenshots/category_screen.png" width="200"> | <img src="screenshots/search_query.png" width="200"> |

### 🔹 Product & Shopping
| Details Page | Active Cart | Favorites |
| :---: | :---: | :---: |
| <img src="screenshots/product_details_screen.png" width="200"> | <img src="screenshots/cart_screen.png" width="200"> | <img src="screenshots/favorites_screen.png" width="200"> |

### 🔹 User Profile
| Account Page | Category Filter |
| :---: | :---: |
| <img src="screenshots/account_screen.png" width="200"> | <img src="screenshots/category_filter_screen.png" width="200"> |

---

## 📂 Project Structure

```
lib/
├── models/          # Data models (Product, Category, ProductMeta)
├── services/        # API integration (REST API - DummyJSON)
├── provider/        # State management (Auth, Cart, Product, Favorite)
├── screens/         # UI Screens (Home, Login, Search, Cart, etc.)
├── widgets/         # Reusable UI components
└── main.dart        # App entry point & Global Theme configuration
```

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **API**: [DummyJSON REST API](https://dummyjson.com/)
- **Payment Gateway**: [Razorpay Flutter](https://pub.dev/packages/razorpay_flutter)
- **Fonts**: [Poppins](https://fonts.google.com/specimen/Poppins)

---

## ⚙️ Setup & Installation

1. **Clone the repo:**
   ```bash
   git clone https://github.com/Arjun-flutter/ecommers_app.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the application:**
   ```bash
   flutter run
   ```

---

Developed with ❤️ by **Nagarjuna Reddy Avula**
