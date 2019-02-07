library flippo_navigation;

import 'dart:math';
import 'package:flutter/material.dart';

class Flippo extends StatefulWidget {
  //Widget body
  final Widget body;

  //Widget to mask the body when drawer is open
  final Widget mask;

  //Widget drawer
  final Widget drawer;

  // Controller for controlling the Navigation.
  final AnimationController controller;

  Flippo({
    @required this.body,
    this.mask,
    @required this.drawer,
    this.controller,
  });

  @override
  _FlippoState createState() => _FlippoState();
}

class _FlippoState extends State<Flippo> with SingleTickerProviderStateMixin {
  // Controller for controlling the Navigation.
  AnimationController controller;

  // Tween for moving from 0 to pi/2 radian and vice versa.
  Animation _drawerAnimation;

  // Tween for going from 1 to 0 opacity and vice versa.
  Animation<double> _bodyOpacity;

  // Tween for going from 0 to 1 opacity and vice versa.
  Animation<double> _maskOpacity;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
    } else {
      controller = widget.controller;
    }

    _drawerAnimation = Tween(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    _bodyOpacity = new Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    _maskOpacity = new Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  left: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: new Container(
                      color: Colors.white,
                      child: new Stack(
                        children: <Widget>[
                          new IgnorePointer(
                            ignoring: controller.isAnimating ||
                                controller.isCompleted,
                            child: new Opacity(
                              opacity: widget.mask != null
                                  ? _bodyOpacity.value
                                  : 1.0,
                              child: widget.body,
                            ),
                          ),
                          new IgnorePointer(
                            ignoring: !controller.isCompleted,
                            child: new Opacity(
                              opacity: _maskOpacity.value,
                              child: widget.mask != null
                                  ? widget.mask
                                  : new SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    )),
                  )),
              Positioned(
                left: 0.0,
                child: new IgnorePointer(
                  ignoring: !controller.isCompleted,
                  child: new Transform(
                    //BLACK
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(-(cos(_drawerAnimation.value) * (150)), 0.0,
                          (-(150) * sin(_drawerAnimation.value)))
                      ..rotateY(-(pi / 2) + _drawerAnimation.value),
                    child: new Material(
                      borderRadius: BorderRadius.circular(25.0),
                      elevation: 2.0,
                      color: Colors.black,
                      child: new Container(
                        padding: new EdgeInsets.all(50.0),
                        height: MediaQuery.of(context).size.height,
                        width: 280.0,
                        child: widget.drawer),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  var gestureStart;
  var gestureDirection;

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (controller.isCompleted) controller.reverse();
    } else {
      controller.forward();
    }
  }
}
