import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/extensions/extensions.dart';
import 'package:melodify/widgets/widgets.dart';

class MusicMoreMenu extends StatefulWidget {
  final Function(Map)? deleteLiked;
  final YTMSectionItem sectionItem;

  const MusicMoreMenu({
    super.key,
    this.deleteLiked,
    required this.sectionItem,
  });

  @override
  State<MusicMoreMenu> createState() => _MusicMoreMenuState();
}

class _MusicMoreMenuState extends State<MusicMoreMenu> {
  Future<void> _showBottomSheet() async {
    await ModalBottomSheet.open(
      context: context,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: XAvatar(
                imageUrl: widget.sectionItem.thumbnails.first.url,
                borderRadius: BorderRadius.circular(4),
              ),
              title: Text(
                widget.sectionItem.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  XIconButton(
                    icon: AppIcon(
                      assetName: AppIcons.thumbDownOutline,
                      color: context.textColor,
                    ),
                    onPressed: () {},
                  ),
                  XIconButton(
                    icon: AppIcon(
                      assetName: AppIcons.thumbUpOutline,
                      color: context.textColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              subtitle: Text(
                widget.sectionItem.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: const EdgeInsets.only(
                left: AppConstants.appPadding,
              ),
              horizontalTitleGap: AppConstants.appPadding,
            ),
            const Divider(height: 1),
            ...widget.sectionItem.menu.items.map((item) {
              return ListTile(
                // value: 7,
                dense: true,
                leading: AppIcon(
                  assetName: item.iconType.iconPath,
                  color: context.textColor,
                  width: 26.0,
                  height: 26.0,
                ),
                title: Text(item.title),
                contentPadding: const EdgeInsets.symmetric(horizontal: 23),
                horizontalTitleGap: 23,
                onTap: () {},
              );
            }),
            // ListTile(
            //   // value: 7,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.rfidOutline,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.playRadio)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 2,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.playlist,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.playNext)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 1,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.playlist2,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.addToQueue)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 2,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.rfidOutline,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.download)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 0,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.playlistAdd,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.saveToPlaylist)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 4,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.album,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.goToAlbum)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 2,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.userMusicOutline,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.goToArtist)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 2,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.rfidOutline,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.viewSongCredits)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
            // ListTile(
            //   // value: 3,
            //   dense: true,
            //   leading: AppIcon(
            //     assetName: AppIcons.shareOutline,
            //     color: context.textColor,
            //     width: 26.0,
            //     height: 26.0,
            //   ),
            //   title: Text(context.translate(Strings.share)),
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 23),
            //   horizontalTitleGap: 23,
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return XIconButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: context.textColor,
      ),
      onPressed: _showBottomSheet,
    );
  }
}
