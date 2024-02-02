import 'package:flutter/material.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:resources/resources.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreen<SettingsScreen> {
  @override
  Widget get buildBody {
    return Center(
      child: Text(context.translate(Strings.settings)),
    );
  }
}
