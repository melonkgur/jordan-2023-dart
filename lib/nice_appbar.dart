import 'package:flutter/material.dart';

AppBar niceAppBarBuilder(BuildContext context, String title, IconButton? action, bool? useAppropiateArrow) {
  List<Widget> actions = List.empty(growable: true);
  if (action != null) {
    late IconButton what;

    //stupid final fields
    if (useAppropiateArrow != null && useAppropiateArrow) {
      if (Theme.of(context).platform == TargetPlatform.iOS || Theme.of(context).platform == TargetPlatform.macOS) {
        what = IconButton(onPressed: action.onPressed, icon: const Icon(Icons.arrow_forward_ios));
      } else {
        what = IconButton(onPressed: action.onPressed, icon: const Icon(Icons.arrow_forward));
      }
    } else  {
      what = action;
    }

    actions.add(what);
  }

  return AppBar(
    title: Text(title),
    actions: actions,
    centerTitle: true,
  );
}
