import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/widget/no_splash_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: double.infinity,
                ),
                Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                ),
                _UserPassword(
                  text: 'User Name',
                ),
                _Input(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                _UserPassword(
                  text: 'Password',
                ),
                _Input(
                  encrypted: true,
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                ),
                _UnderlineText(
                  text: 'FORGET PASSWORD?',
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
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
                Expanded(
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
                )),
              ],
            ),
          ),
        ),
      );
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

class _Input extends StatelessWidget {
  final bool encrypted;

  const _Input({this.encrypted = false});

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
          child: TextFormField(
            obscureText: encrypted,
            cursorColor: AppColor.yellow,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      );
}

class _UnderlineText extends StatelessWidget {
  final String text;

  const _UnderlineText({@required this.text});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      );
}
