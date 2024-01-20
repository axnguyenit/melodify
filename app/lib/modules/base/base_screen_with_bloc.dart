import 'package:core/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/di/di.dart';

import 'base_screen.dart';

abstract class BaseScreenWithBloc<T extends StatefulWidget, B extends BaseBloc>
    extends BaseScreen<T> {
  final bool saveInstance;
  late final B _bloc;

  B get bloc => _bloc;

  BaseScreenWithBloc({this.saveInstance = false})
      : _bloc = di.bloc<B>(saveInstance: saveInstance);

  Widget buildListeners(Widget child) => child;

  Widget buildProviders(Widget child) {
    return BlocProvider<B>(
      create: (_) => bloc,
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
