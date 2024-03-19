import 'package:flutter/material.dart';

class EmptyListWidget extends StatefulWidget {
  const EmptyListWidget({
    super.key, required this.refreshList,
  });

  final VoidCallback refreshList;

  @override
  State<EmptyListWidget> createState() => _EmptyListWidgetState();
}

class _EmptyListWidgetState extends State<EmptyListWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No Items'),
          IconButton(onPressed: widget.refreshList, icon: const Icon(Icons.refresh),),
        ],
      ),
    );
  }
}
