import 'package:flutter/material.dart';

class CustomItem extends StatefulWidget {
  final double angle;
  final double textAngle;
  final int hour;
  final bool isSelected;
  final GestureTapCallback onSelectHour;

  const CustomItem({
    Key? key,
    required this.angle,
    required this.hour,
    required this.isSelected,
    required this.onSelectHour,
    required this.textAngle,
  }) : super(key: key);

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  // TextStyle hourStyle = const ;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(widget.angle / 360),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              widget.onSelectHour();
            },
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.isSelected ? Colors.black : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(widget.textAngle / 360),
                child: Text(
                  widget.hour < 10 ? "0${widget.hour}" : "${widget.hour}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: widget.isSelected == true ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
              width: 66, height: 1, color: widget.isSelected ? Colors.black : Colors.transparent),
        ],
      ),
    );
  }
}
