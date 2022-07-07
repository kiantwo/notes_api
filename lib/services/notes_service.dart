import 'dart:convert';

import '../models/api_response.dart';
import '../models/note.dart';
import '../models/note_for_listing.dart';
import 'package:http/http.dart' as http;

import '../models/note_insert.dart';

class NoteService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'e7ec8231-b9fc-4d2e-9243-c5dc3adc1b44',
    'Content-type': 'application/json',
  };

  Future<APIResponse<List<NoteForListing>>?> getNotesList() {
    return http.get(Uri.parse('$api/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occurred.'));
  }

  Future<APIResponse<Note>?> getNote(String noteID) {
    return http
        .get(Uri.parse('$api/notes/$noteID'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        ;
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
    }).catchError((_) =>
            APIResponse<Note>(error: true, errorMessage: 'An error occurred.'));
  }

  Future<APIResponse<bool>> createNote(NoteInsert item) {
    return http
        .post(Uri.parse('$api/notes'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred.');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occurred.'));
  }
}
