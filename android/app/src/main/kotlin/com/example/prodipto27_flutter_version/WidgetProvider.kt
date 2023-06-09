package com.example.prodipto27_flutter_version  // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Intent


class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                // get widget string data
                val day_and_date_text = widgetData.getString("day_and_date", get_day_and_date())
                setTextViewText(R.id.day_and_date, day_and_date_text)

                val current_class_text = widgetData.getString("current_class", "")
                setTextViewText(R.id.current_class, current_class_text)

                val classes_and_time_text = widgetData.getString("classes_and_time", "Please open the app to initialize the widget!")
                setTextViewText(R.id.classes_and_time, classes_and_time_text)

                // Pending intent to update counter on button click
                /*val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                        Uri.parse("myAppWidget://updatecounter"))
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)*/
            }

            val updateIntent = Intent(context, HomeScreenWidgetProvider::class.java)
            updateIntent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            updateIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
            val pendingIntent = PendingIntent.getBroadcast(context, 0, updateIntent, PendingIntent.FLAG_UPDATE_CURRENT)

            val intervalMillis: Long = 5 * 60 * 1000 // 5 minutes in milliseconds
            val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
            alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis(), intervalMillis, pendingIntent)


            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun get_day_and_date(): String {
        // Get current day and date
        val calendar = Calendar.getInstance()
        val dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)
        val currentDate = calendar.get(Calendar.DATE)

        // Format day of week as a string
        val dayFormat = SimpleDateFormat("EEEE", Locale.getDefault())
        val dayOfWeekString = dayFormat.format(calendar.time)

        // Format date as a string
        val dateFormat = SimpleDateFormat("dd MMMM", Locale.getDefault())
        val currentDateString = dateFormat.format(calendar.time)

        // Print the day and date as strings
        return "$dayOfWeekString, $currentDateString"
    }
}