import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/providers/user_provider.dart';
import 'package:colco_poc/presentation/widgets/button.dart';
import 'package:colco_poc/presentation/widgets/gap.dart';
import 'package:colco_poc/presentation/widgets/user_avatar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class UserBioRow extends StatelessWidget {
  final PostEntity post;
  const UserBioRow(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = post.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Row(
        children: [
          const UserAvatar(),
          Gap.md,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: context.textTheme.subtitle1!.copyWith(),
                ),
                Text(user.bio, maxLines: 1, style: context.textTheme.caption),
                Text(Jiffy(post.postedAt).fromNow(),
                    style: context.textTheme.caption)
              ],
            ),
          ),
          Icon(
            PhosphorIcons.arrowElbowUpRight,
            color: AppColors.kPrimary,
          ).onTap(
            () => showCupertinoModalPopup(
              context: context,
              builder: (context) => ShareBottomSheet(
                share: () {
                  final faker = Faker();
                  final _post = post.copyWith(
                    postId: faker.guid.random.string(8),
                    sharedPost: PostEntity(
                      user: context.read<UserProvider>().userData.data!,
                      postedAt: DateTime.now().toIso8601String(),
                      comments: [],
                      postId: '',
                      content: '',
                      likeCount: 0,
                      commentCount: 0,
                      imgUrl: null,
                      sharedPost: null,
                      liked: false,
                    ),
                  );
                  context.read<PostsProvider>().sharePost(_post);
                  context.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShareBottomSheet extends StatelessWidget {
  final VoidCallback? share;
  const ShareBottomSheet({this.share, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(factor: 0.2),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            Button(
              "SHARE POST",
              onTap: () => share!(),
            ),
          ],
        ),
      ),
    );
  }
}
