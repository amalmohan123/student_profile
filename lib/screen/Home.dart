import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_profile/functions/db_functions.dart';
import 'package:student_profile/model/data_model.dart';
import 'package:student_profile/screen/add_student.dart';
import 'package:student_profile/screen/display_student.dart';
import 'package:student_profile/screen/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    log("message");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Students'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext context, List<StudentModel> studentList,
                  Widget? child) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    return ListTile(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => DisplayScreen(
                                  name: data.name,
                                  age: data.age,
                                  mobNo: data.mobile,
                                  email: data.email,
                                  index: index,
                                )),
                          ),
                        );
                      }),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                      ),
                      title: Text(data.name),
                      subtitle: Text(data.age),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  content: const Text("Are sure to delete"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          deleteStudent(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes"))
                                  ],
                                );
                              }),
                            );
                          },
                          icon: const Icon(Icons.delete_outline_rounded)),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: studentList.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return const SecondScreen();
              }),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}
