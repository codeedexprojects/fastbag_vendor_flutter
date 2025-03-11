import 'package:flutter/material.dart';

class FbToggleSwitch extends StatefulWidget {
  final String title;
  final bool initialValue;
  final ValueChanged<bool> onToggleChanged;

  const FbToggleSwitch({
    super.key,
    required this.title,
    this.initialValue = false,
    required this.onToggleChanged,
  });

  @override
  State<FbToggleSwitch> createState() => _FbToggleSwitchState();
}

class _FbToggleSwitchState extends State<FbToggleSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * .07,
        vertical: screenHeight * .02,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(240, 240, 240, 1), width: 0.2),
        ),
        child: ListTile(
          title: Text(widget.title),
          trailing: Switch(
            activeColor: Colors.green,
            inactiveThumbColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
              widget.onToggleChanged(value);
            },
          ),
        ),
      ),
    );
  }
}
