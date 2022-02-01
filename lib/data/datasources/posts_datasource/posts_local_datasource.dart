import 'dart:math';
import 'package:colco_poc/core/failure/exceptions.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/data/models/comment.dart';
import 'package:colco_poc/data/models/post.dart';
import 'package:colco_poc/data/models/user.dart';
import 'package:faker/faker.dart';
import 'package:hive/hive.dart';

abstract class IPostLocalDataSource {
  /// load data into local storage for testing purposes
  void loadPostsIntoDB();

  Future<List<PostModel>> getPostsForYou({
    required int pageOffset,
  });

  Future<PostModel> createPost(PostModel post);
  void likePost(String postId);
  void dislikePost(String postId);
  void makeCommentOnPost(String postId, CommentModel comment);
}

class PostLocalDataSource implements IPostLocalDataSource {
  final Box _box;
  final Box _cacheBox;
  PostLocalDataSource(this._box, this._cacheBox);

  final _pageLimit = 2;

  @override
  Future<List<PostModel>> getPostsForYou({required int pageOffset}) async {
    try {
      return await Future.delayed(kReqTimeout, () {
        final int offset = _pageLimit * pageOffset;
        final _currentPage = _box
            .valuesBetween(
          startKey: pageOffset == 0 ? offset : offset + 1,
          endKey: pageOffset == 0 ? _pageLimit : _pageLimit + offset + 2,
        )
            .map(
          (e) {
            final _post = e as PostModel;
            if (_cacheBox.containsKey(_post.postId)) {
              return _post.copyWith(liked: true);
            }
            return _post;
          },
        ).toList();
        return _currentPage;
      });
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> createPost(PostModel post) async {
    await _box.add(post);
    return post;
  }

  PostModel? _findPostById(String postId) =>
      _box.values.firstWhere((e) => e.postId == postId, orElse: () => null);
  @override
  void dislikePost(String postId) {
    _cacheBox.delete(postId);
    PostModel? _post = _findPostById(postId);
    if (_post != null) {
      _post.likeCount--;
      _post.save();
    }
  }

  @override
  void likePost(String postId) {
    _cacheBox.put(postId, true);
    PostModel? _post = _findPostById(postId);
    if (_post != null) {
      _post.likeCount++;
      _post.save();
    }
  }

  @override
  void makeCommentOnPost(String postId, CommentModel comment) {
    PostModel? _post = _findPostById(postId);
    if (_post != null) {
      _post.commentCount++;
      _post.comments = [..._post.comments, comment];
      _post.save();
    }
  }

  @override
  void loadPostsIntoDB() async {
    if (_box.isEmpty) {
      final faker = Faker();
      final List<String> colors = <String>[
        '4DB6AC',
        '26A69A',
        'FE1B02',
        '00897B',
        '111418'
      ];
      final _posts = List.generate(20, (index) {
        final String backgroundColor = colors[Random().nextInt(colors.length)];
        bool sharedPost =
            index == 3 || index == 8 || index == 10 || index == 15;
        bool dontHaveImage =
            index == 5 || index == 7 || index == 9 || index == 14;
        return PostModel(
          user: UserModel(
            userId: faker.guid.random.string(8),
            username: faker.internet.userName(),
            bio: faker.lorem.sentence(),
          ),
          comments: List.generate(
            4,
            (index) => CommentModel(
              user: UserModel(
                userId: faker.guid.random.string(8),
                username: faker.internet.userName(),
                bio: faker.lorem.sentence(),
              ),
              content: faker.lorem.sentence(),
              postedAt: faker.date
                  .dateTime(maxYear: 2022, minYear: 2022)
                  .toIso8601String(),
            ),
          ),
          postId: faker.guid.random.string(8),
          content: faker.lorem.sentence(),
          postedAt: faker.date
              .dateTime(maxYear: 2022, minYear: 2022)
              .toIso8601String(),
          likeCount: faker.randomGenerator.integer(100),
          commentCount: 4,
          imgUrl: !dontHaveImage
              ? 'https://via.placeholder.com/200/$backgroundColor/ffffff?text=DEMO'
              : null,
          liked: false,
          sharedPost: sharedPost
              ? PostModel(
                  user: UserModel(
                    userId: faker.guid.random.string(8),
                    username: faker.internet.userName(),
                    bio: faker.lorem.sentence(),
                  ),
                  comments: List.generate(
                    4,
                    (index) => CommentModel(
                      user: UserModel(
                        userId: faker.guid.random.string(8),
                        username: faker.internet.userName(),
                        bio: faker.lorem.sentence(),
                      ),
                      content: faker.lorem.sentence(),
                      postedAt: faker.date
                          .dateTime(maxYear: 2022, minYear: 2022)
                          .toIso8601String(),
                    ),
                  ),
                  postId: faker.guid.random.string(8),
                  content: faker.lorem.sentence(),
                  postedAt: faker.date
                      .dateTime(maxYear: 2022, minYear: 2022)
                      .toIso8601String(),
                  likeCount: faker.randomGenerator.integer(100),
                  commentCount: 4,
                  liked: false,
                )
              : null,
        );
      });
      for (final e in _posts) {
        _box.add(e);
      }
    }
  }
}
