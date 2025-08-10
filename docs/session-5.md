# Session 5: Saving Data Locally

### 🎯 Core Objectives:

- Understand why local storage is essential for a good user experience.
- Learn to use `shared_preferences` for simple key-value data.
- Grasp the core differences between SQL and NoSQL databases.
- Get hands-on experience with a modern NoSQL database (`Hive`).
- Be introduced to the power of SQL databases with `sqflite`.

### ✅ Prerequisites:

- Comfortable with state management and building multi-screen apps (from Session 3 & 4).

---

### **Module 1: The "Why" & The Simplest Solution (45 minutes)**

**Goal:** Explain the need for persistence and get a quick, practical win with `shared_preferences`.

1.  **The Problem of "App Amnesia":**
    - Start by running an app from a previous session. Change its state (e.g., increment a counter), then close and restart the app to show that the state is lost.
    - Explain the problem: _"Our app has amnesia. It forgets everything as soon as it closes. We need to give it a memory."_ This is what local storage does.
2.  **Introducing `shared_preferences`:**
    - **Analogy:** "Think of `shared_preferences` as a small, simple **notepad** for your app. It's perfect for saving simple settings, like a user's name, a high score, or whether dark mode is on. It's not designed for large, complex data."
3.  **Live Coding: The Theme Switcher**
    - Build a simple app with a `Switch` widget that toggles between light and dark mode.
    - When the switch is toggled, save the boolean value to `shared_preferences` with a key like `'isDarkMode'`.
    - When the app starts, read the value for that same key to set the initial theme. This provides a tangible result: the theme choice is saved between app launches.

---

### **Module 2: Database Fundamentals**

**Goal:** Teach the core conceptual difference between SQL and NoSQL before diving into code.

1.  **SQL (Relational Databases):**
    - **Analogy:** "SQL databases like `sqflite` are like a perfectly organized **Excel spreadsheet**. You must define your columns (`id`, `name`, `email`) upfront. Every row must follow that exact structure. It's rigid, powerful, and great for highly structured data."
2.  **NoSQL (Non-Relational Databases):**
    - **Analogy:** "NoSQL databases like `Hive` are like a **filing cabinet full of folders**. Each folder has a unique label (a key), but inside, you can store whatever you want—a document, a photo, a list. It's flexible and great for storing whole objects without a strict schema."
3.  **When to use which?**
    - **SQL:** Use when your data is very structured and has complex relationships (e.g., users, posts, comments all linking together).
    - **NoSQL:** Use when you want to store entire Dart objects quickly and your data structure might change over time.

---

### **Module 3: Hands-On with Hive (A NoSQL Database)**

**Goal:** Learn to save and retrieve entire Dart objects using the fast and efficient Hive database.

1.  **Introduce Hive:** Explain it as a pure-Dart, key-value NoSQL database that's very popular in the Flutter community for its speed and simplicity.
2.  **Live Coding: The "Quick Notes" App**
    - **Setup:** Guide them through adding the `hive` and `hive_flutter` dependencies.
    - **Data Model:** Create a simple `Note` class.
    - **Type Adapters:** Show how to annotate the class with `@HiveType` and `@HiveField` and run the build runner command to automatically generate the `TypeAdapter`. Explain that this adapter teaches Hive how to read/write the `Note` object.
    - **Implementation:**
      1.  Initialize Hive in the `main()` function.
      2.  Open a Hive "box" (our filing cabinet).
      3.  Build a UI to add new notes and display all existing notes from the box in a `ListView`.
      4.  When a new note is added, create a `Note` object and save it to the box using `notesBox.add(newNote)`.
      5.  Use a `ValueListenableBuilder` to listen for changes to the box and automatically update the UI.

---

### **Module 4 (Optional): Intro to `sqflite` & Homework**

**Goal:** Give students an awareness of `sqflite`'s power and assign a relevant homework task.

1.  **A Glimpse into `sqflite`:**
    - **Demonstration:** Briefly show the "Quick Notes" app built using `sqflite`.
    - **Highlight the Differences:** Point out that with `sqflite`, you must write raw SQL commands as strings: `CREATE TABLE`, `INSERT`, `QUERY`.
    - **💡 Tip & Trick:** Mention that `sqflite` is the foundation for easier-to-use packages like `Drift` or `Floor`, which are great topics for self-study.
2.  **🚀 Homework Task: Enhance the Hive Notes App**
    - **Description:** "Take the 'Quick Notes' app we built in the session with **Hive**. Your mission is to add the ability to **delete** notes."
    - **Requirements:**
      1.  In the `ListView` that displays the notes, add a delete `Icon` button to each note item.
      2.  When the delete button is pressed for a specific note, it should be removed from the Hive box.
      3.  The UI should update automatically to reflect the deletion.
    - **Hint:** The `delete` method on a Hive box requires a `key`. When you used `box.add()`, Hive assigned an auto-incrementing integer key. Think about how you can access that key when you build your `ListView`.
