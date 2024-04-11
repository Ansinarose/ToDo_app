// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AddToDoPage extends StatefulWidget {
//   const AddToDoPage({super.key});

//   @override
//   State<AddToDoPage> createState() => _AddToDoPageState();
// }

// class _AddToDoPageState extends State<AddToDoPage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add ToDo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children:  [
//              TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 hintText: 'Title'
//               ),
//             ),
//             const SizedBox(height: 20,),
//              TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 hintText: 'Description',
            
//               ),
//               keyboardType: TextInputType.multiline,
//               minLines: 5,
//               maxLines: 8,
//             ),
//             const SizedBox(height: 20,),
//             ElevatedButton(
//               onPressed: () {
//                 submitDta();

//               },
//                child: const Text('Submit'))
//           ],
//         ),
//       ),
//     );
//   }



//  Future<void> submitDta() async{
//     //get the data from form
//    final title = titleController.text;
//    final description = descriptionController.text;
//    final body = {
    
//   "title": title,
//   "description": description,
//   "is_completed": false,

//    };
//     //submit data to the server
//     // ignore: unused_local_variable, prefer_const_declarations
//     final url = 'https://api.nstack.in/v1/todos';
//     final uri = Uri.parse(url);
    
//     // final response = await http.post(uri,
//     // body: jsonEncode(body),
//     // headers:{'Content-Type': 'application/json'},);
  
//     //show sucess or fail message based the status
//     final isSuccess = await 
    
//     if(){
//    showSuccessMessage('Creation is success');
//     } else {
//       showErrorMessage('Creation is failed');
//     }
//   }
//   void showSuccessMessage(String message){
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//   void showErrorMessage(String message){
//     final snackBar = SnackBar(content: Text(message,
//     style: const TextStyle(
//       color: Colors.white,backgroundColor: Colors.red
//     ),
    
//     ));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }


import 'package:flutter/material.dart';
import 'package:to_do_app/services/service.dart';
import 'package:to_do_app/widgets/form_widget.dart';


class AddTodo_Page extends StatefulWidget {
  final Map? todo;

  const AddTodo_Page({super.key, this.todo});
  @override
  State<AddTodo_Page> createState() => _AddTodo_PageState();
}

class _AddTodo_PageState extends State<AddTodo_Page> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    final todo = widget.todo;
    if (widget.todo != null) {
      isEdit = true;
      final title = todo!['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          isEdit ? "Edit ToDo List" : "Add ToDo List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Form_Widget(
                titleController: titleController,
                descriptionController: descriptionController,
                isEdit: isEdit,
                submitData: submitData,
                updateData: updateData,
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("You can not updated without todo data");
      return;
    }
    final id = todo['_id'];

    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final isSuccess = await TodoService.updateData(id, body);

    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("Updated Successfully !");
    } else {
      showErrorMessage("Updation Failed !");
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final isSuccess = await TodoService.submitData(body);
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("Created Successfully !");
    } else {
      showErrorMessage("creation Failed !");
    }
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}