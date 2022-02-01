import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/ui/post/fullpost.dart';
import 'package:colco_poc/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ReactionsCountRow extends StatelessWidget {
  final PostEntity post;
  const ReactionsCountRow(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postsProvider = context.watch<PostsProvider>();
    final int likeCount = post.likeCount, commentCount = post.commentCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                post.liked
                    ? PhosphorIcons.thumbsUpFill
                    : PhosphorIcons.thumbsUp,
                color: post.liked ? const Color(0xFFFE1B02) : AppColors.kGrey,
                size: IconSizes.xs,
              ).onTap(() {
                if (post.liked) {
                  _postsProvider.dislikePost(post.postId);
                } else {
                  _postsProvider.likePost(post.postId);
                }
              }),
              Gap.sm,
              Text('$likeCount likes', style: context.textTheme.caption)
            ],
          ),
          Row(
            children: [
              const Icon(PhosphorIcons.chatTeardrop, size: IconSizes.xs),
              Gap.sm,
              Text('$commentCount comments', style: context.textTheme.caption)
                  .onTap(() {
                context.push(
                  FullPostPage(post.postId),
                  transition: Transition.sharedAxis,
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
