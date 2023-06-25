import 'package:home_widget/home_widget.dart';

class AppWidget {
  static Future upWidgetData({String? title, String? message}) async {
    if (title != null) {
      final t2 = await HomeWidget.getWidgetData('title');
      if (t2 != title) {
        await HomeWidget.saveWidgetData('title', title);
      }
    }
    if (message != null) {
      final s2 = await HomeWidget.getWidgetData('message');
      if (s2 != message) {
        await HomeWidget.saveWidgetData('message', message);
      }
    }

    _upWidget();
  }

  static Future _upWidget() {
    return HomeWidget.updateWidget(
        name: 'HomeAppWidgetProvider',
        iOSName: '',
        qualifiedAndroidName:
            'com.huaxia.wxj.novelstudy.huaxia.HomeAppWidgetProvider');
  }
}
