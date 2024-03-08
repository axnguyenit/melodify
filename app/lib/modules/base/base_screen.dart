import 'package:flutter/material.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/mixins/mixins.dart';

abstract class BaseScreen<T extends StatefulWidget> extends State<T>
    with StateMixin, SessionData, ToastShowing {
  @protected
  final router = Routing();

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  PreferredSizeWidget? get buildAppBar => null;

  @protected
  Widget get buildBody;

  @protected
  Widget? get buildBottomNavigationBar => null;

  @protected
  Widget? get buildFloatingActionButton => null;

  @protected
  FloatingActionButtonLocation get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerFloat;

  @protected
  double get statusBarHeight => MediaQuery.paddingOf(context).top;

  @protected
  double get screenWidth => MediaQuery.sizeOf(context).width;

  @protected
  double get screenHeight => MediaQuery.sizeOf(context).height;

  @protected
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
