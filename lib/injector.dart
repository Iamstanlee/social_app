import 'package:colco_poc/core/utils/device.dart';
import 'package:colco_poc/data/datasources/posts_datasource/posts_local_datasource.dart';
import 'package:colco_poc/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:colco_poc/data/models/comment.dart';
import 'package:colco_poc/data/models/post.dart';
import 'package:colco_poc/data/models/user.dart';
import 'package:colco_poc/data/repositories/posts_repository.dart';
import 'package:colco_poc/data/repositories/user_repository_impl.dart';
import 'package:colco_poc/domain/repositories/posts_repository.dart';
import 'package:colco_poc/domain/repositories/user_repository.dart';
import 'package:colco_poc/domain/usecases/comment_on_post_usecase.dart';
import 'package:colco_poc/domain/usecases/create_post_usecase.dart';
import 'package:colco_poc/domain/usecases/dislike_post_usecase.dart';
import 'package:colco_poc/domain/usecases/get_posts_for_you.dart';
import 'package:colco_poc/domain/usecases/get_user_usecase.dart';
import 'package:colco_poc/domain/usecases/like_post_usecase.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/providers/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.I;

Future<void> initApp() async {
  Hive.init(await DeviceUtils.getStorageDirectory());
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<PostModel>(PostModelAdapter());
  Hive.registerAdapter<CommentModel>(CommentModelAdapter());

  /// misc
  getIt.registerFactoryParamAsync<Box, String, void>(
      (String? name, _) async => await Hive.openBox(name!));

  /// datasources
  getIt.registerSingleton<IUserLocalDataSource>(
      UserLocalDataSource(await getIt.getAsync<Box>(param1: "user")));
  getIt.registerSingleton<IPostLocalDataSource>(
    PostLocalDataSource(
      await getIt.getAsync<Box>(param1: "posts"),
      await getIt.getAsync<Box>(param1: "liked"),
    )..loadPostsIntoDB(),
  );

  /// repositories
  getIt.registerSingleton<IUserRepository>(UserRepository(getIt()));
  getIt.registerSingleton<IPostRepository>(
      PostRepository(postLocalDataSource: getIt()));

  /// usecases
  getIt.registerSingleton<GetUserUsecase>(GetUserUsecase(getIt()));
  getIt
      .registerSingleton<GetPostsForYouUsecase>(GetPostsForYouUsecase(getIt()));
  getIt.registerSingleton<LikePostUsecase>(LikePostUsecase(getIt()));
  getIt.registerSingleton<DislikePostUsecase>(DislikePostUsecase(getIt()));
  getIt.registerSingleton<CommentOnPostUsecase>(CommentOnPostUsecase(getIt()));
  getIt.registerSingleton<CreatePostUsecase>(CreatePostUsecase(getIt()));

  /// providers
  getIt.registerSingleton<UserProvider>(
    UserProvider(getUserUsecase: getIt())..getUser(),
  );
  getIt.registerSingleton<PostsProvider>(
    PostsProvider(
      getPostsForYouUsecase: getIt(),
      likePostUsecase: getIt(),
      dislikePostUsecase: getIt(),
      commentOnPostUsecase: getIt(),
      createPostUsecase: getIt(),
    ),
  );
}
