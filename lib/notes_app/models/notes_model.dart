
import 'package:hive/hive.dart';
// Run this command to create adapter file automatically flutter packages pub run build_runner build
part 'notes_model.g.dart';

//We extend this model with Hive object to get some functionalities like listening to changes and saving data
//And after extending this run this command again so it will add the required extra code for you
//flutter packages pub run build_runner build
@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  NotesModel({required this.title,required this.description});
}