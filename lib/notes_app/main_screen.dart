import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/notes_app/boxes/boxes.dart';
import 'package:hive_tutorial/notes_app/models/notes_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController title=TextEditingController();
  final TextEditingController description=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    description.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        //This will listen to the data and if changes that will reflect on the screen in real time
        //listenable() is from hive flutter
        valueListenable:Boxes.getNotesBox().listenable(),
         builder: (context,box,_){
          var data=box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context,index){
              return Card(
                
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].title.toString()),
                        Text(data[index].description.toString())
                      ],
                ),
                const Spacer(),
                IconButton(onPressed: (){
                  editDialogBox(data[index],data[index].title,data[index].description);
                }, icon: const Icon(Icons.edit)),
                IconButton(onPressed: (){
                  deleteNote(data[index]);
                }, icon: const Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),)
              );
          });
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        myDialogBox();
      },child: const Icon(Icons.add),),
    );
  }
  void deleteNote(NotesModel notesModel)async{
    //Notes model did this automatically for us because we extend that with hive object
    await notesModel.delete();
  }
  Future<void> editDialogBox(NotesModel notesModel,String notesTitle,String notesDescription)async{
    title.text=notesTitle;
    description.text=notesDescription;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        title:const Text("Edit Note"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text("Cancel")),
          TextButton(onPressed: (){
            notesModel.title=title.text.toString();
            notesModel.description=description.text.toString();
            //we need to save to reflect the differences
            notesModel.save();
            Navigator.pop(context);
          }, child:const Text("Edit")),
        ],
        content: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            TextFormField(
              maxLines: null,
              controller: description,
              decoration: const InputDecoration(
                hintText: "Description......",
              ),
            ),
          ],
        ),
      );
    });
  }
  Future<void> myDialogBox()async{
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        title:const Text("Add Note"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text("Cancel")),
          TextButton(onPressed: (){
            final data=NotesModel(title: title.text,description: description.text);
            final box=Boxes.getNotesBox();
            box.add(data);
            data.save();
            
            Navigator.pop(context);
            title.clear();
            description.clear();
          }, child:const Text("Add")),
        ],
        content: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            TextFormField(
              maxLines: null,
              controller: description,
              decoration: const InputDecoration(
                hintText: "Description......",
              ),
            ),
          ],
        ),
      );
    });
  }
}