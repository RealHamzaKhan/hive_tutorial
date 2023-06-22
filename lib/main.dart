import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/notes_app/main_screen.dart';
import 'package:hive_tutorial/notes_app/models/notes_model.dart';
import 'package:path_provider/path_provider.dart';

import 'homepage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //getting path for the directory
  var directory=await getApplicationDocumentsDirectory();
  //initializing hive database in the app directory
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("notes");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}

