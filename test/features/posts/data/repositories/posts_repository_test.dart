import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postscleanarchitecture/core/error/exceptions.dart';
import 'package:postscleanarchitecture/core/error/main_failure.dart';
import 'package:postscleanarchitecture/features/posts/data/datsources/posts_remote_datasource.dart';
import 'package:postscleanarchitecture/features/posts/data/models/post_model.dart';
import 'package:postscleanarchitecture/features/posts/data/repositories/posts_repository.dart';


class MockRemoteDataSource extends Mock implements PostRemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late PostsRepository postsRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    postsRepository = PostsRepository(remoteDataSource: mockRemoteDataSource);
  });

  final tException = APIException(message: 'Server error', statusCode: 500);


  final tPosts = [
    PostModel(userId: 1, id: 1, title: 'Test Title', body: 'Test Body'),
  ];

  group('getPostsFromDatasource', () {
    test(
      'should call [PostRemoteDataSource.getPosts] and return [List<PostEntity>] when successful',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getPosts())
            .thenAnswer((_) async => Right(tPosts));

        // Act
        final result = await postsRepository.getPostsFromDatasource();

        // Assert
        expect(result, equals(Right(tPosts)));
        verify(() => mockRemoteDataSource.getPosts()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return [APIFailure] when [PostRemoteDataSource.getPosts] throws [APIException]',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getPosts()).thenThrow(tException);

        // Act
        final result = await postsRepository.getPostsFromDatasource();

        // Assert
        expect(result,
            equals(Left(MainFailure.serverFailure(message: tException.message))
            ));
        verify(() => mockRemoteDataSource.getPosts()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
