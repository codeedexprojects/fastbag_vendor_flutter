import 'package:flutter/material.dart';

class FbTimePicker extends StatefulWidget {
  final Function(String) onTimeRangeChanged;

  const FbTimePicker({super.key, required this.onTimeRangeChanged});

  @override
  FbTimePickerState createState() => FbTimePickerState();
}

class FbTimePickerState extends State<FbTimePicker> {
  TextEditingController _timeController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  // Function to pick a time (either start or end)
  Future<void> _pickTime(BuildContext context, bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
        _updateTimeField();
      });
    }
  }

  // Update the text field with both start and end time
  void _updateTimeField() {
    if (_startTime != null && _endTime != null) {
      String start = _startTime!.format(context);
      String end = _endTime!.format(context);
      String timeRange = '$start - $end';

      widget.onTimeRangeChanged(timeRange);
      _timeController.text = timeRange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .07, vertical: screenHeight * .02),
      child: SizedBox(
        height: screenHeight * .11,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'OPEN , CLOSE TIME',
              style:
                  TextStyle(fontSize: screenWidth * .025, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () async {
                if (_startTime == null && _endTime == null) {
                  // First time: directly pick start time
                  await _pickTime(context, true);
                } else {
                  // Show dialog to choose start or end time
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Select Time"),
                        content: const Text(
                            "Do you want to change the Start Time or End Time?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickTime(context, true); // Change start time
                            },
                            child: const Text("Start Time"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickTime(context, false); // Change end time
                            },
                            child: const Text("End Time"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: _startTime != null && _endTime != null
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                    helperText: _startTime != null && _endTime != null
                        ? null
                        : 'Tap to select time range', // General instruction
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
