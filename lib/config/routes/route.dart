import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../features/posts/application/pages/post_page.dart';
import '../../features/posts/application/pages/post_details_page.dart';
import '../../core/injection_container/navigation_service.dart';
import 'router_constants.dart';

class AppRoutes {
  static String? _currentRoute;
  GoRouter router = GoRouter(
    navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
    initialLocation: _currentRoute ?? '/posts',
    routes: [
      // Posts routes
      GoRoute(
        name: RouteConstants.postsList,
        path: '/posts',
        pageBuilder: (context, state) {
          return MaterialPage(child: PostPage());
        },
      ),
      GoRoute(
        name: RouteConstants.postDetails,
        path: '/posts/:id',
        pageBuilder: (context, state) {
          final postId = int.parse(state.pathParameters['id']!);
          return MaterialPage(child: PostDetailsPage(postId: postId));
        },
      ),
    ],
    redirect: (context, state) async {
      _currentRoute = state.matchedLocation;
      return null; // No authentication required for now
    },
    errorBuilder: (context, state) {
      print('GoRouter Error: ${state.error}');
      return Scaffold(
        body: Center(child: Text('Error: ${state.error}')),
      );
    },
  );
}
