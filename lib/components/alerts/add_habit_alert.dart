import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddNewHabit extends StatefulWidget {
  final void Function(String description) onAdd;
  const AddNewHabit({super.key, required this.onAdd});

  @override
  State<AddNewHabit> createState() => _AddNewHabitState();

  static void show(BuildContext context, void Function(String title) onAdd) {
    Alert(
      context: context,
      title: "Add Habit",
      content: AddNewHabit(onAdd: onAdd),
      buttons: [],
    ).show();
  }
}

class _AddNewHabitState extends State<AddNewHabit> {

  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _submit() {
    final title = _controller.text.trim();
    if (title.isEmpty) {
      setState(() => _errorText = "Description cannot be empty");
    } else {
      widget.onAdd(title);
      Navigator.pop(context); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          maxLength: 25,
          decoration: InputDecoration(
            icon: const Icon(Icons.note_add),
            labelText: 'Habit Description',
            errorText: _errorText,
          ),
          autofocus: true,
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text("Add"),
        ),
      ],
    );
  }
}