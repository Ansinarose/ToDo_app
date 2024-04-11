// import 'package:flutter/material.dart';
// import 'package:to_do_app/screens/add_page.dart';


// class TodoListPage extends StatefulWidget {
//   const TodoListPage({super.key});

//   @override
//   State<TodoListPage> createState() => _TodoListPageState();
// }

// class _TodoListPageState extends State<TodoListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Todo List'),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: (){
//           navigateToAddPage();
//         }, label: const Text('Add Todo')),
//     );
//   }


//   void navigateToAddPage(){
//     final route = MaterialPageRoute(
//       builder: (context) => const AddToDoPage());
//       Navigator.push(context, route);
//   }
  
// }
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/add_page.dart';
import 'package:to_do_app/services/service.dart';
import 'package:to_do_app/widgets/card_widget.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  bool isLoading = true;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "ToDo List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          shape: CircleBorder(),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return AddTodo_Page();
            }));
            isLoading = true;
            fetchData();
          },
          label: Text(
            'Add +',
            style: TextStyle(color: Colors.white),
          )),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No Data",
                style: TextStyle(fontSize: 18),
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'] as String;
                  return Cart_Widget(
                      id: id,
                      index: index,
                      item: item,
                      navigateToEditpage: navigateToEditpage,
                      deleteBYId: deleteBYId);
                }),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToEditpage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo_Page(
        todo: item,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> deleteBYId(String id) async {
    final success = await TodoService.deleteBYId(id);
    if (success) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
  }

  Future<void> fetchData() async {
    final response = await TodoService.fetchData();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }
}