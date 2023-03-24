import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final Function(int) setVal;
  final int Function() getVal;
  const Counter({super.key, required this.setVal, required this.getVal});

  @override
  // bastard, bastard
  // ignore: no_logic_in_create_state
  State<Counter> createState() => _CounterState(getVal: getVal, setVal: setVal);
}

class _CounterState extends State<Counter> {
  final Function(int) setVal;
  final int Function() getVal;

  _CounterState({required this.getVal, required this.setVal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => setState(
            () {
              if (getVal() > 0) setVal(getVal() - 1);
            }
          ),

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFFE879F9))
          ),
          splashColor: const Color(0xFFE879F9),
          icon: const Icon(Icons.remove),
        ),

        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            color: const Color.fromRGBO(0, 0, 0, 1),
            boxShadow: List.of(const [BoxShadow(
              blurRadius: 10,
              spreadRadius: 10,
            )])
          ),
          child: Text(getVal().toString()),

        ),

        const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),

        IconButton(
          onPressed: () => setState(( () => setVal(getVal() + 1) )),

          splashColor: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

}
