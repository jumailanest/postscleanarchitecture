import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:postscleanarchitecture/features/posts/data/models/post_model.dart';
import 'package:postscleanarchitecture/features/posts/domain/entities/posts_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = PostModel(
    userId: 1,
    id: 101,
    title: 'Test Title',
    body: 'This is the body of the test post',
  );

  test('should be a subclass of PostEntity', () {
    expect(tModel, isA<PostEntity>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final jsonMap = jsonDecode(fixture('post.json')) as Map<String, dynamic>;
      // act
      final result = PostModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tModel));
    });
  });

  group('toJson', () {
    test('should return a valid JSON map from model', () {
      // act
      final result = tModel.toJson();
      // assert
      final expectedMap = {
        'userId': 1,
        'id': 101,
        'title': 'Test Title',
        'body': 'This is the body of the test post',
      };
      expect(result, equals(expectedMap));
    });
  });

  group('copyWith', () {
    test('should return a new model with updated field(s)', () {
      final updatedModel = tModel.copyWith(title: 'Updated Title');
      expect(updatedModel.title, equals('Updated Title'));
      expect(updatedModel.body, equals(tModel.body));
      expect(updatedModel, isNot(equals(tModel)));
    });
  });
}
