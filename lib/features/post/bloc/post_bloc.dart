import 'package:bloc/bloc.dart';
import 'package:dev_nc/features/post/bloc/post_state.dart';

import '../data/post_service.dart';
import 'post_event.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final RealApiClient apiClient;

  PostsBloc(this.apiClient) : super(PostsInitial());

  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event == PostsEvent.fetchPosts) {
      yield PostsLoading();
      try {
        final posts = await apiClient.getPosts();
        yield PostsLoaded(posts);
      } catch (error) {
        yield PostsError(error.toString());
      }
    }
  }
}
