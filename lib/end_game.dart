import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/data.dart';
import 'package:implosion/nice_appbar.dart';

class EndOfMatch extends StatefulWidget {
  const EndOfMatch({super.key});

  @override
  State<EndOfMatch> createState() => _EndOfMatchState();
}

class _EndOfMatchState extends State<EndOfMatch> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _notesController.text = DataRecord.notes;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void updateNotes(String s) {
    DataRecord.notes = s.trim();
    if (kDebugMode) print(DataRecord.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("End of Match"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         showDialog(context: context, builder:(context) => AlertDialog(
      //           title: const Text("Save?"),
      //           content: const Text("This will archive all of your data."),
      //           actions: <Widget>[
      //             TextButton(
      //               onPressed: () => Navigator.of(context).pop(),
      //               child: const Text("Cancel")
      //             ),
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.of(context).popUntil((route) => !Navigator.of(context).canPop());
      //               },
      //               child: const Text("Save")
      //             ),
      //           ],
      //         ));
      //       },
      //       icon: const Icon(Icons.save)
      //     )
      //   ],
      // ),
      appBar: niceAppBarBuilder(
        context,
        "Endgame",
        IconButton(
          onPressed: () {
            showDialog(context: context, builder:(context) => AlertDialog(
              title: const Text("Save?"),
              content: const Text("This will archive all of your data."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel")
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => !Navigator.of(context).canPop());
                  },
                  child: const Text("Save")
                ),
              ],
            ));
          },
          icon: const Icon(Icons.save)
        ),
        false
      ),
      backgroundColor: const Color(0xFF12131e),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded( flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20))
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 20))
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Other Notes..."
                      ),
                      controller: _notesController,
                      onChanged: updateNotes,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 4,
                      onSubmitted: updateNotes,
                    )
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 20))
                  ),
                ],
              )
            ),
            const Expanded( flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20))
            ),
          ],
        ),
      ),
    );
  }
}
