import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Todo list")),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewItem(context),
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }

  _addNewItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write new action todo'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Todo action'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    if (_textFieldController.text.length > 0) {
                      items.add(_textFieldController.text);
                      _textFieldController.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = items[index];
          Color tileColor = Colors.accents[index % Colors.accents.length];
          return Dismissible(
              background: Container(color: tileColor.withAlpha(500)),
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: tileColor
                ),
                child: ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        items.removeAt(index);
                      });
                    })
                ),
              ));
        });
  }
}
