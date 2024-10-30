import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/firebase/firebase.dart';

class Addnotes extends StatefulWidget {
  bool? edit = false;
  String? title;
  String? notes;
  final id;
  Addnotes({super.key, this.edit, this.notes, this.title, this.id});

  @override
  State<Addnotes> createState() => _AddnotesState();
}

class _AddnotesState extends State<Addnotes> {
  String hour = DateTime.now().hour.toString().padLeft(2, '0');

  String minute = DateTime.now().minute.toString().padLeft(2, '0');

  String ampm = DateTime.now().hour < 12 ? 'AM' : 'PM';
  final _titletext = TextEditingController();
  final _contentText = TextEditingController();

  @override
  void initState() {
    if (widget.edit == true) {
      _titletext.text = widget.title!;
      _contentText.text = widget.notes!;
    }
    super.initState();
  }

  adddata() {
    try {
      Firebase()
          .addToFirebase(title: _titletext.text, notes: _contentText.text);
      Navigator.pop(context);
    } catch (e) {}
  }

  updatedata() {
    try {
      Firebase().updateData(title: _titletext.text, notes: _contentText.text,id: widget.id);
      Navigator.pop(context);
    } catch (e) {}
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('notes'),
        actions: [
          IconButton(onPressed: () async {
    if (_titletext.text.isNotEmpty) {
      if (widget.edit == true) {
        await updatedata();
       
      } else {
       await adddata();
      
      }
    }
  }, icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '$hour:$minute $ampm',
                    style: const TextStyle(fontSize: 11),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titletext,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  maxLines: null,
                  controller: _contentText,
                  decoration: const InputDecoration(
                      hintText: 'Note Something ',
                      hintStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      border: InputBorder.none)),
            )
          ],
        ),
      ),
    );
  }
}
