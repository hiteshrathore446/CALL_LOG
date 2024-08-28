import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CallHistoryScreen extends StatefulWidget {
  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  static const platform = MethodChannel('callLogChannel');
  List<Map<dynamic, dynamic>> _callLogs = [];

  @override
  void initState() {
    super.initState();
    fetchCallLogs("1234567890");
  }

  Future<void> fetchCallLogs(String mobileNumber) async {
    try {
      final List<dynamic> result = await platform
          .invokeMethod('getCallLogs', {"mobileNumber": mobileNumber});
      setState(() {
        _callLogs = List<Map<dynamic, dynamic>>.from(result);
      });
    } on PlatformException catch (e) {
      print("Failed to get call logs: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call History"),
      ),
      body: _callLogs.isEmpty
          ? Center(child: Text("No call logs found for the last 12 hours"))
          : ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                final log = _callLogs[index];
                return ListTile(
                  leading: Icon(
                    log['type'] == 'Incoming'
                        ? Icons.call_received
                        : log['type'] == 'Outgoing'
                            ? Icons.call_made
                            : Icons.call_missed,
                    color: log['type'] == 'Missed' ? Colors.red : Colors.green,
                  ),
                  title: Text(log['number']),
                  subtitle: Text(
                      "${log['type']} on ${log['date']} for ${log['duration']} seconds"),
                );
              },
            ),
    );
  }
}
