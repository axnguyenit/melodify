import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState
    extends BaseScreenWithBloc<SearchScreen, QuerySuggestionBloc> {
  late DebounceTimer _debounceTimer;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _debounceTimer = DebounceTimer();
    _controller.addListener(_listenSearchFieldChange);
  }

  void _listenSearchFieldChange() {
    _debounceTimer.debounce(() {
      if (_controller.text.isNullOrEmpty) return;
      bloc.add(
        QuerySuggestionSubmitted(
          query: _controller.text,
        ),
      );
    });
  }

  @override
  void dispose() {
    _debounceTimer.dispose();
    _controller
      ..removeListener(_listenSearchFieldChange)
      ..dispose();

    super.dispose();
  }

  OutlineInputBorder get _inputBorder {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(50),
    );
  }

  @override
  Widget buildListeners(Widget child) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuerySuggestionBloc, QuerySuggestionState>(
          listenWhen: (_, current) => current is QuerySuggestionSubmitSuccess,
          listener: (context, state) {},
        )
      ],
      child: child,
    );
  }

  @override
  PreferredSizeWidget? get buildAppBar {
    return XAppBar(
      spacing: 0,
      statusBarHeight: MediaQuery.of(context).padding.top,
      left: IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          color: context.textColor,
        ),
        onPressed: router.pop,
      ),
      center: TextField(
        autofocus: true,
        controller: _controller,
        decoration: InputDecoration(
          border: _inputBorder,
          errorBorder: _inputBorder,
          enabledBorder: _inputBorder,
          focusedBorder: _inputBorder,
          disabledBorder: _inputBorder,
          focusedErrorBorder: _inputBorder,
          hintText: 'Search...',
          // contentPadding: AppConstants.inputContentPadding.copyWith(left: 3),
          suffixIcon: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.text.isNullOrEmpty) return const SizedBox();

              return IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: _controller.clear,
              );
            },
          ),
          // fillColor: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget get buildBody {
    return BlocBuilder<QuerySuggestionBloc, QuerySuggestionState>(
      buildWhen: (_, current) =>
          current is QuerySuggestionSubmitInProgress ||
          current is QuerySuggestionSubmitSuccess,
      builder: (context, state) {
        if (state is QuerySuggestionInitial) {
          return const SizedBox();
        }

        if (state is! QuerySuggestionSubmitSuccess) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.suggestions.isEmpty) {
          return Center(
            child: Text(
              context.translate(
                'No data found',
              ),
              style: context.bodyLarge?.copyWith(
                color: context.disabledColor,
              ),
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = state.suggestions[index];

            return ListTile(
              visualDensity: VisualDensity.compact,
              horizontalTitleGap: 28,
              leading: const Icon(
                Icons.search_rounded,
                size: 20,
              ),
              title: Text(
                suggestion,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                // router.pop(prediction);
              },
            );
          },
        );
      },
    );
  }
}
