import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_interview/Todo/todo_screen.dart';

class TodoController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  String selectedDropDownValue = '';
  String dropdownValue = itemList.first;
  List todoDataList = [];
  Color selectedColor = Colors.blue;

  void showColorPicker() {
    ColorPicker(
      color: selectedColor,
      onColorChanged: (Color color) {
        // setState(() {
        //   selectedColor = color;
        // });
        selectedColor = color;
      },
    ).showPickerDialog(
      Get.context!,
    );
  }

  void validationOnTap() {
    if (scaffoldKey.currentState!.validate()) {
      Map todo = {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'duration': dropdownValue,
        'task': selectedColor,
      };
      todoDataList.add(todo);
      titleController.clear();
      descriptionController.clear();
      dropdownValue = itemList.first;
      selectedColor = Colors.blue;
      update(['todoGridData']);
      Get.back();
    } else {
      Get.snackbar(
        'Added Failed',
        "Enter Valid Data",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    }
    // update(['todoGridData']);
  }
}
