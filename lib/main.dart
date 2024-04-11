import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Person {
  int id;
  String name;
  String group;

  Person({required this.id, required this.name, required this.group});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple List Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> _persons = [];

  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple List Application'),
      ),
      body: ListView.builder(
        itemCount: _persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_persons[index].name),
            subtitle: Text(
                'ID: ${_persons[index].id}, Group: ${_persons[index].group}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditPersonDialog(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPersonDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddPersonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Person'),
          content: _buildPersonForm(null),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int id = int.tryParse(_idController.text) ?? 0;
                String name = _nameController.text;
                String group = _groupController.text;
                _persons.add(Person(id: id, name: name, group: group));
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    ).then((_) {
      _clearControllers();
    });
  }

  void _showEditPersonDialog(int index) {
    _idController.text = _persons[index].id.toString();
    _nameController.text = _persons[index].name;
    _groupController.text = _persons[index].group;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Person'),
          content: _buildPersonForm(index),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int id = int.tryParse(_idController.text) ?? 0;
                String name = _nameController.text;
                String group = _groupController.text;
                _persons[index] = Person(id: id, name: name, group: group);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    ).then((_) {
      _clearControllers();
    });
  }

  Widget _buildPersonForm(int? index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _idController,
          decoration: InputDecoration(labelText: 'ID'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: _groupController,
          decoration: InputDecoration(labelText: 'Group'),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Person'),
          content:
              Text('Are you sure you want to delete ${_persons[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _persons.removeAt(index);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _clearControllers() {
    _idController.clear();
    _nameController.clear();
    _groupController.clear();
  }
}
