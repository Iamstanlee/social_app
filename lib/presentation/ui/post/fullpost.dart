import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/providers/user_provider.dart';
import 'package:colco_poc/presentation/widgets/comment_box.dart';
import 'package:colco_poc/presentation/widgets/post_item.dart';
import 'package:colco_poc/presentation/widgets/user_comment_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullPostPage extends StatelessWidget {
  final String postId;
  const FullPostPage(this.postId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final post = context
        .watch<PostsProvider>()
        .postsData
        .data!
        .singleWhere((e) => e.postId == postId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0.2,
            title: Text(
              'Post',
              style: context.textTheme.subtitle1!.copyWith(color: Colors.white),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PostItem(
                  post,
                  isDetailPage: true,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) =>
                      UserCommentItem(post.comments[i]),
                  itemCount: post.comments.length,
                ),
                const SizedBox(height: 50 + Insets.md)
              ],
            ),
          ),
        ],
      ),
      bottomSheet: CommentBox(
        send: (value) {
          final _postsProvider = context.read<PostsProvider>();
          final _user = context.read<UserProvider>().userData.data!;
          final comment = CommentEntity(
            user: _user,
            content: value,
            postedAt: DateTime.now().toIso8601String(),
          );
          _postsProvider.makeCommentOnPost(postId, comment);
        },
      ),
    );
  }
}
