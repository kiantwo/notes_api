class Note {
  String? noteID;
  String? noteTitle;
  String? noteContent;
  DateTime? createDateTime;
  DateTime? latestEditDateTime;

  Note(
      {this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.latestEditDateTime});
}
