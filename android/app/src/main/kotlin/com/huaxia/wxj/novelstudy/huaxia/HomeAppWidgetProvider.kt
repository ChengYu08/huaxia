package com.huaxia.wxj.novelstudy.huaxia

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeAppWidgetProvider: HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId->
            val views = RemoteViews(context.packageName, R.layout.appwidget_provider_layout).apply {
            // Open App on Widget Click
            val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java)
            setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            // Swap Title Text by calling Dart Code in the Background
            setTextViewText(R.id.widget_title, widgetData.getString("title", null)
                ?: "No Title Set")
            val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
                context,
                Uri.parse("homeWidgetInfo://titleClicked")
            )
            setOnClickPendingIntent(R.id.widget_title, backgroundIntent)

            val message = widgetData.getString("message", null)
            setTextViewText(R.id.widget_message, message
                ?: "No Message Set")
            // Detect App opened via Click inside Flutter
            val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse("homeWidgetInfo://message?message=$message"))
            setOnClickPendingIntent(R.id.widget_message, pendingIntentWithData)
        }
            appWidgetManager.updateAppWidget(widgetId, views) }
    }


    override fun onAppWidgetOptionsChanged(
        context: Context?,
        appWidgetManager: AppWidgetManager?,
        appWidgetId: Int,
        newOptions: Bundle?
    ) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    }

    override fun onRestored(context: Context?, oldWidgetIds: IntArray?, newWidgetIds: IntArray?) {
        super.onRestored(context, oldWidgetIds, newWidgetIds)
    }


}