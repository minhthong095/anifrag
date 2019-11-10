import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class InitialSplash extends StatefulWidget {
  final BlocInitialSplash bloc;

  const InitialSplash(this.bloc);

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<InitialSplash> {
  String x = '0';
  String y = '0';

  @override
  void initState() {
    // final a = ()
    super.initState();
  }

  void init() async {
    // _api.getConfiguration();
    String databasePath = await getDatabasesPath();
    String path = databasePath + 'anifrag.db';
    print("PATH DATABASE " + path);
    await deleteDatabase(path);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print("DATABSE CREATE BLOCINITSPALH");
      await db.execute(
          "CREATE TABLE POSTER_SIZE (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT, value2 TEXT, value3 TEXT, value4 TEXT, value5 TEXT, value6 TEXT, value7 TEXT, value8 TEXT)");
      await db.execute(
          'CREATE TABLE CHANGE_KEY (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT, value2 TEXT, value3 TEXT, value4 TEXT, value5 TEXT, value6 TEXT, value7 TEXT, value8 TEXT)');
    });
    Stopwatch stopwatch = Stopwatch()..start();

    await database.transaction((transaction) async {
      for (int i = 0; i < int.parse(y); i++) {
        // int i = 1;
        transaction.rawInsert(
            'INSERT INTO POSTER_SIZE (value, value2, value3, value4, value5, value6, value7, value8) VALUES ("' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '")');
        transaction.rawInsert(
            'INSERT INTO CHANGE_KEY (value, value2, value3, value4, value5, value6, value7, value8) VALUES ("' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '", "' +
                i.toString() +
                '")');
      }
    });

    await database.close();
    setState(() {
      x = stopwatch.elapsed.toString();
    });
    stopwatch.stop();
    print("END INIT BLOCINITSPALH");
  }

  @override
  Widget build(BuildContext context) {
    // final c = widget.requestingWithValue;
    // final d = widget.requesting;
    // return Scaffold(
    //   backgroundColor: AppColor.backgroundColor,
    //   body: Container(
    //     child: Center(
    //         child: InkWell(
    //       onTap: () {
    //         // widget.bloc.init();
    //         init();
    //       },
    //       child: Text(
    //         x,
    //         style: TextStyle(color: Colors.white, fontSize: 30),
    //       ),
    //       // child: Image.asset(
    //       //   PathImage.splash,
    //       //   height: 200,
    //       //   width: 200,
    //       // ),
    //     )),
    //   ),
    // );
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              y = value;
            },
          ),
          InkWell(
            onTap: () {
              init();
            },
            child: Text(
              x,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
