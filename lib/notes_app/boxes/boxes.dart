import 'package:hive/hive.dart';
import 'package:hive_tutorial/notes_app/models/notes_model.dart';

class Boxes{
  static Box<NotesModel> getNotesBox()=>Hive.box<NotesModel>('notes');
}