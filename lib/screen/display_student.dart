// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:student_profile/functions/db_functions.dart';
import 'package:student_profile/model/data_model.dart';
import 'package:student_profile/screen/Home.dart';

class DisplayScreen extends StatelessWidget {
  DisplayScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.mobNo,
      required this.email,
      required this.index});

  final String name;
  final String age;
  final String mobNo;
  final String email;
  final int index;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _NameController = TextEditingController(text: name);

    final _AgeController = TextEditingController(text: age);

    final _MobileController = TextEditingController(text: mobNo);

    final _EmailController = TextEditingController(text: email);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Student Details",
          ),
          centerTitle: true,
        ),
        body: (SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 84,
                    backgroundColor: Colors.purple,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  amal(NameController: _NameController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _AgeController,
                    decoration: const InputDecoration(
                        labelText: "Age", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Age reqired';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _MobileController,
                    decoration: const InputDecoration(
                        labelText: "Mob No", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _EmailController,
                    decoration: InputDecoration(
                        labelText: "$email", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email Id';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (ctx) {
                            return HomeScreen();
                          }));
                        }
                        StudentModel newStudentModel = StudentModel(
                            id: index,
                            name: _NameController.text,
                            age: _AgeController.text,
                            mobile: _MobileController.text,
                            email: _EmailController.text);
                        editStudentModel(index, newStudentModel);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            content: Text("Student updated")));
                      },
                      icon: const Icon(Icons.update),
                      label: const Text( 'Update',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}

class amal extends StatelessWidget {
  const amal({
    Key? key,
    required TextEditingController NameController,
  }) : _NameController = NameController, super(key: key);

  final TextEditingController _NameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _NameController,
      decoration: const InputDecoration(
          labelText: "Name", border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return 'name required';
        } else {
          return null;
        }
      },
    );
  }
}
