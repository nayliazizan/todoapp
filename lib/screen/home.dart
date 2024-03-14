import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/const/color.dart';
import 'package:todo_app/screen/add_note_screen.dart';
import 'package:todo_app/widgets/stream_note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Your To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign out the user
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_Screen(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
          ),
      ),
        body: SafeArea(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              }
              if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              } 
              return true;
            },
            child: Column(
              children: [
                Stream_note(false),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold),
                  ),
                ),
                Stream_note(true),
                
              ],
            ),
          ),
        ),
      );
  }
}