import 'package:flutter/material.dart';

class ScrollableButtonScreen extends StatefulWidget {
  const ScrollableButtonScreen({super.key});

  @override
  State<ScrollableButtonScreen> createState() => _ScrollableButtonScreenState();
}

class _ScrollableButtonScreenState extends State<ScrollableButtonScreen> {
  final ScrollController _scrollController = ScrollController();
  String _currentContent = 'Select an option to see content below';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          _currentContent = "Scrolled Down";
        });
      } else {
        setState(() {
          _currentContent = 'Select an option to see content below';
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _changeContent(String content) {
    setState(() {
      _currentContent = content;
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Social content Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          controller: _scrollController,
          children: [
            ElevatedButton(
              onPressed: () => _changeContent("Keyword Detection Page Content"),
              child: const Text('Keyword Detection'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _changeContent("Activity Page Content"),
              child: const Text('Activity'),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                _currentContent,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
