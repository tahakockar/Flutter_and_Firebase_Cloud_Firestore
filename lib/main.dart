import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_with_flutter/add.dart';
import 'package:firebase_with_flutter/status_services.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController statusController = TextEditingController();

  StatusServices _statusServices = StatusServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.favorite),
        title: Text("Flutter And Firebase"),
      ),
      body: StreamBuilder(
          stream: _statusServices.getStatus(),
          builder: (context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mypost = snapshot.data.docs[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Alert!!"),
                                content: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Enter Name',
                                      hintText: "${mypost["Text"]}"),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      _statusServices.UpdateStatus;
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          ;
                        },
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () =>
                                _statusServices.removeStatus(mypost.id),
                            icon: Icon(Icons.delete),
                          ),
                          title: Text(
                            "${mypost["Text"]}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
