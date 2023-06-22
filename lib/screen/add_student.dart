import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_profile/functions/db_functions.dart';
import 'package:student_profile/model/data_model.dart';
import 'package:student_profile/screen/Home.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _mobileController = TextEditingController();

  final _emailController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: "Name", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(2)],
                  keyboardType: TextInputType.number,
                  controller: _ageController,
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
                  controller: _mobileController,
                  decoration: const InputDecoration(
                      labelText: "Mob No", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter number';
                    } else if (value.length != 10) {
                      return "Enter correct number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                    validator: ((value) =>
                        value!.isEmpty || !value.contains("@gmail.com")
                            ? "Enter a valid email"
                            : null)),
                const SizedBox(
                  height: 20,
                ),
                
                ElevatedButton.icon(
                    onPressed: () {
                      // print('buttonclicked');
                      onAddstudentButtonClicked();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          content: Text("added Student")));
                      if (formkey.currentState!.validate()) {
                        Navigator.pop(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const HomeScreen();
                        }));
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Students')),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return const HomeScreen();
                      }));
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddstudentButtonClicked() async {
    final Name = _nameController.text.trim();
    final Age = _ageController.text.trim();
    final Mobile = _mobileController.text.trim();
    final Email = _emailController.text.trim();
    if (Name.isEmpty || Age.isEmpty || Mobile.isEmpty || Email.isEmpty) {
      return;
    }

    final student =
        StudentModel(name: Name, age: Age, mobile: Mobile, email: Email);
    addStudent(student);
  }
}
