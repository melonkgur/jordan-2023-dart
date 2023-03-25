import 'package:flutter/material.dart';
import 'package:implosion/data_archive.dart';
import 'package:implosion/nice_appbar.dart';

class Archives extends StatefulWidget {
  const Archives({super.key});

  @override
  State<Archives> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archives> {
  late List<Widget> listItems;

  @override
  void initState() {
    super.initState();
    listItems = DataArchive.getArchiveListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: niceAppBarBuilder(context, "Archives", null, null),
      backgroundColor: const Color(0xFF12131e),
      body: Column (
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(itemBuilder: (context, index) => listItems[index], separatorBuilder:(context, index) => const Divider(height: 1, thickness: 4), itemCount: listItems.length, shrinkWrap: true,)
        ],
      )
    );
  }

}
