import 'package:deenly/core/extensions/string/string_as_widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ZikrHomeScreen extends StatelessWidget {
  const ZikrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              child: Icon(Icons.arrow_back), onTap: () => context.pop()),
          title: Text('Zikr'),
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["Create".asDefaultButton()])));
  }
}
