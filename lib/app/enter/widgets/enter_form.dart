import 'package:flutter/material.dart';

class EnterForm extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const EnterForm(
    this.context, {
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: child,
          ),
        );
      },
    );
  }
}
