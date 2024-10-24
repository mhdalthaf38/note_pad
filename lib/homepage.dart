import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/addNote.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
 return ListView.builder(itemBuilder: (context,index){
            return Card(child: ListTile(title: Text(snapshot.data!.docs[index]['title']),subtitle: Text(snapshot.data!.docs[index]['content'],overflow:TextOverflow.ellipsis ,),));
          },
          itemCount: snapshot.data!.docs.length,);
          }else{
            return const CircularProgressIndicator();
          }
         
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Addnotes()));
      },child: const Icon(Icons.add),),
    );
  }
}