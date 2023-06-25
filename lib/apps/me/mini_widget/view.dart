import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MiniWidgetPage extends StatelessWidget {
  final logic = Get.find<MiniWidgetLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('小组件'),),
      body: ListView(
        children: [
          Text('设置',style: Get.textTheme.bodySmall,)
        ],
      ),
    );
  }
}
