import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/game/shape_space.dart';
import 'package:tictactoe/model/position.dart';
import 'package:tictactoe/service/game_service.dart';

class GameSpace extends StatefulWidget {
  final ValueChanged<Position> onPositionTap;
  final GameService gameService;

  const GameSpace(
      {Key key, @required this.onPositionTap, @required this.gameService})
      : super(key: key);

  @override
  _GameSpaceState createState() => _GameSpaceState();
}

class _GameSpaceState extends State<GameSpace> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        double width = min(300, MediaQuery.of(context).size.width - 16);
        return Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape:
                          widget.gameService.shapeForPosition(Position.topLeft),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.topLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.topCenter),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.topCenter);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.topRight),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.topRight);
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 10,
                  width: width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.centerLeft),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.centerLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape:
                          widget.gameService.shapeForPosition(Position.center),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.center);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.centerRight),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.centerRight);
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 10,
                  width: width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomLeft),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.bottomLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomCenter),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.bottomCenter);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomRight),
                      onTap: () {
                        setState(() {
                          widget.onPositionTap(Position.bottomRight);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
