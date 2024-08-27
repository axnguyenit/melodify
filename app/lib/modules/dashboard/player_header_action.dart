part of 'media_player.dart';

class PlayerHeaderAction extends StatelessWidget {
  final bool hidden;
  final double height;

  const PlayerHeaderAction({
    super.key,
    required this.hidden,
    required this.height,
  });

  Widget _buildChild(BuildContext context) {
    if (hidden) return SizedBox(height: height);

    return Column(
      children: [
        SizedBox(height: MediaQuery.paddingOf(context).top),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            XIconButton(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.textColor,
              ),
              onPressed: MediaPlayerController().playerAnimateToMinSize,
            ),
            XIconButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: context.textColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 48),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildChild(context),
    );
  }
}
