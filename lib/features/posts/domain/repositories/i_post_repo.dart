import 'package:postscleanarchitecture/core/utils/typedef.dart';
import 'package:postscleanarchitecture/features/posts/domain/entities/posts_entity.dart';

abstract class IPostsRepo{
  ResultFuture<List<PostEntity >> getPostsFromDatasource();
}