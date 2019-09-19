import 'package:flutter/material.dart';

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  Color _color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DragglableWidget(
            offset: Offset(0, 50),
            color: Colors.teal,
            text: "Drag 1",
          ),
          DragglableWidget(
            offset: Offset(100, 50),
            color: Colors.orange,
            text: "Drag 2",
          ),
          DragglableWidget(
            offset: Offset(200, 50),
            color: Colors.cyan,
            text: "Drag 3",
          ),
          DragglableWidget(
            offset: Offset(300, 50),
            color: Colors.red,
            text: "Drag 3",
          ),
          Positioned(
            top: 700,
            left: 100,
            child: DragTarget(
              builder: (BuildContext context, List candidateData,
                  List rejectedData) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: _color,
                  ),
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  child: Text("Drag Here!!"),
                );
              },
              onAccept: (Color color) {
                print("here");
                _color = color;
              },
              onWillAccept: (data) {
                setState(() {
                  _color = Colors.greenAccent;
                });
                return true;
              },
              onLeave: (data) {
                 setState(() {
                  _color = Colors.grey;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class DragglableWidget extends StatefulWidget {
  Offset offset;
  Color color;
  String text;

  DragglableWidget({Key key, this.offset, this.color, this.text})
      : super(key: key);
  @override
  _DragglableWidgetState createState() => _DragglableWidgetState();
}

class _DragglableWidgetState extends State<DragglableWidget> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child: Draggable(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: widget.color,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(decoration: TextDecoration.none),
            ),
          ),
        ),
        data: widget.color,
        onDraggableCanceled: (v, o) {
          setState(() {
            offset = o;
          });
        },
        childWhenDragging: Container(),
        dragAnchor: DragAnchor.child,
        
        feedback: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: widget.color.withOpacity(.8),
          ),
          width: 100,
          height: 100,
          child: Center(
            child: Text(widget.text,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  fontSize: 19,
                  color: Colors.black,
                )),
          ),
        ),
      ),
    );
  }
}
