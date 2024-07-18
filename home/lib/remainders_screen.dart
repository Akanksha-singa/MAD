import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFFFF4D4D)),
            ),
            SizedBox(width: 10),
            Text(
              'Reminders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: RemindersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReminderScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFF4D4D),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFF4D4D),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RemindersList extends StatefulWidget {
  @override
  _RemindersListState createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  String userPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    fetchLatestUserPhoneNumber();
  }

  Future<void> fetchLatestUserPhoneNumber() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userPhoneNumber = querySnapshot.docs.first.id;
        });
      } else {
        print('No users found in the database.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> deleteReminder(String reminderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('reminders')
          .doc(userPhoneNumber)
          .update({reminderId: FieldValue.delete()});
      print('Reminder deleted successfully');
    } catch (e) {
      print('Error deleting reminder: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('reminders')
          .doc(userPhoneNumber)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white)));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
              child: Text('No reminders added yet.',
                  style: TextStyle(color: Colors.white)));
        }

        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        List<Widget> reminderWidgets = [];

        data.forEach((key, value) {
          if (value is Map<String, dynamic>) {
            reminderWidgets.add(
              GestureDetector(
                onDoubleTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Reminder'),
                        content: Text(
                            'Are you sure you want to delete this reminder?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              deleteReminder(key);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: _buildReminderCard(
                  value['title'],
                  value['dueDate'],
                  value['amount'],
                  Icons.event,
                ),
              ),
            );
          }
        });

        return ListView(
          padding: EdgeInsets.all(16),
          children: reminderWidgets,
        );
      },
    );
  }

  Widget _buildReminderCard(
      String title, String dueDate, int amount, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFF4D4D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon, color: Color(0xFFFF4D4D)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Due date: $dueDate',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              '₹$amount',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String userPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    fetchLatestUserPhoneNumber();
  }

  Future<void> fetchLatestUserPhoneNumber() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userPhoneNumber = querySnapshot.docs.first.id;
        });
      } else {
        print('No users found in the database.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4D4D),
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Title', 'Enter reminder title', titleController),
            SizedBox(height: 16),
            _buildTextField('Due Date', 'Enter due date', dueDateController),
            SizedBox(height: 16),
            _buildTextField('Amount', 'Enter amount', amountController),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addReminder,
              child: Text('Add Reminder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF4D4D),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _addReminder() {
    String title = titleController.text.trim();
    String dueDate = dueDateController.text.trim();
    int amount = int.tryParse(amountController.text.trim()) ?? 0;

    if (title.isNotEmpty && dueDate.isNotEmpty && amount > 0 && userPhoneNumber.isNotEmpty) {
      Map<String, dynamic> newReminder = {
        'title': title,
        'dueDate': dueDate,
        'amount': amount,
      };

      FirebaseFirestore.instance
          .collection('reminders')
          .doc(userPhoneNumber)
          .set({
        'reminder_${DateTime.now().millisecondsSinceEpoch}': newReminder
      }, SetOptions(merge: true))
          .then((value) {
        print('Reminder added successfully');
        Navigator.pop(context);
      }).catchError((error) {
        print('Failed to add reminder: $error');
        // Show error message to user
      });
    } else {
      // Show error message to user about incomplete fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly')),
      );
    }
  }
}
