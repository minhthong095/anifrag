import 'package:flutter/material.dart';

class TestAsync extends StatefulWidget {
  @override
  _TestAsyncState createState() => _TestAsyncState();
}

class _TestAsyncState extends State<TestAsync> {
  @override
  void initState() {
    runAll();
    super.initState();
  }

  void runAll() async {
    run();
    // print("A RUN2");
    // run2();
    // print("B RUN2");
  }

  void run() async {
    // print("RUN");
    Future.delayed(Duration(seconds: 10), () => print("RUN FINISH"));
    Future.delayed(Duration(seconds: 1), () => print("RUN 1 FINISH"));
    // print("FINISH RUN");
  }

  void run2() async {
    print("RUN2");
    await Future.delayed(Duration(seconds: 2), () => print("RUN2 FINISH"));
    run3();
    print("FINISH RUN2");
  }

  void run3() async {
    print("RUN3");
    await Future.delayed(Duration(seconds: 3), () => print("RUN3 FINISH"));
    print("FINISH RUN3");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.grey,
        ),
      );
}
