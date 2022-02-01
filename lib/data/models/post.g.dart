// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 1;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      user: fields[0] as UserModel,
      comments: (fields[1] as List).cast<CommentModel>(),
      postId: fields[2] as String,
      content: fields[3] as String,
      postedAt: fields[4] as String,
      imgUrl: fields[5] as String?,
      sharedPost: fields[6] as PostModel?,
      likeCount: fields[7] as int,
      commentCount: fields[8] as int,
      liked: fields[9] == null ? false : fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.comments)
      ..writeByte(2)
      ..write(obj.postId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.postedAt)
      ..writeByte(5)
      ..write(obj.imgUrl)
      ..writeByte(6)
      ..write(obj.sharedPost)
      ..writeByte(7)
      ..write(obj.likeCount)
      ..writeByte(8)
      ..write(obj.commentCount)
      ..writeByte(9)
      ..write(obj.liked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
