import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.provider.CallLog
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "callLogChannel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Use the let function to ensure the binaryMessenger is not null
        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
            MethodChannel(binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "getCallLogs") {
                    val mobileNumber = call.argument<String>("mobileNumber")
                    val logs = getCallLogs(mobileNumber)
                    result.success(logs)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getCallLogs(mobileNumber: String?): List<Map<String, String>> {
        val logs = mutableListOf<Map<String, String>>()
        val formatter = SimpleDateFormat("dd/MM/yyyy HH:mm", Locale.getDefault())
        val twelveHoursAgo = System.currentTimeMillis() - 12 * 60 * 60 * 1000 // 12 hours ago

        val cursor = contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            null,
            "${CallLog.Calls.DATE} >= ? AND ${CallLog.Calls.NUMBER} = ?",
            arrayOf(twelveHoursAgo.toString(), mobileNumber),
            "${CallLog.Calls.DATE} DESC"
        )

        cursor?.use {
            val numberIndex = it.getColumnIndex(CallLog.Calls.NUMBER)
            val typeIndex = it.getColumnIndex(CallLog.Calls.TYPE)
            val dateIndex = it.getColumnIndex(CallLog.Calls.DATE)
            val durationIndex = it.getColumnIndex(CallLog.Calls.DURATION)

            while (it.moveToNext()) {
                val number = it.getString(numberIndex)
                val type = it.getInt(typeIndex)
                val date = it.getLong(dateIndex)
                val duration = it.getString(durationIndex)
                val formattedDate = formatter.format(Date(date))

                val typeStr = when (type) {
                    CallLog.Calls.INCOMING_TYPE -> "Incoming"
                    CallLog.Calls.OUTGOING_TYPE -> "Outgoing"
                    CallLog.Calls.MISSED_TYPE -> "Missed"
                    else -> "Unknown"
                }

                logs.add(
                    mapOf(
                        "number" to number,
                        "type" to typeStr,
                        "date" to formattedDate,
                        "duration" to duration
                    )
                )
            }
        }

        return logs
    }
}
