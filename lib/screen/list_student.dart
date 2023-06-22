// import 'package:flutter/material.dart';

// import 'package:student_profile/functions/db_functions.dart';

// import '../model/data_model.dart';

// class AddStudentwidget extends StatelessWidget {
//   const AddStudentwidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     getAllStudents();

//     return ValueListenableBuilder(
//       valueListenable: studentListNotifier,
//       builder: (BuildContext context, List<StudentModel> studentList,
//           Widget? child) {
//         return ListView.separated(
//           itemBuilder: (context, index) {
//             final data = studentList[index];
//             return ListTile(
//               onTap: (() {}),
//               title: Text(data.name),
//               subtitle: Text(data.age),
//               trailing: IconButton(
//                   onPressed: () {
//                     deleteStudent(index);
//                     print("");
//                   },
//                   icon: Icon(Icons.delete)),
//             );
//           },
//           separatorBuilder: (ctx, index) {
//             return const Divider();
//           },
//           itemCount: studentList.length,
//         );
//       },
//     );
//   }
// }
