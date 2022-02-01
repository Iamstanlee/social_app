import 'package:colco_poc/core/utils/view_state.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/domain/usecases/comment_on_post_usecase.dart';
import 'package:colco_poc/domain/usecases/create_post_usecase.dart';
import 'package:colco_poc/domain/usecases/dislike_post_usecase.dart';
import 'package:colco_poc/domain/usecases/get_posts_for_you.dart';
import 'package:colco_poc/domain/usecases/like_post_usecase.dart';
import 'package:flutter/material.dart';

class PostsProvider with ChangeNotifier {
  final GetPostsForYouUsecase _getPostsForYouUsecase;
  final LikePostUsecase _likePostUsecase;
  final DislikePostUsecase _dislikePostUsecase;
  final CommentOnPostUsecase _commentOnPostUsecase;
  final CreatePostUsecase _createPostUsecase;
  PostsProvider({
    required GetPostsForYouUsecase getPostsForYouUsecase,
    required LikePostUsecase likePostUsecase,
    required DislikePostUsecase dislikePostUsecase,
    required CommentOnPostUsecase commentOnPostUsecase,
    required CreatePostUsecase createPostUsecase,
  })  : _getPostsForYouUsecase = getPostsForYouUsecase,
        _likePostUsecase = likePostUsecase,
        _dislikePostUsecase = dislikePostUsecase,
        _commentOnPostUsecase = commentOnPostUsecase,
        _createPostUsecase = createPostUsecase;

  DataState<List<PostEntity>> _postsData = DataState.empty(null, []);
  DataState<List<PostEntity>> get postsData => _postsData;
  set postsData(DataState<List<PostEntity>> value) {
    _postsData = value;
    notifyListeners();
  }

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  int _pageOffset = 0;

  void getForYouPosts() async {
    isLoadingMore = true;
    final failureOrPosts = await _getPostsForYouUsecase(param: _pageOffset);
    failureOrPosts.fold(
      (failure) {
        if (postsData.data!.isEmpty) {
          postsData = DataState.error("An unexpected error occured");
        }
      },
      (posts) {
        if (posts.isNotEmpty) {
          final _previousPosts = postsData.data;
          postsData = DataState.done([..._previousPosts!, ...posts]);
          _pageOffset++;
        }
      },
    );
    isLoadingMore = false;
  }

  void likePost(String postId) async {
    final failureOrSuccess = await _likePostUsecase(param: postId);
    failureOrSuccess.fold(
      (failure) => null,
      (success) => postsData = DataState.done(
        postsData.data!
            .map<PostEntity>((e) => e.postId == postId
                ? e.copyWith(liked: !e.liked, likeCount: e.likeCount + 1)
                : e)
            .toList(),
      ),
    );
  }

  void dislikePost(String postId) async {
    final failureOrSuccess = await _dislikePostUsecase(param: postId);
    failureOrSuccess.fold(
      (failure) => null,
      (success) => postsData = DataState.done(
        postsData.data!
            .map<PostEntity>((e) => e.postId == postId
                ? e.copyWith(liked: !e.liked, likeCount: e.likeCount - 1)
                : e)
            .toList(),
      ),
    );
  }

  void makeCommentOnPost(String postId, CommentEntity comment) async {
    final params = CommentParams(postId, comment);
    final failureOrSuccess = await _commentOnPostUsecase(param: params);
    failureOrSuccess.fold(
      (failure) => null,
      (success) {
        postsData = DataState.done(
          postsData.data!
              .map<PostEntity>((e) => e.postId == params.postId
                  ? e.copyWith(
                      commentCount: e.commentCount + 1,
                      comments: [...e.comments, params.comment])
                  : e)
              .toList(),
        );
      },
    );
  }

  void sharePost(PostEntity post) async {
    final failureOrSuccess = await _createPostUsecase(param: post);
    failureOrSuccess.fold((failure) => null, (success) {
      final updated = postsData.data!..insert(0, post);
      postsData = DataState.done(updated);
    });
  }
}
