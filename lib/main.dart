import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_api/services/notes_service.dart';
import 'package:notes_api/views/note_list.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NoteService());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoteList(),
    );
  }
}
