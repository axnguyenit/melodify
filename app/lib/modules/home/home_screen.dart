import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/configs/config.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  final languageBloc = di.get<LanguageBloc>();

  @override
  PreferredSizeWidget? get buildAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(context.translate(Strings.home)),
    );
  }

  @override
  Widget get buildBody {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppIcon(assetName: CommonIcons.stripe),
                const Icon(Icons.ac_unit_rounded),
                XText.headlineMedium(context.translate(Strings.home)),
                XText.headlineMedium('Hello ${authUser.firstName}'),
                Container(
                  width: AppConstants.screenSize.width * 0.5,
                  height: 150,
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: context.disabledBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: XText.titleMedium(
                    'Disabled',
                    style: context.titleMedium?.copyWith(
                      color: context.disabledColor,
                    ),
                  ),
                ),
                BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    return SwitchListTile.adaptive(
                      title: XText(
                        context.translate(Strings.english),
                      ),
                      // tileColor: AppColors.current.primaryColor,
                      value: state.locale.languageCode ==
                          Config().secondaryLanguage,
                      onChanged: (value) {
                        languageBloc.add(
                          LanguageUpdated(
                            value
                                ? state.supportedLocales.first
                                : state.supportedLocales.last,
                          ),
                        );
                      },
                    );
                  },
                ),
                Container(
                  width: AppConstants.screenSize.width * 0.8,
                  height: 200,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: context.shadowColor.withOpacity(0.2),
                      ),
                      BoxShadow(
                        offset: const Offset(0.0, 12.0),
                        blurRadius: 24.0,
                        spreadRadius: -4.0,
                        color: context.shadowColor.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: Card(
                    child: Container(
                      width: AppConstants.screenSize.width * 0.5,
                      height: 150,
                      padding: const EdgeInsets.all(40.0),
                      child: const Text('Hello'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: XButton(
            title: 'Sign Out',
            onPressed: () {
              di.bloc<SessionBloc>().add(const SessionSignedOut());
            },
          ),
        ),
      ],
    );
  }
}
