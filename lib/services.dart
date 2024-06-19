import 'package:dev_nc/model.dart';

class FakeApiService {
  static Future<List<Post>> fetchPosts() async {
    // Simulate API call delay
    await Future.delayed(Duration(seconds: 1));

    // Generate fake data
    return List.generate(
      10,
      (index) => Post(
        id: index + 1,
        title: 'Post ${index + 1}',
        body: 'This is the body of post ${index + 1}',
      ),
    );
  }
}
