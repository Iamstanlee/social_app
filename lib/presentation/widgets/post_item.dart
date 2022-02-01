import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/presentation/ui/post/fullpost.dart';
import 'package:colco_poc/presentation/widgets/image.dart';
import 'package:colco_poc/presentation/widgets/reactions_count_row.dart';
import 'package:colco_poc/presentation/widgets/user_bio_row.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  final bool isDetailPage;
  const PostItem(this.post, {this.isDetailPage = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: const EdgeInsets.symmetric(vertical: Insets.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (post.sharedPost != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.sm,
                horizontal: Insets.md,
              ),
              child: Text('${post.sharedPost?.user.username} shared this'),
            ),
          UserBioRow(post),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Insets.sm,
                  horizontal: Insets.md,
                ),
                child: Text(
                  post.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (post.imgUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.sm),
                  child: HostedImage(post.imgUrl!, height: 200),
                ),
            ],
          ).onTap(
            () {
              if (!isDetailPage) {
                context.push(
                  FullPostPage(post.postId),
                  transition: Transition.sharedAxis,
                );
              }
            },
          ),
          ReactionsCountRow(post),
        ],
      ),
    );
  }
}
