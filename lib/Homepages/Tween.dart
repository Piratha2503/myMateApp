import 'package:flutter/material.dart';

class MyTween extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrolling Image Animation',
      home: ScrollingImageAnimationDemo(),
    );
  }
}

class ScrollingImageAnimationDemo extends StatefulWidget {
  @override
  _ScrollingImageAnimationDemoState createState() =>
      _ScrollingImageAnimationDemoState();
}

class _ScrollingImageAnimationDemoState
    extends State<ScrollingImageAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  double imageSize = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double maxImageSize = 200.0;
    double minImageSize = 50.0;
    double newSize = maxImageSize - (offset * 0.5);

    setState(() {
      imageSize = newSize.clamp(minImageSize, maxImageSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrolling Image Animation'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 10, // Number of items in the list
        itemBuilder: (context, index) {
          if (index == 4) {
            // Apply the scrolling animation to the 5th item (index 4)
            return Stack(
              children: [
                Container(
                  height: 300.0, // Adjust as needed
                  color: Colors.grey[200],
                ),
                Positioned(
                  top: 150.0, // Adjust as needed
                  left: _animation.value * MediaQuery.of(context).size.width,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: imageSize,
                    height: imageSize,
                    child: Image.network(
                      'https://via.placeholder.com/200', // Example image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Other items in the list remain unaffected
            return ListTile(title: Text('Item $index'));
          }
        },
      ),
    );
  }
}
