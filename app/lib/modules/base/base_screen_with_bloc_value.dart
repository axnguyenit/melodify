import 'package:core/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/di/di.dart';

import 'base_screen_with_bloc.dart';

abstract class BaseScreenWithBlocValue<T extends StatefulWidget,
    B extends BaseBloc> extends BaseScreenWithBloc<T, B> {
  final Key blocKey;

  @override
  B get bloc => di.blocFromKey<B>(blocKey)!;

  BaseScreenWithBlocValue(this.blocKey);

  @override
  Widget buildProviders(Widget child) {
    return BlocProvider<B>.value(
      value: bloc,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar,
      body: buildProviders(buildListeners(buildBody)),
      bottomNavigationBar: buildBottomNavigationBar,
      floatingActionButton: buildFloatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
