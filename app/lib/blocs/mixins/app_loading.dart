import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';

mixin AppLoading {
  void showLoading() {
    di.get<LoadingBloc>().add(LoadingStated());
  }

  void hideLoading() {
    di.get<LoadingBloc>().add(LoadingStopped());
  }
}
