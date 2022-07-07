import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  const NoteModify({Key? key, this.noteID}) : super(key: key);
  final String? noteID;
  bool get isEditing => noteID != null;

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
                  if(isEditing) {
                    // update note in api
                  }
                  else {
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
