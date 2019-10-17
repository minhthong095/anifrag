import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScaleTransitionA extends StatefulWidget {
  @override
  _TestScaleTransitionA createState() => _TestScaleTransitionA();
}

class _TestScaleTransitionA extends State<TestScaleTransitionA> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.red,
      );
}

class TestScaleTransitionB extends StatefulWidget {
  @override
  _TestScaleTransitionB createState() => _TestScaleTransitionB();
}

class _TestScaleTransitionB extends State<TestScaleTransitionB> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.green,
      );
}
