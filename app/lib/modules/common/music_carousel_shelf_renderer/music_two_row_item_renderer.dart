import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/extensions/extensions.dart';
import 'package:melodify/widgets/widgets.dart';

const double _itemHeight = 244;
const double _thumbnailSize = 160;

class MusicTwoRowItemRenderer extends StatelessWidget {
  final MusicCarouselShelf musicCarouselShelf;

  const MusicTwoRowItemRenderer({
    super.key,
    required this.musicCarouselShelf,
  });

  Future<void> _playSong(ThumbnailOverlay overlay) async {
    if (overlay.playNavigationEndpoint.videoId != null) {
      di.bloc<VideoDetailsBloc>().add(
            VideoDetailsLoaded(
              videoId: overlay.playNavigationEndpoint.videoId!,
              playlistId: overlay.playNavigationEndpoint.playlistId,
            ),
          );
    }
  }

  List<Color> _gradientThumbnailColors(YTMSectionItem item) {
    return switch (item.aspectRatio) {
      AspectRatioEnum.square => [
          Colors.black.withOpacity(0.9),
          Colors.black.withOpacity(0.1),
        ],
      _ => [Colors.transparent, Colors.transparent],
    };
  }

  Future<void> _showBottomSheet(
    BuildContext context,
    YTMSectionItem sectionItem,
  ) async {
    await ModalBottomSheet.open(
      context: context,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: XAvatar(
                imageUrl: sectionItem.thumbnails.first.url,
                borderRadius: BorderRadius.circular(4),
              ),
              title: Text(
                sectionItem.title,
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
                sectionItem.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: const EdgeInsets.only(
                left: AppConstants.appPadding,
              ),
              horizontalTitleGap: AppConstants.appPadding,
            ),
            const Divider(height: 1),
            ...sectionItem.menu.items.map((item) {
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
            // if (mediaItem.artist != null)
            //   ...mediaItem.artist.toString().split(', ').map(
            //         (artist) => ListTile(
            //           // value: artist,
            //           dense: true,
            //           leading: Icon(
            //             Icons.playlist_play_rounded,
            //             color: context.textColor,
            //             size: 26.0,
            //           ),
            //           title: Text(
            //             '${'viewArtist'} ($artist)',
            //           ),
            //           contentPadding:
            //               const EdgeInsets.symmetric(horizontal: 23),
            //           horizontalTitleGap: 23,
            //           onTap: () {},
            //         ),
            //       ),
          ],
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final MusicCarouselShelf(:header, :contents) = musicCarouselShelf;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.appPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (header.strapline.isNotNullOrEmpty)
                      Text(
                        header.strapline!,
                        style: context.bodySmall?.copyWith(
                          color: context.disabledColor,
                        ),
                      ),
                    if (header.title.isNotNullOrEmpty)
                      Text(
                        header.title!,
                        style: context.headlineSmall,
                      ),
                  ],
                ),
              ),
              if (header.moreContentButton != null) ...[
                InkWellButton(
                  border: Border.all(color: context.borderColor),
                  borderRadius: BorderRadius.circular(50),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    header.moreContentButton!.label,
                    style: context.bodySmall,
                  ),
                  onPressed: () {},
                ),
              ]
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _itemHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: contents.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.appPadding,
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final sectionItem = contents[index];

                log
                  ..trace(
                      '''TWO ROW ITEM ID --> ${sectionItem.overlay.playNavigationEndpoint.videoId}''')
                  ..trace(
                      '''Playlist ID --> ${sectionItem.overlay.playNavigationEndpoint.playlistId}''');
                return InkWellButton(
                  borderRadius: BorderRadius.circular(8),
                  onPressed: () {
                    _playSong(sectionItem.overlay);
                  },
                  onLongPress: () {
                    _showBottomSheet(context, sectionItem);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.srcATop,
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: _gradientThumbnailColors(sectionItem),
                              ).createShader(bounds);
                            },
                            child: XNetworkImage(
                              imageUrl: sectionItem.thumbnails.first.url,
                              borderRadius: BorderRadius.circular(8.0),
                              width: _thumbnailSize *
                                  sectionItem.aspectRatio.value,
                              height: _thumbnailSize,
                            ),
                          ),

                          if (sectionItem.thumbnailCornerOverlay != null)
                            Positioned(
                              top: _thumbnailSize - 24 - 12,
                              left: 12,
                              child: XAvatar(
                                imageUrl: sectionItem.thumbnailCornerOverlay!
                                    .thumbnails.first.url,
                                name: 'Kha',
                                size: 28,
                              ),
                            ),

                          if (!sectionItem.aspectRatio.isSquare)
                            Positioned(
                              top: _thumbnailSize / 2 - 18,
                              left: (_thumbnailSize *
                                          sectionItem.aspectRatio.value) /
                                      2 -
                                  18,
                              child: Container(
                                width: 36,
                                height: 36,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                          // Container(
                          //   width: 160,
                          //   height: 160,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       fit: BoxFit.contain,
                          //       image: NetworkImage(
                          //         item.thumbnails.first.url,
                          //       ),
                          //     ),
                          //   ),
                          //   child: PhysicalModel(
                          //     color: Colors.transparent,
                          //     borderRadius: BorderRadius.circular(10),
                          //     clipBehavior: Clip.antiAlias,
                          //     elevation: 5.0,
                          //     child: Image.network(
                          //       item.thumbnails.first.url,
                          //       width: 120,
                          //       height: 120,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: _thumbnailSize * sectionItem.aspectRatio.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sectionItem.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              sectionItem.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.bodySmall?.copyWith(
                                color: context.disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );

                // return SizedBox(
                //   height: width,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: itemGroup.map((item) {
                //       return Container(
                //         width: width / 2 - AppConstants.appPadding - 40,
                //         height: 226,
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //             fit: BoxFit.contain,
                //             image: NetworkImage(
                //               item.thumbnails.first.url,
                //             ),
                //           ),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // );
              },
            ),
          ),
        ),
      ],
    );
  }
}
