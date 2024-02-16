import 'package:flutter/material.dart';
import 'package:project1/add_activity.dart';
import 'package:project1/models/activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.comfortable,
          scaffoldBackgroundColor: Colors.green[100],
          cardColor: Colors.green[600],
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.green[100],
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a list of items
  List<Activity> actList = [];

  void _addAct() async {
    final act = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddActivity(),
        ));

    if (act != null) {
      setState(() {
        actList.add(act);
      });
    }
    sortArr();
  }

  void sortArr() {
      setState(() {
        actList.sort(
          (a, b) {
            int dateComparison = a.date.compareTo(b.date);
            if (dateComparison != 0) {
              return dateComparison;
            }
            return (a.time.hour * 60 + a.time.minute) -
                (b.time.hour * 60 + b.time.minute);
          },
        );
      });
    }

  void _deleteAct(Activity act) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning !'),
          content: const Text('Are you sure you want to delete this activity?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Perform the deletion
                final index = actList.indexOf(act);
                if (index != -1) {
                  setState(() {
                    actList.removeAt(index);
                  });
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     actList.sort(
          (a, b) {
            int dateComparison = a.date.compareTo(b.date);
            if (dateComparison != 0) {
              return dateComparison;
            }
            return (a.time.hour * 60 + a.time.minute) -
                (b.time.hour * 60 + b.time.minute);
          },
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity List'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: actList != null && actList.isNotEmpty
              ? ListView.builder(
                  itemCount: actList.length,
                  itemBuilder: (context, index) {
                    final act = actList[index];
                    return Card(
                        child: GestureDetector(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text("${act.date.day}/${act.date.month}",
                              style: const TextStyle(fontSize: 16)),
                          //backgroundColor: ,
                        ),
                        title: Text(
                          act.todo,
                          style: TextStyle(
                              color: Colors.green[100],
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(act.detail,
                            style: TextStyle(color: Colors.green[100])),
                        trailing: Text(act.time.format(context),
                            style: TextStyle(color: Colors.green[100])),
                      ),
                      onLongPress: () {
                        _deleteAct(act);
                      },
                    ));
                  },
                )
              : const Center(
                  child: Text(
                    'No Activity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
