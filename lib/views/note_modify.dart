import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_api/services/notes_service.dart';

import '../models/note.dart';

class NoteModify extends StatefulWidget {
  const NoteModify({Key? key, this.noteID}) : super(key: key);
  final String? noteID;

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NoteService get notesService => GetIt.I<NoteService>();

  String? errorMessage;
  late Note note;

  @override
  void initState() {
    notesService.getNote(widget.noteID!).then((response) {
      if (response!.error) {
        errorMessage = response.errorMessage ?? 'An error occurred.';
      }
      note = response.data!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(height: 8),
            const TextField(
              decoration: InputDecoration(hintText: 'Note content'),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (isEditing) {
                    // update note in api
                  } else {
                    // create not in api
                  }
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
