import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/video_player.dart';
import 'package:http/http.dart' as http;

class EditBottomImageListview extends StatefulWidget {
  const EditBottomImageListview({
    super.key,
    required this.imageUrlList,
  });

  final List imageUrlList;

  @override
  State<EditBottomImageListview> createState() =>
      _EditBottomImageListviewState();
}

class _EditBottomImageListviewState extends State<EditBottomImageListview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: 100,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.imageUrlList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String imageUrl = widget.imageUrlList[index];
          // assetEntity.file.then((value) => print(value));
          bool isVideo = imageUrl.contains('video');
          return Container(
            margin: const EdgeInsets.only(left: 15),
            width: 90,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () async {
                      // await AssetPickerViewer.pushToViewer(
                      //   context,
                      //   previewAssets: widget.selectedAssetList,
                      //   themeData: imagePreviewlightTheme,
                      // );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: isVideo
                          ? VideoPlayerWidget(videoUrl: imageUrl)
                          : Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
                if (isVideo)
                  Positioned(
                    bottom: 2,
                    left: 5,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        FutureBuilder(
                          future: getVideoDuration(imageUrl),
                          builder: (context,snapshot) {
                            return Text(
                              '${formattedTime(timeInSecond: snapshot.hasData ? snapshot.data! : 0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.imageUrlList.contains(imageUrl)) {
                        setState(() {
                          widget.imageUrlList.remove(imageUrl);
                        });
                      }
                    },
                    child: const CircleAvatar(
                      radius: 10,
                      backgroundColor: kWhite,
                      foregroundColor: kBlack,
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<int> getVideoDuration(String url) async {
  final response = await http.head(Uri.parse(url));
  final contentLength = response.contentLength;
  if (contentLength == null) {
    throw Exception('Failed to get video duration');
  }
  return (contentLength / 1000).round();
}