part of 'lost_connection.dart';

class LostConnectionDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final VoidCallback? onCheckConnectionPressed;

  const LostConnectionDialog({
    super.key,
    this.icon,
    this.title = 'No Internet Connection',
    this.onCheckConnectionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBounce(
        child: AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              icon ?? XText.headlineMedium(title),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 16,
                ),
                child: SpanLabel(
                  text: context.translate(
                    Strings.noInternetConnection,
                  ),
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.all(8),
          content: Container(
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Spacer(),
                BlocBuilder<ConnectivityBloc, ConnectivityState>(
                    builder: (_, state) {
                  final isLoading = state is ConnectivityCheckInProgress;
                  return XButton(
                    title: context.translate(Strings.checkConnection),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    onPressed: onCheckConnectionPressed,
                    loading: isLoading,
                  );
                }),
                const Spacer(),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
