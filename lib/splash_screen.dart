import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/post/bloc/post_bloc.dart';
import 'features/post/bloc/post_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          } else if (state is PostsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
