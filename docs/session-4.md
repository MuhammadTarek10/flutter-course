# Session 4: Advanced Navigation Patterns

## 🎯 Core Objectives

- Understand and implement stack-based navigation (`push`/`pop`).
- Master passing data to a new screen and returning data from it.
- Build a multi-page UI using a `BottomNavigationBar`.
- Create a swipeable screen layout using `PageView`.
- Integrate `PageView` and `BottomNavigationBar` for a seamless user experience.

## ✅ Prerequisites

- Comfortable building stateful widgets (from Session 3).

---

### **Module 1: Stack Navigation & Data Flow (45 minutes)**

**Goal:** Solidify the fundamental navigation model before moving to more complex patterns.

1.  **The Stack Analogy (Recap):**
    - Quickly review the concept of the navigation stack: a stack of cards where you `push` new screens on top and `pop` them to go back.
2.  **Live Coding: Passing Data Between Screens**
    - **Passing Data _Forward_:**
      - Create a `DetailsScreen` that requires data in its constructor.
      - From a `HomeScreen`, use `Navigator.push` to create an instance of `DetailsScreen`, passing the required data.
      - **Code Snippet:** `Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(data: 'Some important data')));`
    - **Returning Data _Back_:**
      - In `HomeScreen`, `await` the result from `Navigator.push`.
      - In `DetailsScreen`, use `Navigator.pop(context, 'This is the result')` to send data back.
      - Show the returned result on the `HomeScreen` (e.g., in a `SnackBar` or `Text` widget).

---

## **Module 2: The `BottomNavigationBar`**

**Goal:** Implement one of the most common navigation patterns in mobile apps.

1.  **Concept:** Explain that `BottomNavigationBar` is for switching between a small number of top-level views (e.g., Home, Search, Profile). It's not for sequential steps like in a quiz.
2.  **Live Coding: Building a Tabbed App**
    - **Structure:** Create a new `StatefulWidget` to act as the main app shell.
    - **State:** Create a state variable `int _selectedIndex = 0;`.
    - **Pages:** Create a `List<Widget>` containing the different screen widgets you want to show (e.g., `const [HomeScreen(), SearchScreen(), ProfileScreen()]`).
    - **Implementation:**
      - In the `Scaffold`, set the `body` to `_pages[_selectedIndex]`.
      - Add the `bottomNavigationBar` property and create a `BottomNavigationBar` widget.
      - Provide a `List<BottomNavigationBarItem>` for the icons and labels.
      - Set `currentIndex: _selectedIndex`.
      - In the `onTap` callback, use `setState` to update the `_selectedIndex`. This is the key to making it work.

---

## **Module 3: Swipeable Screens with `PageView`**

**Goal:** Learn to create swipeable pages and link them to the `BottomNavigationBar`.

1.  **Concept:** Introduce `PageView` as the widget for building swipeable layouts, like onboarding flows or the main interface of apps like Instagram.
2.  **Live Coding: Integrating `PageView`**
    - **Controller:** Introduce `PageController`. Create an instance of it in your main app shell's `State` class.
    - **Refactor the Body:** Replace the simple `_pages[_selectedIndex]` body with a `PageView` widget.
      - Set the `controller` property to your `PageController`.
      - Provide the same `List<Widget>` of pages to its `children` property.
    - **Link the Widgets (Two-Way Sync):**
      1.  **Tapping the Bar -> Swiping the Page:** In the `BottomNavigationBar`'s `onTap` method, in addition to `setState`, call `_pageController.animateToPage(_selectedIndex, ...)`.
      2.  **Swiping the Page -> Updating the Bar:** On the `PageView` widget, implement the `onPageChanged` callback. Inside it, call `setState` to update the `_selectedIndex` to the new page index.

---

## **Module 4: Homework & Best Practices (15 minutes)**

**Goal:** Introduce a cleaner navigation method and assign a practical task that combines all session concepts.

- **💡 Tip & Trick: Named Routes**
  - Briefly explain that for `Navigator.push`, defining routes in `MaterialApp` (e.g., `'/details': (context) => DetailsScreen()`) and calling `Navigator.pushNamed(context, '/details')` is a more scalable and maintainable approach for larger apps.
- **🚀 Homework Task: Build an App Shell**

- **Description:** "Create the main UI shell for a mock social media app."
  1.  The app must use a `BottomNavigationBar` with at least 3 tabs (e.g., "Feed", "Messages", "Profile").
  2.  The content for these tabs must be managed by a `PageView`, allowing the user to swipe between them.
  3.  The `BottomNavigationBar` and `PageView` must be fully synchronized (tapping a tab changes the page, and swiping the page updates the selected tab).
- **Bonus Challenge:**
  - On the "Feed" page, display a simple `ListView` of items.
  - When a user taps an item, `push` a new "Post Details" screen.
  - This navigation **must** be implemented using **named routes**.
