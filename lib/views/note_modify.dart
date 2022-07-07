import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_api/models/note_insert.dart';
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });

      notesService.getNote(widget.noteID!).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response!.error) {
          errorMessage = response.errorMessage ?? 'An error occurred.';
        }
        note = response.data!;
        _titleController.text = note.noteTitle!;
        _contentController.text = note.noteContent!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit note' : 'Create note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Note title'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(hintText: 'Note content'),
                  ),
                  Container(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        if (isEditing) {
                          // update note in api
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          // create not in api
                          final note = NoteInsert(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                          );
                          final result = await notesService.createNote(note);

                          setState(() {
                            _isLoading = false;
                          });

                          const title = 'Done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An error occurred.')
                              : 'Your note was created';

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          ).then((data) {
                            if (result.data!) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
