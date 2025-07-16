import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postscleanarchitecture/features/posts/data/models/post_model.dart';
import 'package:postscleanarchitecture/features/posts/domain/usecases/posts_usecase.dart';

import 'i_posts_repo.mock.dart';



void main() {
  late PostsUseCase usecase;
  late MockIPostsRepo mockRepo;

  setUp(() {
    mockRepo = MockIPostsRepo();
    usecase = PostsUseCase(postsRepo: mockRepo);
  });

  final tPosts = [
    PostModel(
      userId: 1,
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
    ),
  ];
  test('should call getPostsFromDatasource and return list of PostEntity', () async {
    // Arrange
    when(() => mockRepo.getPostsFromDatasource())
        .thenAnswer((_) async => Right(tPosts));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right(tPosts)));
    verify(() => mockRepo.getPostsFromDatasource()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
