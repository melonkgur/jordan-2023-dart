import 'package:flutter/material.dart';
import 'package:implosion/data_archive.dart';
import 'package:implosion/nice_appbar.dart';

class Archives extends StatefulWidget {
  const Archives({super.key});

  @override
  State<Archives> createState() => ArchiveState();
}

class ArchiveState extends State<Archives> {
  late List<Widget> listItems;

  static ArchiveState? instance;

  ArchiveState() {
    instance = this;
  }

  @override
  void initState() {
    super.initState();
    listItems = DataArchive.getArchiveListWidget();
  }

  void clear() {
    setState(() => listItems.clear());
  }

  void reloadList() {
    setState(() {
      listItems = DataArchive.getArchiveListWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: niceAppBarBuilder(
        context, "Archives",
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Clear?"),
                content: const Text("This will delete all of your data."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel")
                  ),
                  TextButton(
                    onPressed: () {
                      DataArchive.clearStorage();
                      Navigator.of(context).pop();
                      ArchiveState.instance!.clear();
                    },
                    child: const Text("Clear", style: TextStyle(color: Colors.red))
                  )
                ],
              )
            );
          },
          icon: const Icon(Icons.delete_forever)
        ),
        false
      ),
      backgroundColor: const Color(0xFF12131e),
      body: Column (
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height-56.0, // 56 is height of top bar. among us
            child: ListView.separated(
              itemBuilder: (context, index) => listItems[index],
              separatorBuilder:(context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Divider(height: 0.1, thickness: 0.75),
                ]
              ),
              itemCount: listItems.length,
            )
          )
        ],
      )
    );
  }

}
