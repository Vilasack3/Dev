import 'package:dev_nc/features/post/data/post_service.dart';

import '../features/post/bloc/post_bloc.dart';

class BlocProviders {
  static PostsBloc postsBloc =
      PostsBloc(RealApiClient()); // Use RealApiClient for production
}
