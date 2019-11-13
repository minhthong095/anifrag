import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/widget/no_splash_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/subjects.dart';

class Login extends StatefulWidget {
  static const String nameRoute = '/login';

  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // -1 no one
  // 0 username
  // 1 password
  BehaviorSubject<int> _behaviorWhoFocus = BehaviorSubject.seeded(-1);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _behaviorWhoFocus.sink.add(-1);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      width: 1,
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 40,
                      width: 1,
                    ),
                    _UserPassword(
                      text: 'User Name',
                    ),
                    StreamBuilder(
                      stream: _behaviorWhoFocus.stream,
                      builder: (context, AsyncSnapshot<int> snapshot) => _Input(
                        glow: snapshot.data == 0,
                        onFocus: () {
                          _behaviorWhoFocus.sink.add(0);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 1,
                    ),
                    _UserPassword(
                      text: 'Password',
                    ),
                    StreamBuilder<int>(
                      stream: _behaviorWhoFocus.stream,
                      builder: (context, AsyncSnapshot<int> snapshot) => _Input(
                        encrypted: true,
                        glow: snapshot.data == 1,
                        onFocus: () {
                          _behaviorWhoFocus.sink.add(1);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 1,
                    ),
                    _UnderlineText(
                      fontSize: 13,
                      text: 'FORGET PASSWORD?',
                    ),
                    SizedBox(
                      height: 40,
                      width: 1,
                    ),
                    Container(
                      width: double.infinity,
                      child: CupertinoButton(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: AppColor.yellow,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints.expand(height: 120),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                                child: Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            )),
                            WidgetSpan(
                                child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ))
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));

  @override
  void dispose() {
    _behaviorWhoFocus.close();
    super.dispose();
  }
}

class _UserPassword extends StatelessWidget {
  final String text;

  const _UserPassword({@required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      );
}

class _Input extends StatefulWidget {
  final bool encrypted;
  final bool glow;
  final Function onFocus;

  _Input({this.encrypted = false, this.glow = false, @required this.onFocus});

  @override
  __InputState createState() => __InputState();
}

class __InputState extends State<_Input> {
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) widget.onFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(7),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Theme(
          data: ThemeData(
            splashFactory: NoSplashFactory(),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox.fromSize(
                  size: Size(16, 16),
                  child: SvgPicture.asset(
                      widget.encrypted ? PathSvg.lock : PathSvg.mail,
                      color: widget.glow ? AppColor.yellow : Colors.white),
                ),
              ),
              Flexible(
                child: TextFormField(
                  focusNode: focusNode,
                  obscureText: widget.encrypted,
                  cursorColor: AppColor.yellow,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      );
}

class _UnderlineText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _UnderlineText({@required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
            fontSize: this.fontSize,
            color: Colors.white,
            decoration: TextDecoration.underline),
      );
}
