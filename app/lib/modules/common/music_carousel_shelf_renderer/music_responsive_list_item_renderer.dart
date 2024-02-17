import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/common/common.dart';
import 'package:melodify/widgets/widgets.dart';

import 'music_more_menu.dart';

class MusicResponsiveListItemRenderer extends StatelessWidget {
  final MusicCarouselShelf musicCarouselShelf;

  const MusicResponsiveListItemRenderer({
    super.key,
    required this.musicCarouselShelf,
  });

  @override
  Widget build(BuildContext context) {
    final MusicCarouselShelf(
      :header,
      :contents,
      :numItemsPerColumn,
    ) = musicCarouselShelf;
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    final rotated = height < width;
    final biggerScreen = width > 1024;
    final portion = (contents.length <= numItemsPerColumn) ? 1.0 : 0.9;
    final listSize = rotated
        ? biggerScreen
            ? width * portion / 3
            : width * portion / 2
        : width * portion;
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
          height: contents.length < numItemsPerColumn
              ? contents.length * 72.0
              : 72.0 * numItemsPerColumn,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              physics: XPageScrollPhysics(itemDimension: listSize),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemExtent: listSize,
              itemCount: (contents.length / numItemsPerColumn).ceil(),
              itemBuilder: (context, index) {
                final items = contents
                    .skip(index * numItemsPerColumn)
                    .take(numItemsPerColumn);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items.map((item) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                      ),
                      title: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleSmall?.copyWith(
                          color: context.textColor,
                        ),
                      ),
                      subtitle: Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodySmall?.copyWith(
                          color: context.iconColor,
                        ),
                      ),
                      leading: XNetworkImage(
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                        imageUrl: item.thumbnails.first.url,
                        borderRadius: BorderRadius.circular(2),
                        // placeholderImage: (item['type'] == 'playlist' ||
                        //         item['type'] == 'album')
                        //     ? const AssetImage(
                        //         'assets/album.png',
                        //       )
                        //     : item['type'] == 'artist'
                        //         ? const AssetImage(
                        //             'assets/artist.png',
                        //           )
                        //         : const AssetImage(
                        //             'assets/cover.jpg',
                        //           ),
                      ),
                      trailing: MusicMoreMenu(sectionItem: item),
                      onTap: () {},
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
