import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  final String? name;
  final String? imageUrl;
  const StoryScreen({
    Key? key,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  double _width = 200;
  double _height = 200;

  _updateState() {
    setState(() {
      _width = 400;
      _height = 400;
    });
  }

  @override
  void didChangeDependencies() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () => _updateState(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const BackButton(),
                Text(
                  'Story',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: _width,
              height: _height,
              child: Image.network(
                widget.imageUrl!,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
