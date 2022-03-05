import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/core/utils/view_state.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/widgets/loading_indicator.dart';
import 'package:colco_poc/presentation/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({Key? key}) : super(key: key);

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final _postProvider = context.read<PostsProvider>();
    if (_postProvider.postsData.data!.isEmpty) {
      Future.microtask(() => _postProvider.getForYouPosts());
    }
    scrollController.addListener(paginate);
    super.initState();
  }

  void paginate() {
    final _postProvider = context.read<PostsProvider>();

    if ((scrollController.position.pixels >=
        scrollController.position.maxScrollExtent)) {
      if (!_postProvider.isLoadingMore) {
        _postProvider.getForYouPosts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _postProvider = context.watch<PostsProvider>();
    final _viewstate = _postProvider.postsData;
    final _posts = _viewstate.data!;
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            elevation: 0.2,
            title: Text(
              'For you',
              style: context.textTheme.subtitle1!.copyWith(color: Colors.white),
            ),
          ),
          if (_viewstate.status == Status.error)
            SliverFillRemaining(
              child: Center(
                child: Text("Error: ${_viewstate.message}"),
              ),
            )
          else if (_posts.isEmpty)
            const SliverFillRemaining(
              child: LoadingIndicator(),
            )
          else
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) =>
                        PostItem(_posts[i]),
                    separatorBuilder: (BuildContext context, int i) =>
                        const Divider(),
                    itemCount: _posts.length,
                  )
                ],
              ),
            ),
          if (_postProvider.isLoadingMore && _posts.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.md),
                child: Center(
                  child: Text(
                    "Loading more...",
                    style: context.textTheme.bodyText1!.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
