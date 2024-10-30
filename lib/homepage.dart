import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                
                itemBuilder: (context, index) {
                  String title = snapshot.data!.docs[index]['title'];
                  String notes = snapshot.data!.docs[index]['content'];
                  return Card(
                      child: GestureDetector(
                        onTap:    (){
                          final edit =true;

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Addnotes(edit:edit ,title: title,notes: notes,id:snapshot.data!.docs[index].id ,)));
                  },
                        child: ListTile(
                                            
                                            title: Text(title),
                                            trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('notes')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                          icon: Icon(Icons.delete,color: Colors.red,)),
                                            subtitle: Text(
                        snapshot.data!.docs[index]['content'],
                        overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                      ));
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return  Text('No Notes');
            }
          }),
      floatingActionButton: FloatingActionButton(
            
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  Addnotes()));
            },
            child: const Icon(Icons.add),
          ),
       
    );
  }
}
