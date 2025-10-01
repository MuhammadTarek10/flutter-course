# 📝 Session 5 Homework: Enhance the Hive Notes App

## 🎯 Objective

Take the **Hive Notes App** we built during the workshop and enhance it by adding the ability to **delete** notes. This assignment will help you practice working with Hive boxes and understanding how keys work in NoSQL databases.

## 📋 Requirements

### Core Requirements (Must Complete)

1. **Add Delete Functionality**

   - In the `ListView` that displays the notes, add a delete `Icon` button to each note item
   - When the delete button is pressed for a specific note, it should be removed from the Hive box
   - The UI should update automatically to reflect the deletion

2. **Confirmation Dialog**

   - Show a confirmation dialog before deleting a note
   - Include the note title in the confirmation message
   - Provide "Cancel" and "Delete" options

3. **Visual Feedback**
   - Show a snackbar message after successful deletion
   - Include the deleted note's title in the message

### Bonus Requirements (Optional)

4. **Batch Delete**

   - Add checkboxes to each note item
   - Allow users to select multiple notes
   - Add a "Delete Selected" button in the app bar
   - Show count of selected notes

5. **Undo Functionality**

   - After deleting a note, show a snackbar with "Undo" action
   - Allow users to restore the deleted note within 5 seconds
   - Store the deleted note temporarily until the undo period expires

6. **Search and Filter**
   - Add a search bar to filter notes by title or content
   - Add filter options (e.g., recent notes, older notes)
   - Maintain delete functionality in filtered views

## 💡 Hints and Tips

### Understanding Hive Keys

When you use `box.add(note)`, Hive assigns an **auto-incrementing integer key** to each note. Here's how to work with keys:

```dart
// Adding a note (Hive assigns a key automatically)
int key = notesBox.add(newNote);
print('Note added with key: $key');

// Getting all notes with their keys
Map<dynamic, Note> notesMap = notesBox.toMap();
notesMap.forEach((key, note) {
  print('Key: $key, Title: ${note.title}');
});

// Deleting by key
notesBox.delete(key);

// Deleting by index (different from key!)
notesBox.deleteAt(index);
```

### Key vs Index - Important Difference!

- **Index**: Position in the list (0, 1, 2, 3...)
- **Key**: Unique identifier assigned by Hive (could be 0, 1, 3, 5... if some were deleted)

```dart
// ❌ Wrong way - using index as key
void deleteNote(int index) {
  notesBox.delete(index); // This might delete the wrong note!
}

// ✅ Correct way - get the actual key
void deleteNote(int index) {
  final note = notesBox.getAt(index);
  if (note != null) {
    note.delete(); // Uses the note's actual key
    // OR
    // notesBox.deleteAt(index); // Deletes by position
  }
}
```

### Recommended Approach

For this homework, you can use either approach:

1. **Simple approach**: Use `box.deleteAt(index)` - deletes by position
2. **Advanced approach**: Store and use actual keys for more robust deletion

## 🚀 Getting Started

1. **Copy the Hive Notes Demo**

   ```bash
   # Navigate to your session-5 app
   cd flutter/session-5/app

   # Make sure dependencies are installed
   flutter pub get

   # Generate the Note adapter (if not done already)
   flutter packages pub run build_runner build
   ```

2. **Start with the Core Requirements**

   - Focus on adding a simple delete button first
   - Test that deletion works correctly
   - Add confirmation dialog
   - Add visual feedback

3. **Test Thoroughly**
   - Add several notes
   - Delete notes from different positions
   - Restart the app to ensure changes persist
   - Test edge cases (deleting the last note, deleting all notes)

## 📁 File Structure

Your homework should modify these files:

```
flutter/session-5/app/lib/
├── 2_hive_notes_demo.dart          # Main file to modify
├── models/
│   ├── note.dart                   # Note model (might need updates)
│   └── note.g.dart                 # Generated adapter
└── main.dart                       # Navigation (no changes needed)
```

## 🧪 Testing Checklist

Before submitting, make sure you can:

- [ ] Add new notes successfully
- [ ] Delete notes using the delete button
- [ ] See confirmation dialog before deletion
- [ ] Cancel deletion from the dialog
- [ ] Confirm deletion and see the note disappear
- [ ] See success message after deletion
- [ ] Restart app and verify deleted notes don't reappear
- [ ] Delete multiple notes in sequence
- [ ] Delete the first, middle, and last notes

## 📤 Submission

1. **Test your app thoroughly** using the checklist above
2. **Take screenshots** of:
   - The notes list with delete buttons
   - The confirmation dialog
   - The success message after deletion
3. **Document any issues** you encountered and how you solved them
4. **Optional**: Record a short video demo of the delete functionality

## 🆘 Need Help?

### Common Issues and Solutions

**Issue**: "Note adapter not found"

```bash
# Solution: Generate the adapter
flutter packages pub run build_runner build
```

**Issue**: "Wrong note gets deleted"

```dart
// Problem: Using wrong index/key
void deleteNote(int index) {
  notesBox.delete(index); // ❌ Wrong!
}

// Solution: Use deleteAt for position-based deletion
void deleteNote(int index) {
  notesBox.deleteAt(index); // ✅ Correct!
}
```

**Issue**: "UI doesn't update after deletion"

```dart
// Make sure you're using ValueListenableBuilder
ValueListenableBuilder(
  valueListenable: notesBox.listenable(), // ✅ This auto-updates UI
  builder: (context, Box<Note> box, _) {
    // Your ListView.builder here
  },
)
```

### Resources

- [Hive Documentation](https://docs.hivedb.dev/)
- [Flutter Material Design](https://flutter.dev/docs/development/ui/widgets/material)
- [Confirmation Dialogs in Flutter](https://flutter.dev/docs/cookbook/design/dialogs)

## 🏆 Evaluation Criteria

Your homework will be evaluated on:

1. **Functionality** (60%)

   - Delete buttons appear on each note
   - Deletion works correctly
   - Confirmation dialog appears
   - UI updates automatically

2. **Code Quality** (25%)

   - Clean, readable code
   - Proper error handling
   - Good variable naming
   - Appropriate comments

3. **User Experience** (15%)
   - Intuitive interface
   - Clear feedback messages
   - Smooth interactions
   - Proper confirmation flow

## 🌟 Bonus Points

- Implement any of the bonus requirements
- Add creative enhancements (animations, themes, etc.)
- Write clear documentation of your changes
- Demonstrate understanding of Hive concepts in comments

---

**Good luck with your homework! Remember, the goal is to practice working with Hive and understand how NoSQL databases handle data deletion. Take your time and don't hesitate to experiment!** 🚀

## 📚 Additional Learning Resources

### Hive Deep Dive

- Understanding Hive boxes as "filing cabinets"
- How auto-incrementing keys work
- When to use `delete()` vs `deleteAt()`
- Best practices for data management

### Flutter UI Patterns

- Confirmation dialogs
- Snackbar messages
- ListView item interactions
- State management with databases

### Next Steps

After completing this homework, you'll be ready to:

- Build more complex data models
- Implement data relationships
- Add data validation
- Explore advanced Hive features (encryption, compaction, etc.)
