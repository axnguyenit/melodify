import 'package:flutter/material.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/mixins/mixins.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T>
    with StateMixin, SessionData, ToastShowing {
  final router = Routing();

  bool get extendBodyBehindAppBar => false;

  bool get resizeToAvoidBottomInset => true;

  PreferredSizeWidget? get buildAppBar => null;

  Widget get buildBody;

  Widget? get buildBottomNavigationBar => null;

  Widget? get buildFloatingActionButton => null;

  FloatingActionButtonLocation get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerFloat;

  double get statusBarHeight => AppConstants.statusBarHeight;

  double get horizontalPadding => AppConstants.appPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar,
      body: buildBody,
      bottomNavigationBar: buildBottomNavigationBar,
      floatingActionButton: buildFloatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
