import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postscleanarchitecture/features/posts/application/postbloc/posts_bloc.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/theme_service.dart';

class PostDetailsPage extends StatefulWidget {
  final int postId;
  
  const PostDetailsPage({super.key, required this.postId});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Load posts if not already loaded
    BlocProvider.of<PostsBloc>(context).add(PostsEvent.getPosts());
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Details",
          style: themedata.textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/posts'),
        ),
        actions: [
          Switch(
            activeColor: Colors.green,
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
            value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
            inactiveTrackColor: Colors.blueGrey,
            inactiveThumbColor: Colors.black87,
            onChanged: (_) {
              Provider.of<ThemeServiceProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          } else if (state.isSuccess) {
            final post = state.posts.firstWhere(
              (post) => post.id == widget.postId,
              orElse: () => throw Exception('Post not found'),
            );
            
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Post #${post.id}",
                    style: themedata.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: themedata.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post.body,
                            style: themedata.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/posts'),
                    child: Text('Back to Posts'),
                  ),
                ],
              ),
            );
          }
          
          return Center(
            child: Text("Post not found"),
          );
        },
      ),
    );
  }
}
