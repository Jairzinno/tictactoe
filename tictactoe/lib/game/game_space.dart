import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape_space.dart';
import 'package:tictactoe/game/game_service.dart';

class GameSpace extends StatefulWidget {
  final GameService gameService;

  const GameSpace({Key key, @required this.gameService}) : super(key: key);

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
                      key: ValueKey(gamePageTopLeftShapeSpace),
                      width: (width - 20) / 3,
                      shape:
                          widget.gameService.shapeForPosition(Position.topLeft),
                      onTap: () {
                        print('tapped top left');
                        widget.gameService.positionTapped(Position.topLeft);
                        setState(() {
                          widget.gameService.positionTapped(Position.topLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageTopCenterShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.topCenter),
                      onTap: () {
                        setState(() {
                          widget.gameService.positionTapped(Position.topCenter);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageTopRightShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.topRight),
                      onTap: () {
                        setState(() {
                          widget.gameService.positionTapped(Position.topRight);
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
                      key: ValueKey(gamePageCenterLeftShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.centerLeft),
                      onTap: () {
                        setState(() {
                          widget.gameService
                              .positionTapped(Position.centerLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageCenterShapeSpace),
                      width: (width - 20) / 3,
                      shape:
                          widget.gameService.shapeForPosition(Position.center),
                      onTap: () {
                        setState(() {
                          widget.gameService.positionTapped(Position.center);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageCenterRightShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.centerRight),
                      onTap: () {
                        setState(() {
                          widget.gameService
                              .positionTapped(Position.centerRight);
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
                      key: ValueKey(gamePageBottomLeftShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomLeft),
                      onTap: () {
                        setState(() {
                          widget.gameService
                              .positionTapped(Position.bottomLeft);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageBottomCenterShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomCenter),
                      onTap: () {
                        setState(() {
                          widget.gameService
                              .positionTapped(Position.bottomCenter);
                        });
                      },
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 10,
                      height: (width - 20) / 3,
                    ),
                    ShapeSpace(
                      key: ValueKey(gamePageBottomRightShapeSpace),
                      width: (width - 20) / 3,
                      shape: widget.gameService
                          .shapeForPosition(Position.bottomRight),
                      onTap: () {
                        setState(() {
                          widget.gameService
                              .positionTapped(Position.bottomRight);
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
