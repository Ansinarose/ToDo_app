import 'package:flutter/material.dart';

class Cart_Widget extends StatefulWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditpage;
  final Function(String) deleteBYId;
  final String id;

  const Cart_Widget(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateToEditpage,
      required this.deleteBYId,
      required this.id});
  @override
  State<Cart_Widget> createState() => _Cart_WidgetState();
}

class _Cart_WidgetState extends State<Cart_Widget> {
  @override
  Widget build(BuildContext context) {
    final id = widget.item['_id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${widget.index + 1}')),
        title: Text(
          widget.item['title'],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(widget.item['description']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              widget.navigateToEditpage(widget.item);
            } else if (value == 'delete') {
              widget.deleteBYId(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              )
            ];
          },
        ),
      ),
    );
  }
}