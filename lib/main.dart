import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/autonomous.dart';
import 'package:implosion/charge_station_state.dart';
import 'package:implosion/data.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jordan - Charged Up',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF3750a8),
          background: Color(0xFF12131e),
          brightness: Brightness.dark,
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFE879F9),
          onSecondary: Color(0xFFFFFFFF),
          error: Color.fromARGB(255, 207, 39, 114),
          onError: Color(0xFFFFFFFF),
          onBackground: Color.fromARGB(255, 96, 112, 167),
          surface: Color(0xFF1c1f31),
          onSurface: Colors.white
        )
      ),
      home: const MainPage(title: 'MainPage'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});


  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _scouterController;
  late TextEditingController _teamController;
  late TextEditingController _matchController;
  late ChargeStationStatus autoDropdown;

  //the silly
  @override
  void initState() {
    super.initState();
    _scouterController = TextEditingController();
    _teamController = TextEditingController();
    _matchController = TextEditingController();

    _scouterController.text = DataRecord.scouter;
    _teamController.text = DataRecord.teamNumber.toString();
    _matchController.text = DataRecord.matchNumber.toString();
    autoDropdown = DataRecord.auto;
  }


  void updateScouter(String s) {
    DataRecord.scouter = s.trim();
    if (kDebugMode) print(DataRecord.scouter);

  }

  void updateTeam(String s) {
    int? num = int.tryParse(s.trim());
    if (num != null) {
      DataRecord.teamNumber = num;
    } else {
      DataRecord.teamNumber = 0;
      _teamController.text = "";
    }
    if (kDebugMode) print(DataRecord.teamNumber);
  }

  void updateMatch(String s) {
    int? num = int.tryParse(s);
    if (num != null) {
      DataRecord.matchNumber = num;
    } else {
      DataRecord.matchNumber = 0;
      _matchController.text = "";
    }
    if (kDebugMode) print(DataRecord.matchNumber);
  }

  @override
  void dispose() {
    _scouterController.dispose();
    _teamController.dispose();
    _matchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // archive icon is called archive. add that later. or something. w riss
    return Scaffold(
      appBar: AppBar(title: const Text("Start Of Match")),
      backgroundColor: const Color(0xFF12131e),
      body: Center(
        child: SafeArea(
          left: true,
          right: true,
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Scouter Name", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true

                          ),
                          controller: _scouterController,
                          onChanged: updateScouter,
                          onSubmitted: updateScouter,
                        ),
                      ],
                    )
                  ),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Team Number", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true
                          ),
                          controller: _teamController,
                          onChanged: updateTeam,
                          onSubmitted: updateTeam,
                        ),
                      ],
                    ),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Match Number", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true
                          ),
                          controller: _matchController,
                          onChanged: updateMatch,
                          onSubmitted: updateMatch,
                        ),
                      ],
                    ),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Charge Station", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0)),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(value: ChargeStationStatus.notOn, child: Text("None"),),
                            DropdownMenuItem(value: ChargeStationStatus.taxi, child: Text("Taxi"),),
                            DropdownMenuItem(value: ChargeStationStatus.dockedNotEngaged, child: Text("Docked"),),
                            DropdownMenuItem(value: ChargeStationStatus.dockedAndEngaged, child: Text("Docked & Engaged"),),
                          ],
                          value: autoDropdown,
                          isDense: true,
                          onChanged:(value) {
                            setState(() {
                              autoDropdown = value!;
                              DataRecord.auto = value;
                              if (kDebugMode) print(DataRecord.auto.toJsonStr());
                            });
                          }
                        )
                      ],
                    ),
                  ),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                ]
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF3750a8)), //????
                ),
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Autonomous())
                  );
                },
                child: const Text("Autonomous", style: TextStyle(color: Colors.white), textScaleFactor: 1.25,)
              ),
            ]
          )
        )
      ),
    );
  }
}
