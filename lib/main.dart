import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ContactListApp(),
  ));
}

class ContactListApp extends StatefulWidget {
  @override
  _ContactListAppState createState() => _ContactListAppState();
}

class _ContactListAppState extends State<ContactListApp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final List<Map<String, String>> contacts = [];

  void _addContact() {
    final String name = _nameController.text.trim();
    final String number = _numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
        _nameController.clear();
        _numberController.clear();
      });
    }
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Contact?'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Contact List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Fields
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Add Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Contact List
            Expanded(
              child: contacts.isEmpty
                  ? Center(child: Text('No contacts yet.'))
                  : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return GestureDetector(
                    onLongPress: () => _showDeleteDialog(index),
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      margin: EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading:
                        Icon(Icons.person, color: Colors.brown[700]),
                        title: Text(
                          contact['name']!,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          contact['number']!,
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(Icons.call, color: Colors.green),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
