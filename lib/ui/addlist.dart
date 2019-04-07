import 'package:flutter/material.dart';
import '../model/todo.dart';

class AddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddScreenState();
  }
}

class AddScreenState extends State{
  final _formkey = GlobalKey<FormState>();
  TextEditingController adding = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TodoProvider todo = TodoProvider();
    todo.open("todo.db");
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: adding,
              decoration: InputDecoration(labelText: "Subject"),
              validator: (value){
                if(value.isEmpty) return "Please fill subject";
              },
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async{
                Todo data = Todo();
                data.title = adding.text;
                data.done = false;
                Todo result = await todo.insert(data);
                print(result);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}