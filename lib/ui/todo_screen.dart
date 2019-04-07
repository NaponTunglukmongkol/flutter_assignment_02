import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UndoneList();
  }
}

class UndoneList extends State{
  Widget build(BuildContext context) {
    // TODO: implement build
    TodoProvider todo = TodoProvider();
    todo.open("todo.db");
    var task = List<Widget>();
    void tasking(List data) {
      for(int i = 0; i<data.length; i++){
        List test = data[i].toMap().values.toList();
        task.add(FlatButton(child: Text(test[0]),));
      }
    }
    var scaffold = Scaffold(
        bottomNavigationBar: Container(
          color: Colors.grey,
          child: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.storage),
                text: "Task",
              ),
              Tab(
                icon: Icon(Icons.done_all),
                text: "Completed",
              )
            ],
          )
        ),
        body: TabBarView(children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text("Todo"),
              actions: <Widget>[
                new IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, "/add");
                },
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Get"), 
                  onPressed: () async{
                    List data = await todo.getTask();
                    tasking(data);
                  },
                ),
                RaisedButton(
              child: Text("Delete"), 
              onPressed: () async {
                int result = await todo.deleteAll();
                print(result);
              },
            ),
              ], task,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Todo"),
              actions: <Widget>[
                new IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                )
              ],
            ),
          ),
        ],),
      );
    return DefaultTabController(
      length: 2,
      child: scaffold,
    );
  }
}