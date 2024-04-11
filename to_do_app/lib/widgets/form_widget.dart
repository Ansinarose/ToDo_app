import 'package:flutter/material.dart';

class Form_Widget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool isEdit;
  final Function() submitData;
  final Function() updateData;

  const Form_Widget(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.isEdit,
      required this.submitData,
      required this.updateData});
  @override
  State<Form_Widget> createState() => _Form_WidgetState();
}

class _Form_WidgetState extends State<Form_Widget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: widget.titleController,
          decoration:
              InputDecoration(hintText: 'Title', border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: widget.descriptionController,
          decoration: InputDecoration(
              hintText: 'Description', border: OutlineInputBorder()),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            await widget.isEdit ? widget.updateData() : widget.submitData();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              minimumSize: MaterialStateProperty.all(Size(20, 50))),
          child: Text(
            widget.isEdit ? "Update" : "Submit",
            style:
                TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1),
          ),
        )
      ],
    );
  }
}