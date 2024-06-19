// import 'package:dev_nc/model.dart';
// import 'package:flutter/material.dart';

// import 'features/post/data/post_service.dart';


// class NewsListUI extends StatefulWidget {
//   @override
//   _NewsListUIState createState() => _NewsListUIState();
// }

// class _NewsListUIState extends State<NewsListUI> {
//   Future<List<News>>? _news;

//   @override
//   void initState() {
//     super.initState();
//     _news = NewsApiService().fetchNews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News'),
//       ),
//       body: FutureBuilder<List<News>>(
//         future: _news,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final news = snapshot.data!;
//           return ListView.builder(
//             itemCount: news.length,
//             itemBuilder: (context, index) {

//               return Container();

//             }
//           ),
//           ),
//       );
