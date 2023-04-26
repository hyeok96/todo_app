import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/todo_model.dart';
import '../widgets/tfilter_bottom_sheet.dart';
import '../widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();

  List<TodoModel> todos = [];

  TodoFilter _todoFilter = TodoFilter.all;

  Future<List<TodoModel>> getTodos() async {
    var res = await dio.get("https://jsonplaceholder.typicode.com/todos");
    if (res.statusCode == 200) {
      var todoList = List<Map<String, dynamic>>.from(res.data);
      todos = todoList.map((e) => TodoModel.fromMap(e)).toList();
      return todos;
    }
    return [];
  }

  List<TodoModel> _todoList(List<TodoModel> list) {
    if (_todoFilter == TodoFilter.all) {
      return list;
    }
    if (_todoFilter == TodoFilter.completed) {
      return list.where((element) => element.completed == true).toList();
    }
    if (_todoFilter == TodoFilter.incompleted) {
      return list.where((element) => element.completed == false).toList();
    }
    return [];
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return FilterBottomSheet(
                      filter: _todoFilter,
                      onApply: (TodoFilter todoFilter) {
                        _todoFilter = todoFilter;
                        setState(() {});
                      });
                },
              );
            },
            icon: const Icon(
              Icons.filter_alt,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh_sharp,
            ),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: todos.length,
      //   itemBuilder: (context, index) {
      //     return TodoCard(
      //       todoModel: todos[index],
      //     );
      //   },
      // ),
      body: FutureBuilder(
        future: getTodos(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _todoList(todos).length,
            itemBuilder: (context, index) {
              return TodoCard(
                todoModel: _todoList(todos)[index],
              );
            },
          );
        },
      ),
    );
  }
}
