# 📝 Session 6 Homework: The Registration Form

## 🎯 Objective

Build a complete user registration screen that demonstrates all the concepts learned in Session 6. This assignment will help you practice form building, validation, and user input handling in a real-world scenario.

## 📋 Requirements

### Core Requirements (Must Complete)

#### 1. **Form Structure**

- Create a single `Form` widget with a `GlobalKey<FormState>`
- All input fields must be children of this Form widget
- Use proper form validation and submission flow

#### 2. **Required Form Fields**

**Full Name Field:**

- Use `TextFormField`
- Validation: Not empty, at least 2 characters, letters and spaces only
- Proper capitalization (TextCapitalization.words)

**Email Field:**

- Use `TextFormField`
- Keyboard type: `TextInputType.emailAddress`
- Validation: Not empty, valid email format (contains @ and .)
- Case-insensitive input

**Password Field:**

- Use `TextFormField` with `obscureText: true`
- Include password visibility toggle button
- Validation: Not empty, minimum 6 characters
- Show/hide password functionality

**Country Selection:**

- Use `DropdownButtonFormField<String>`
- Provide at least 5 country options
- Validation: Must select a country
- Default value: null (no selection)

**Terms and Conditions:**

- Use `CheckboxListTile`
- Title: "I agree to the terms and conditions"
- Must be checked to proceed (custom validation)

#### 3. **Form Validation**

- All fields must have proper validation rules
- Validation should occur when "Register" button is pressed
- Show appropriate error messages for each field
- Terms checkbox must be validated separately (not a TextFormField)

#### 4. **Form Submission**

- "Register" button that validates the entire form
- If valid: show success message with collected data
- If invalid: show error message
- Use `SnackBar` or `Dialog` for feedback

## 🌟 Bonus Requirements (Optional)

#### 5. **Enhanced Validation**

- Email: Use regex for comprehensive email validation
- Password: Require uppercase, lowercase, and number
- Name: Prevent numbers and special characters
- Phone number field with formatting

#### 6. **User Experience Improvements**

- Loading state during form submission (simulate 2-3 second delay)
- Form reset functionality after successful submission
- Clear visual feedback for all user actions
- Proper input decorations with icons and helper text

#### 7. **Advanced Features**

- Confirm password field with matching validation
- Age field with numeric validation (13-120 years)
- Profile picture selection (placeholder functionality)
- Terms and conditions link (show dialog with dummy text)

## 💡 Implementation Hints

### Form Key Usage

```dart
final _formKey = GlobalKey<FormState>();

// In your submit method:
if (_formKey.currentState!.validate()) {
  _formKey.currentState!.save();
  // Process form data
}
```

### Validation Examples

```dart
// Name validation
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters';
  }
  return null; // Valid
}

// Email validation
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Please enter a valid email';
  }
  return null;
}
```

### Checkbox Validation

```dart
// Since CheckboxListTile doesn't have validator property
void _submitForm() {
  if (!_agreedToTerms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You must agree to terms')),
    );
    return;
  }

  if (_formKey.currentState!.validate()) {
    // Process form
  }
}
```

## 📁 File Structure

Create your homework in a new file:

```
flutter/session-6/app/lib/
├── main.dart                    # Navigation (no changes needed)
├── 1_form_widgets_demo.dart     # Workshop files (reference only)
├── 2_text_validation_demo.dart  # Workshop files (reference only)
├── 3_login_form_demo.dart       # Workshop files (reference only)
├── 4_registration_form_solution.dart # Solution (don't peek!)
└── homework_registration_form.dart   # YOUR HOMEWORK FILE
```

## 🧪 Testing Checklist

Before submitting, make sure you can:

### Form Validation

- [ ] Submit empty form and see all validation errors
- [ ] Enter invalid email and see email error
- [ ] Enter short password and see password error
- [ ] Enter invalid name and see name error
- [ ] Leave country unselected and see dropdown error
- [ ] Leave terms unchecked and see checkbox error

### Successful Submission

- [ ] Fill all fields correctly
- [ ] Check terms and conditions
- [ ] Submit form successfully
- [ ] See success message with form data
- [ ] Form resets after successful submission

### User Experience

- [ ] Password visibility toggle works
- [ ] Loading state shows during submission
- [ ] All input fields have proper labels and hints
- [ ] Error messages are clear and helpful

## 🎨 UI Guidelines

### Visual Design

- Use consistent spacing (16px between fields)
- Add proper icons to input fields
- Use Cards or containers to group related elements
- Implement a clean, professional design

### Color Scheme

- Primary color for buttons and accents
- Red for error messages
- Green for success feedback
- Grey for helper text and placeholders

### Typography

- Clear, readable fonts
- Proper text sizes for labels and content
- Bold text for important elements (titles, buttons)

## 📤 Submission Guidelines

### Code Quality

1. **Clean Code**: Use meaningful variable names and proper formatting
2. **Comments**: Add comments explaining complex validation logic
3. **Error Handling**: Handle all edge cases gracefully
4. **Dispose**: Properly dispose controllers in dispose() method

### Documentation

1. **Screenshots**: Take screenshots of your completed form
2. **Testing**: Document any issues you encountered and how you solved them
3. **Bonus Features**: List any bonus features you implemented

### File Naming

- Main homework file: `homework_registration_form.dart`
- Screenshots: `registration_form_screenshot_1.png`, etc.

## 🆘 Need Help?

### Common Issues and Solutions

**"Form doesn't validate"**

```dart
// Make sure you're using TextFormField, not TextField
TextFormField(
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)
```

**"Checkbox validation not working"**

```dart
// CheckboxListTile doesn't have validator property
// Handle validation manually in submit method
if (!_agreedToTerms) {
  // Show error message
  return;
}
```

**"Controllers not disposing"**

```dart
@override
void dispose() {
  _nameController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
```

### Resources

- [Flutter Form Documentation](https://flutter.dev/docs/cookbook/forms)
- [TextFormField Class](https://api.flutter.dev/flutter/material/TextFormField-class.html)
- [Form Validation Guide](https://flutter.dev/docs/cookbook/forms/validation)

## 🏆 Evaluation Criteria

Your homework will be evaluated on:

### Functionality (40%)

- All required fields implemented correctly
- Proper validation for all inputs
- Form submission works as expected
- Terms checkbox validation implemented

### Code Quality (30%)

- Clean, readable code structure
- Proper use of controllers and keys
- Appropriate widget choices
- Good error handling

### User Experience (20%)

- Professional, polished UI
- Clear feedback for user actions
- Intuitive form flow
- Proper loading states

### Validation Logic (10%)

- Comprehensive validation rules
- Clear, helpful error messages
- Edge cases handled properly
- Custom validation implemented correctly

## 🌟 Bonus Points

- Implement any of the bonus requirements
- Add creative enhancements (animations, custom styling)
- Write comprehensive comments explaining your approach
- Create additional validation rules beyond requirements
- Implement accessibility features

---

**Good luck with your homework! Remember, the goal is to practice building professional forms with proper validation. Take your time and focus on creating a great user experience.** 🚀

## 📚 Key Learning Outcomes

After completing this homework, you should be able to:

### Form Management

- Create and manage forms with GlobalKey
- Implement comprehensive form validation
- Handle form submission and data collection
- Provide appropriate user feedback

### Input Widgets

- Use various input widgets appropriately
- Implement custom validation logic
- Handle different input types and keyboards
- Manage widget state effectively

### User Experience

- Design intuitive form interfaces
- Provide clear error messages and guidance
- Implement loading states and feedback
- Create professional, polished UIs

### Best Practices

- Properly dispose of resources
- Handle edge cases gracefully
- Write clean, maintainable code
- Follow Flutter form conventions

**Happy coding! 🎉**
