import 'package:flutter/material.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:resources/resources.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends BaseScreen<LibraryScreen> {
  @override
  Widget get buildBody {
    return Center(
      child: Text(context.translate(Strings.library)),
    );
  }
}
