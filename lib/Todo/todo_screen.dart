import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_interview/Todo/todo_controller.dart';

List itemList = List.generate(60, (index) => (index + 1).toString());

// class TodoScreen extends StatefulWidget {
//   const TodoScreen({super.key});
//
//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }

class TodoScreen extends StatelessWidget {
  TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Form(
                      key: todoController.scaffoldKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: todoController.titleController,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Please Enter Title';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Title',
                              labelText: 'Title',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: todoController.descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Description',
                              labelText: 'Description',
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: itemList.first,
                            items: itemList.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              todoController.dropdownValue = value as String;
                            },
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              todoController.showColorPicker();
                            },
                            child: const Text(
                              'Pick Color',
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              todoController.validationOnTap();
                            },
                            child: const Text('Add TODO'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<TodoController>(
        id: 'todoGridData',
        builder: (context) {
          return todoController.todoDataList.isEmpty
              ? const SizedBox()
              : GridView.builder(
                  itemCount: todoController.todoDataList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      color: todoController.todoDataList[index]['task'],
                      child: Text(todoController.todoDataList[index]['title']),
                    );
                  },
                );
        },
      ),
    );
  }
}

// Dialog todoDialog(){
//   return
// }
