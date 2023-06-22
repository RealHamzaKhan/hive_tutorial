import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive tutorial"),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox("user"),
            builder: (context,snapshot){
             return Column(
               children: [
                //here it means box.get...................  where box is Hive.openBox
                Text(snapshot.data!.get('experience')['flutter'].toString()),
                 Text(snapshot.data!.get('name')),
               ],
             );
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        //opening box if the box isnt exist it will make one else it will use the existed one
        var box=await Hive.openBox("user");
        //saving data
        box.put("name", "King");
        box.put("semester", "6");
        box.put('experience', {
          "flutter":"1",
          "Node js":"2"
        });
      },child: const Icon(Icons.add),),
    );
  }
}