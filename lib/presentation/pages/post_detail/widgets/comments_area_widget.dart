import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comment_card_widget.dart';

class CommentAreaWidget extends StatelessWidget {
  const CommentAreaWidget({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return postModel.comments!.isEmpty
            ? Column(
                children: [
                  kHeight(70),
                  Center(
                    child: Text(
                      'No comments!',
                      style: TextStyle(
                        fontSize: 16,
                        fontVariations: fontWeightW600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  kHeight(70),
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: postModel.comments!.length,
                itemBuilder: (context, index) {
                  return CommentCardWidget(
                    commentModel: postModel.comments![index],
                    postModel: postModel,
                  );
                },
              );
      },
    );
  }
}
