import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/firestor.dart';
import 'package:todo_app/widgets/task_widget.dart';

class Stream_note extends StatelessWidget {
  bool done;
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: Firestore_Datasource().stream(done),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final notesList = Firestore_Datasource().getNotes(snapshot);
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final note = notesList[index];
                    return Dismissible(
                      key: UniqueKey(), 
                      onDismissed: (direction) {
                        Firestore_Datasource().deleteNote(note.id);
                      },
                      child: Task_Widget(note));
                  },
                  itemCount: notesList.length,
                );
              }
            );
  }
}