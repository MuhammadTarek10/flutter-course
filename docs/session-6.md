# Session 6: Building Forms & Handling User Input

## 🎯 Core Objectives

- Learn to use a variety of input widgets like `TextField`, `Checkbox`, `Switch`, and `DropdownButton`.
- Understand how to manage the state of form fields using controllers and `setState`.
- Implement robust user input validation.
- Master the `Form` widget and `GlobalKey` to manage the state of an entire form at once.

## ✅ Prerequisites

- A solid understanding of `StatefulWidget` and `setState`.

---

## **Module 1: The Building Blocks of a Form**

**Goal:** Introduce the most common input widgets and how to manage their individual state.

1.  **Why Forms?**
    - Briefly explain that forms are the primary way we gather structured data from users, from a simple search bar to a complex registration page.
2.  **Introducing Input Widgets:**
    - **Analogy:** "Think of a form as a survey. Flutter gives us different types of questions we can ask: open-text questions, yes/no questions, multiple-choice questions, etc."
3.  **Live Coding: A Widget Sampler**
    - **Action:** Create a new screen and add each of these widgets, explaining how to manage their value.
    - **`TextField`:** The most basic text input. Show the `decoration` property and `InputDecoration` for adding labels and hints.
    - **`CheckboxListTile`:** A checkbox with a title. Manage its state with a `bool _isChecked = false;` and `setState`.
    - **`SwitchListTile`:** A switch with a title. Also managed with a `bool`.
    - **`DropdownButtonFormField`:** A dropdown menu. Manage its state with a nullable `String? _selectedValue;`. Show how to populate its `items` from a `List<String>`.

---

## **Module 2: Mastering Text Input & Validation**

**Goal:** Do a deep dive into handling text input professionally with controllers and validation.

1.  **The `TextEditingController`:**
    - Explain the need for it: "Instead of just listening for changes, a controller gives us full remote control over the `TextField`. We can use it to get the text, set the text, or even move the cursor."
    - **Action:** Refactor the earlier `TextField` to use a `TextEditingController`. Show how to access its value with `_myController.text`.
2.  **Input Validation:**
    - Introduce `TextFormField`: Explain that this is a special version of `TextField` that's designed to work inside a `Form`. Its most important feature is the `validator` property.
    - **How it works:** Explain that the `validator` is a function that receives the field's current value.
      - If the value is valid, the function must return `null`.
      - If the value is invalid, it should return a `String` containing the error message to display.
    - **Live Coding:** Add validation to a `TextFormField` for common cases: checking if a field is empty, if an email contains an `'@'` symbol, or for a minimum password length.

---

## **Module 3: The `Form` Widget - The Team Captain**

**Goal:** Show how to manage validation and submission for the entire form at once.

1.  **Why the `Form` Widget?**
    - Explain the problem: "Validating 10 different fields one by one would be a nightmare. The `Form` widget acts as a 'team captain' that can check the status of all its fields at once."
2.  **Introducing `GlobalKey<FormState>`:**
    - **Analogy:** "A `GlobalKey` is like a **permanent, unique ID card** for a specific widget. We give our `Form` this ID card so we can find it and talk to it from anywhere in our widget tree, specifically from our 'Submit' button."
3.  **Live Coding: Building a Login Form**
    - **Action:**
      1.  Wrap the `TextFormField`s for email and password inside a `Form` widget.
      2.  Create and assign the `GlobalKey`: `final _formKey = GlobalKey<FormState>();`.
      3.  Create a "Login" `ElevatedButton`.
      4.  In the button's `onPressed`, use the key to manage the form: `if (_formKey.currentState!.validate()) { ... }`.
      5.  If valid, show how to save the form data using `_formKey.currentState!.save()`, which calls the `onSaved` callback on each form field.
      6.  Process the saved data (e.g., print it or show it in a dialog).

---

## **Module 4: Homework & What's Next**

- **🚀 Homework Task: The Registration Form**
  - **Description:** "Build a complete user registration screen. This form must collect and validate several pieces of information."
  - **Fields Required:**
    - Full Name (`TextFormField`)
    - Email (`TextFormField`)
    - Password (`TextFormField` with `obscureText: true`)
    - A `DropdownButtonFormField` for "Country".
    - A `CheckboxListTile` for "I agree to the terms and conditions."
  - **Requirements:**
    1.  All input fields must be wrapped in a single `Form` widget with a `GlobalKey`.
    2.  Implement validation for every field (e.g., not empty, valid email, password length > 6 characters). The "Terms" checkbox **must** be checked to be valid.
    3.  A "Register" button that only proceeds if the entire form is valid. When valid, show a `SnackBar` or `Dialog` with a "Registration Successful!" message.
