import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1618005198919-d3d4b5a92ead?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: ParallaxBox(
              backgroundImage:
                  'https://img.freepik.com/free-photo/view-landscape-monochrome-palette_23-2150635159.jpg',
              child: SizedBox(
                height: 200.0, // Height of the parallax effect box
                child: Center(
                  child: Text(
                    'Parallax Content',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item ${index + 1}'),
                ),
                childCount: 2,
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.amberAccent : Colors.blueAccent,
                  child: Center(
                    child: Text('Grid Item #$index'),
                  ),
                );
              },
              childCount: 2,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
          ),
          // SliverFillViewport(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: NetworkImage(""),
          //           ),
          //         ),
          //         color: index.isOdd ? Colors.green : Colors.pink,
          //         child: Center(
          //           child: Text('Page $index'),
          //         ),
          //       );
          //     },
          //     childCount: 3,
          //   ),
          // )
        ],
      ),
    );
  }
}

class ParallaxBox extends SingleChildRenderObjectWidget {
  final String backgroundImage;

  const ParallaxBox({
    super.key,
    required this.backgroundImage,
    required Widget child,
  }) : super(child: child);

  @override
  RenderParallaxBox createRenderObject(BuildContext context) {
    return RenderParallaxBox(backgroundImage: backgroundImage);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderParallaxBox renderObject) {
    renderObject.backgroundImage = backgroundImage;
  }
}

class RenderParallaxBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  String _backgroundImage;
  double _scrollOffset = 0.0;

  RenderParallaxBox({required String backgroundImage})
      : _backgroundImage = backgroundImage;

  String get backgroundImage => _backgroundImage;

  set backgroundImage(String value) {
    if (_backgroundImage != value) {
      _backgroundImage = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child!.size);
    } else {
      size = constraints.smallest;
    }
  }

  void updateScrollOffset(double scrollOffset) {
    if (_scrollOffset != scrollOffset) {
      _scrollOffset = scrollOffset;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final double parallax = _scrollOffset * 0.5;
      final Offset backgroundOffset = Offset(0.0, -parallax);

      final Paint paint = Paint();
      final ImageStream imageStream =
          NetworkImage(_backgroundImage).resolve(const ImageConfiguration());

      imageStream.addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
          context.canvas.drawImageRect(
            info.image,
            Rect.fromLTWH(0.0, 0.0, info.image.width.toDouble(),
                info.image.height.toDouble()),
            Rect.fromLTWH(offset.dx, offset.dy + backgroundOffset.dy,
                size.width, size.height),
            paint,
          );
        }),
      );

      context.paintChild(child!, offset);
    }
  }
}
