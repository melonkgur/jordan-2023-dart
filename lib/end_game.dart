import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/data.dart';

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
      appBar: AppBar(
        title: const Text("End of Match"),
        backgroundColor: const Color(0xFF12131e),
      ),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            const Text("Notes", textScaleFactor: 1.25,),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
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
                        border: OutlineInputBorder()
                      ),
                      controller: _notesController,
                      onChanged: updateNotes,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      minLines: 1,
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF3750a8)),

              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => !Navigator.of(context).canPop());
              },
              child: const Text("Submit", style: TextStyle(color: Colors.white), textScaleFactor: 1.5)
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          ],
        ),
      ),
    );
  }
}
