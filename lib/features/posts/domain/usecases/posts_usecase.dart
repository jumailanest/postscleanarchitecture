import 'package:injectable/injectable.dart';
import 'package:postscleanarchitecture/core/usecase/usecase.dart';
import 'package:postscleanarchitecture/core/utils/typedef.dart';
import 'package:postscleanarchitecture/features/posts/domain/repositories/i_post_repo.dart';

import '../entities/posts_entity.dart';


@injectable
class PostsUseCase implements UsecaseWithoutParams<List<PostEntity>>{

final IPostsRepo postsRepo;

PostsUseCase({required this.postsRepo});

  @override
  ResultFuture<List<PostEntity>> call() async{
    final posts = await postsRepo.getPostsFromDatasource();

    return posts;
  }
}