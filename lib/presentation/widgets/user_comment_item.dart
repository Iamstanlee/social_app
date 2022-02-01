import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/presentation/widgets/gap.dart';
import 'package:colco_poc/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class UserCommentItem extends StatelessWidget {
  final CommentEntity comment;
  const UserCommentItem(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = comment.user;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.md,
        vertical: Insets.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserAvatar(maxRadius: 18),
          Gap.sm,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: Corners.smBorder,
                color: AppColors.kLightGrey,
              ),
              padding: const EdgeInsets.all(Insets.sm),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: context.textTheme.subtitle1!.copyWith(),
                    ),
                    Text(user.bio,
                        maxLines: 1, style: context.textTheme.caption),
                    Text(Jiffy(comment.postedAt).fromNow(),
                        style: context.textTheme.caption),
                    Gap.sm,
                    Text(comment.content),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
