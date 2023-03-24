import 'package:flutter/material.dart';
import 'package:implosion/nice_appbar.dart';

class Archives extends StatefulWidget {
  const Archives({super.key});

  @override
  State<Archives> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archives> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: niceAppBarBuilder(context, "Archives", null, null),
      backgroundColor: const Color(0xFF12131e),
      body: Column (
        mainAxisSize: MainAxisSize.min,
        children: [
          
        ],
      )
    );
  }

}
