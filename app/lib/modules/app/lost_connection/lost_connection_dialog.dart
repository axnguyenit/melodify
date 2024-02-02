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
          content: Container(
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: context.titleMedium),
                const SizedBox(height: 16),
                icon ??
                    const Icon(
                      Icons.wifi_off_rounded,
                      size: 80,
                    ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Spacer(),
                    BlocBuilder<ConnectivityBloc, ConnectivityState>(
                      builder: (_, state) {
                        final isLoading = state is ConnectivityCheckInProgress;

                        return XButton(
                          title: context.translate(Strings.checkConnection),
                          onPressed: onCheckConnectionPressed,
                          loading: isLoading,
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
