import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'firebase_options.dart';


final REGION = 'europe-west1';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  void makeCall() async {
    final functions = FirebaseFunctions.instanceFor(region: REGION);
    final foo = functions.httpsCallable("foo");
    try {
      await foo({"count": 1});
    } on FirebaseFunctionsException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: makeCall,
          child: const Text("CALL"),
        ),
      ),
    );
  }
}
