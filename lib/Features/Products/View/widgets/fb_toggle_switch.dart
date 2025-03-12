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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        title: Text(widget.title),
        trailing: Switch(
          activeColor: Colors.green,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
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
    );
  }
}
