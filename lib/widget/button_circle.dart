import 'package:flutter/material.dart';

class ButtonCircle extends StatefulWidget {
  final VoidCallback onTap;
  final String iconPath;

  const ButtonCircle({@required this.onTap, @required this.iconPath});

  @override
  _ButtonCircleState createState() => _ButtonCircleState();
}

class _ButtonCircleState extends State<ButtonCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0, end: 0.5);

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
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: Duration(milliseconds: 10))
        : _animationController.animateTo(0.0,
            duration: Duration(milliseconds: 100));
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
