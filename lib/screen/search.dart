import 'package:flutter/material.dart';
import 'package:student_profile/functions/db_functions.dart';
import 'package:student_profile/screen/display_student.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: (() {
          query = "";
        }),
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (() {
        close(context, query);
      }),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: ((context, studentLIst, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final data = studentLIst[index];
              if (data.name.toLowerCase().contains(
                    query.toLowerCase(),
                  )) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => DisplayScreen(
                                name: data.name,
                                age: data.age,
                                mobNo: data.mobile,
                                email: data.email,
                                index: index)),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                const Text('no data found');
                return const SizedBox();
              }
            },
            itemCount: studentLIst.length,
          );
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: ((context, studentLIst, child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentLIst[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => DisplayScreen(
                              name: data.name,
                              age: data.age,
                              mobNo: data.mobile,
                              email: data.email,
                              index: index)),
                        ),
                      );
                    },
                    title: Text(data.name),
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1606041008023-472dfb5e530f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const SizedBox();
            }
          },
          itemCount: studentLIst.length,
        );
      }),
    );
  }
}
