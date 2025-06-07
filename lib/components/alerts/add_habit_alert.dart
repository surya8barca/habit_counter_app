import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddNewHabit extends StatefulWidget {
  final void Function(String description, String habitType) onAdd;
  const AddNewHabit({super.key, required this.onAdd});

  @override
  State<AddNewHabit> createState() => _AddNewHabitState();

  static void show(BuildContext context,
      void Function(String description, String habitType) onAdd) {
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
  String _selectedType = 'overall';
  List<String> _counterTypes = ['daily', 'overall'];

  void _submit() {
    final description = _controller.text.trim();
    if (description.isEmpty) {
      setState(() => _errorText = "Description cannot be empty");
    } else {
      widget.onAdd(description, _selectedType);
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
        DropdownButton<String>(
          value: _selectedType,
          hint: const Text("Select Type"),
          isExpanded: true,
          items: _counterTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value[0].toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue!;
            });
          },
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
