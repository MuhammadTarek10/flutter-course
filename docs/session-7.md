# Session 7: Asynchronous Programming & API Integration

### 🎯 Core Objectives:
* Understand what asynchronous programming is and why it's essential for responsive apps.
* Master the use of `Future`, `async`, and `await` in Dart.
* Learn how to make HTTP requests to a real-world REST API.
* Parse JSON data and convert it into strongly-typed Dart objects.
* Use `FutureBuilder` to gracefully handle loading, error, and success states in the UI.

## ✅ Prerequisites:
* Solid understanding of `StatefulWidget` and building UIs.

---

## **Module 1: The Problem of a Frozen App & The Async Solution**

**Goal:** Explain the core concepts of asynchronous programming using simple analogies.

1.  **The Synchronous Problem:**
    * **Analogy:** "Imagine you're at a coffee shop. A **synchronous** process is like ordering your coffee and being forced to stand at the counter, staring at the barista, unable to do anything else until your drink is ready. The entire line behind you is blocked. This is what happens to your app's UI if you run a long task—it freezes."
2.  **The Asynchronous Solution:**
    * **Analogy:** "An **asynchronous** process is the modern way. You order your coffee, and they hand you a buzzer. You can now go sit down and check your phone. When your coffee is ready, the buzzer goes off. You weren't blocked. Your app's UI can keep running smoothly while it waits for data."
3.  **Dart's Async Tools:**
    * **`Future`:** "A `Future` is that **buzzer**. It's a promise that you'll get a value (your coffee) *in the future*."
    * **`async` / `await`:** "These keywords are special instructions for handling the buzzer."
        * `async`: Marks a function as one that can work with `Future`s.
        * `await`: Tells the function to "pause here and wait for this specific `Future` to complete before continuing," all without freezing the UI.
4.  **Quick Demo:** Live code a simple function using `Future.delayed` to simulate a 2-second network delay and show how `await` makes the code wait before printing a result.

---

## **Module 2: Talking to the Internet**

**Goal:** Fetch and parse real data from a public API.

1.  **What is an API? What is JSON?**
    * **API:** "An Application Programming Interface is like a **restaurant menu** for a server. It lists a set of defined requests you can make (e.g., `GET /users`) and describes what you'll get back."
    * **JSON:** "JSON (JavaScript Object Notation) is the language most APIs use to send data. It's just text organized with keys and values, which looks very similar to Dart `Map`s."
2.  **Choosing our API:** We will use **JSONPlaceholder** (`https://jsonplaceholder.typicode.com/`), a free and simple API for testing. We'll focus on the `/users` endpoint.
3.  **Live Coding: The Data Fetcher**
    * **Add Dependencies:** Show how to add the `http` package to `pubspec.yaml`.
    * **Create a Model Class:** Create a `User` class with properties like `id`, `name`, `email`. Add a factory constructor `User.fromJson(Map<String, dynamic> json)` that knows how to create a `User` object from a JSON map.
    * **Write the Fetch Function:** Create an `async` function, `Future<List<User>> fetchUsers()`. Inside, use `http.get()`, check the status code, `jsonDecode()` the body, and map the resulting list to your `User` model.

---

## **Module 3: Displaying API Data in the UI**

**Goal:** Show the fetched data in the UI and handle all possible states (loading, error, success) gracefully.

1.  **Introducing `FutureBuilder`:**
    * Explain that this is a core Flutter widget built specifically for this exact scenario. It takes a `Future` and a `builder` function. The `builder` function is re-run whenever the state of the `Future` changes.
2.  **Live Coding: Building the UI**
    * **Setup:** In a `StatefulWidget`, create a `late Future<List<User>> _usersFuture;` variable and initialize it in `initState()` by calling your `fetchUsers()` function.
    * **Implementation:**
        1.  Use the `FutureBuilder` widget in your `build` method and give it your `_usersFuture`.
        2.  In the `builder`, use an `if/else if/else` block to check `snapshot.connectionState`:
            * `if (snapshot.connectionState == ConnectionState.waiting)`: Return a centered `CircularProgressIndicator`.
            * `else if (snapshot.hasError)`: Return a `Text` widget showing the error.
            * `else if (snapshot.hasData)`: Use the `snapshot.data` (your `List<User>`) to build a `ListView.builder` that displays the name and email of each user.

---

## **Module 4: Homework & What's Next**

**Goal:** Have students practice the full async/API/UI loop with a different API endpoint.

* **🚀 Homework Task: The Photo Gallery App**
    * **Description:** "Build an app that fetches and displays a gallery of photos from the JSONPlaceholder API."
    * **API Endpoint:** `https://jsonplaceholder.typicode.com/photos`
    * **Requirements:**
        1.  Create a `Photo` model class with properties for `id`, `title`, and `thumbnailUrl`.
        2.  Create a service/function to fetch the `Future<List<Photo>>`.
        3.  Use a `FutureBuilder` to handle loading, error, and success states.
        4.  When the data is available, display the photos in a **`GridView`**. Each grid item should show the photo's thumbnail using the `Image.network(photo.thumbnailUrl)` widget.
