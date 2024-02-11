import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clocker/providers/timeState.dart'; // Import your custom state management class.

// TimeClock is a StatefulWidget because it needs to manage state changes, specifically for displaying the clock-in and clock-out functionality.
class TimeClock extends StatefulWidget {
  const TimeClock({Key? key}) : super(key: key);

  @override
  _TimeClockState createState() => _TimeClockState();
}

// _TimeClockState is where the logic and UI for your TimeClock widget reside.
class _TimeClockState extends State<TimeClock> {
  // _formatDuration takes a Duration object and formats it into a string in the format HH:MM:SS.
  String _formatDuration(Duration duration) {
    // twoDigits is a helper function to ensure the hours, minutes, and seconds are always shown as two digits.
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    // Access the TimeClockedIn provider. This allows the widget to react to changes in the clock-in state and elapsed time.
    final timeProvider = Provider.of<TimeClockedIn>(context);

    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Text('Hello'),
          ),
          Container(
            height: 200.0,
            padding: const EdgeInsets.only(
                top: 60.0, // Additional top padding
                left: 16.0, // Uniform padding for left, equivalent to EdgeInsets.all(16.0)
                right: 16.0, // Uniform padding for right, equivalent to EdgeInsets.all(16.0)
                bottom: 16.0, // Uniform padding for bottom, equivalent to EdgeInsets.all(16.0)
              ),
            // The ElevatedButton is the main interactive element. Pressing it will clock in or out the user.
            child: ElevatedButton(
              // Style the button to be very large and with vertical padding.
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 200),
                // padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // This callback determines whether to clock in or out based on the current state.
                if (timeProvider.clockedInTime == null) {
                  timeProvider.clockIn();
                } else {
                  timeProvider.clockOut();
                }
              },
              // Consumer<TimeClockedIn> listens for changes in the TimeClockedIn provider.
              // It rebuilds its child widget whenever notifyListeners is called in the provider.
              child: Consumer<TimeClockedIn>(
                builder: (context, timeClockedIn, child) {
                  // Determine the button text based on whether the user is clocked in or out.
                  final isClockedIn = timeClockedIn.clockedInTime != null;
                  // Display the elapsed time if clocked in, otherwise show '00:00'.
                  final elapsedTime = isClockedIn ? _formatDuration(timeClockedIn.elapsed) : '00:00';
                  return Column(
                    mainAxisSize: MainAxisSize.min, // Minimize the column size to fit its children.
                    children: [
                      // Display the elapsed time or '00:00' in large, bold text.
                      Text(
                        elapsedTime,
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8), // Add some space between the text elements.
                      // Show 'Clock Out' if clocked in, otherwise show 'Clock In'.
                      Text(
                        isClockedIn ? 'Clock Out' : 'Clock In',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
