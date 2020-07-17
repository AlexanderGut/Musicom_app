import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TagButton extends StatefulWidget {
  static _TagButton of(BuildContext context) => context.findAncestorStateOfType();

  final String tag;
  final VoidCallback onPressed;
  final bool pressed;
  TagButton({Key key, @required this.tag, this.onPressed, this.pressed=true}) : super(key: key);

  @override
  _TagButton createState() => _TagButton();
}

class _TagButton extends State<TagButton> {
  String tag;
  Color color;
  VoidCallback onPressed;
  var pressed = false;

  @override
  void initState() {
    super.initState();
    tag = widget.tag;
    onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2),
        height: 20,
        child: ButtonTheme(
          minWidth: 20,
          child: FlatButton(
            child: Text(
              tag,
              style: TextStyle(
                  fontSize: 12,
                  color: pressed || widget.pressed ? Colors.white
                      :  Theme.of(context).textTheme.bodyText1.color
              ),
            ),
            color: pressed || widget.pressed ? Colors.purple
                : Colors.grey.withAlpha(60),
            onPressed: () {
              if (!widget.pressed) {
                setState(() {
                  pressed = !pressed;
                });
                onPressed();
              }
            },
          ),
        )
    );
  }
}