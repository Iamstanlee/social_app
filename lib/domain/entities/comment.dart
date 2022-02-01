import 'package:colco_poc/domain/entities/user.dart';

class CommentEntity {
  final UserEntity user;
  final String content;
  final String postedAt;
  CommentEntity({
    required this.user,
    required this.content,
    required this.postedAt,
  });
}
