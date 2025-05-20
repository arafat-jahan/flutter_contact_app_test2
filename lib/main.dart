import 'package:flutter/material.dart';

void main() => runApp(ContactApp());

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<Map<String, String>> contacts = [];

  void addContact() {
    final name = nameController.text.trim();
    final number = numberController.text.trim();
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
        nameController.clear();
        numberController.clear();
      });
    }
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure for Delete?'),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () => Navigator.pop(ctx),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Overall white background
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // square button
                  ),
                ),
                onPressed: addContact,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white), // white text
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return GestureDetector(
                    onLongPress: () => confirmDelete(index),
                    child: Container(
                      color: Colors.white, // white background for each list tile
                      child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(
                          contact['name'] ?? '',
                          style: TextStyle(color: Colors.red), // red name text
                        ),
                        subtitle: Text(contact['number'] ?? ''),
                        trailing: Icon(Icons.call, color: Colors.blueAccent),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
