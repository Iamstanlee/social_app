import 'package:colco_poc/data/mappers/user_mapper.dart';
import 'package:colco_poc/data/models/comment.dart';
import 'package:colco_poc/domain/entities/comment.dart';

class CommentEntityToModelMapper {
  CommentModel call(CommentEntity comment) {
    final entityToModel = UserEntityToModelMapper();
    return CommentModel(
      user: entityToModel(comment.user),
      content: comment.content,
      postedAt: comment.postedAt,
    );
  }
}

class CommentModelToEntityMapper {
  CommentEntity call(CommentModel comment) {
    final modelToEntity = UserModelToEntityMapper();
    return CommentEntity(
      user: modelToEntity(comment.user),
      content: comment.content,
      postedAt: comment.postedAt,
    );
  }
}
