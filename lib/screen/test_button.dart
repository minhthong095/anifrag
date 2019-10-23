import 'package:Anifrag/config/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestButton extends StatefulWidget {
  @override
  _TestButton createState() => _TestButton();
}

class _TestButton extends State<TestButton>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0, end: 0.1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.red,
        child: ButtonCircle2(
          iconPath: PathIcon.back,
          onTap: () {},
        ),
      );
}

class ButtonCircle2 extends StatefulWidget {
  final VoidCallback onTap;
  final String iconPath;

  const ButtonCircle2({@required this.onTap, @required this.iconPath});

  @override
  _ButtonCircle2State createState() => _ButtonCircle2State();
}

class _ButtonCircle2State extends State<ButtonCircle2>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0, end: 0.5);
  bool test = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController = null;
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    print('DOWN');
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    print('UP');
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    print('CANCEL');
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      print('ANIMATING ' + _buttonHeldDown.toString());
      test = true;
      return;
    }
    TickerFuture ticker;
    final bool wasHeldDown = _buttonHeldDown;
    print('test ' + test.toString());
    if (_buttonHeldDown) {
      print('HELD DOWN');
      ticker = _animationController.animateTo(1.0,
          duration: Duration(milliseconds: 10));
    } else {
      print('HELD UP');
      ticker = _animationController.animateTo(0.0,
          duration: Duration(milliseconds: 100));
    }

    // Fix for clicking to fast.
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
        print('wasHeldDown ' + wasHeldDown.toString());
        print('_buttonHeldDown ' + _buttonHeldDown.toString());
      }
    });

    //  if (_animationController.isAnimating)
    //   return;
    // final bool wasHeldDown = _buttonHeldDown;
    // final TickerFuture ticker = _buttonHeldDown
    //     ? _animationController.animateTo(1.0, duration: kFadeOutDuration)
    //     : _animationController.animateTo(0.0, duration: kFadeInDuration);
    // ticker.then<void>((void value) {
    //   if (mounted && wasHeldDown != _buttonHeldDown)
    //     _animate();
    // });
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _opacityAnimation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.onTap,
          child: Center(
              child: Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  widget.iconPath,
                  filterQuality: FilterQuality.none,
                )),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(Colors.white.value).withOpacity(0.2)),
            constraints: BoxConstraints.tight(Size(50, 50)),
          )),
        ),
      );
}
