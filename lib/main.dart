import 'package:flutter/material.dart';
import 'package:listaplus/pages/splash_screen.dart';
part 'src/theme/material_scheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    MaterialTheme theme = const MaterialTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode:  ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// void main() {
//   runApp(TodoApp());
// }

// class Task {
//   String title;
//   bool isCompleted;

//   Task({required this.title, this.isCompleted = false});

//   Map<String, dynamic> toJson() => {
//         'title': title,
//         'isCompleted': isCompleted,
//       };

//   static Task fromJson(Map<String, dynamic> json) => Task(
//         title: json['title'],
//         isCompleted: json['isCompleted'],
//       );
// }

// class PreferencesService {
//   Future<void> saveTasks(List<Task> tasks) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String encodedData =
//         json.encode(tasks.map((task) => task.toJson()).toList());
//     await prefs.setString('tasks', encodedData);
//   }

//   Future<List<Task>> getTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? tasksString = prefs.getString('tasks');
//     if (tasksString != null) {
//       final List<dynamic> decodedData = json.decode(tasksString);
//       return decodedData.map((json) => Task.fromJson(json)).toList();
//     }
//     return [];
//   }
// }

// class TodoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'To-Do List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TodoListPage(),
//     );
//   }
// }

// class TodoListPage extends StatefulWidget {
//   @override
//   _TodoListPageState createState() => _TodoListPageState();
// }

// class _TodoListPageState extends State<TodoListPage> {
//   List<Task> _tasks = [];
//   final PreferencesService _preferencesService = PreferencesService();
//   final TextEditingController _taskController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     List<Task> tasks = await _preferencesService.getTasks();
//     setState(() {
//       _tasks = tasks;
//     });
//   }

//   Future<void> _addTask() async {
//     if (_taskController.text.isNotEmpty) {
//       setState(() {
//         _tasks.add(Task(title: _taskController.text));
//         _taskController.clear();
//       });
//       await _preferencesService.saveTasks(_tasks);
//     }
//   }

//   Future<void> _removeTask(int index) async {
//     setState(() {
//       _tasks.removeAt(index);
//     });
//     await _preferencesService.saveTasks(_tasks);
//   }

//   Future<void> _toggleTaskCompletion(int index) async {
//     setState(() {
//       _tasks[index].isCompleted = !_tasks[index].isCompleted;
//     });
//     await _preferencesService.saveTasks(_tasks);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To-Do List'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _taskController,
//               decoration: InputDecoration(labelText: 'Nova Task'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _addTask,
//               child: Text('Add Task'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _tasks.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       _tasks[index].title,
//                       style: TextStyle(
//                         decoration: _tasks[index].isCompleted
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                       ),
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             _tasks[index].isCompleted
//                                 ? Icons.check_box
//                                 : Icons.check_box_outline_blank,
//                           ),
//                           onPressed: () => _toggleTaskCompletion(index),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _removeTask(index),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
