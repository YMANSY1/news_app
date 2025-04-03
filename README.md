# News Portal App
The **News Portal App** is a mobile application designed to fetch and display news articles from various categories like business, entertainment, health, science, technology, sports, and more. It provides a one stop for all solution, allowing everybody to find news from different sources and access the articles with the click of a button!

## Features
- **News Categories**: The app displays a variety of news categories including Business, Entertainment, Health, Science, Sports, Technology, and more. Users can explore different categories to get relevant news articles. 
- **Search Functionality**: Users can search for news articles by keywords, making it easier to find specific content within the app.
- **News Articles**: The app news articles from the News API and presents them with rich media such as images, titles, and descriptions.
- **Responsive Design**: The app features a responsive layout that adapts to various screen sizes, providing a smooth experience across different devices.
- **Category-based Navigation**: Users can easily navigate between categories, filtering news based on their preferences.
- **Loading States**: The app shows appropriate loading indicators while fetching data, ensuring users know that the app is working in the background.
- **Error Handling**: The app handles errors gracefully, informing users when something goes wrong (e.g., no internet connection, data fetch failure).

## Tech Stack
### Frontend
- **Flutter**
- **Dart**

### Backend
- **Dio**: Dio is used for making HTTP requests to fetch news articles and handle network responses.
- **API Integration**: The app fetches data from a news API (such as [NewsAPI](https://newsapi.org/) or a custom API), parsing articles into a user-friendly format.

### Development Tools
- **Android Studio**: For development and debugging.
- **Git**: For version control.

## Installation
### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter)

### Steps to Run Locally
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/news-portal-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd news-portal-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```
