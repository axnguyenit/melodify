import 'package:flutter/material.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:resources/resources.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends BaseScreen<ExploreScreen> {
  @override
  Widget get buildBody {
    return Center(
      child: Text(context.translate(Strings.explore)),
    );
  }
}
