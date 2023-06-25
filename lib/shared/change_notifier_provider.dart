import 'package:flutter/material.dart';

class ChangeNotifierProvider<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  const ChangeNotifierProvider({
    Key? key,
    required T notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static T? maybeOf<T extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
        ?.notifier;
  }

  static T of<T extends ChangeNotifier>(BuildContext context) {
    final notifier = maybeOf<T>(context);
    assert(notifier != null, 'No ChangeNotifierProvider found');
    return notifier!;
  }

  @override
  bool updateShouldNotify(ChangeNotifierProvider<T> oldWidget) {
    return oldWidget.notifier != notifier;
  }

  ChangeNotifierProvider<T> copyWith({Widget? child}) {
    return ChangeNotifierProvider<T>(
      key: key,
      notifier: notifier as T,
      child: child ?? this.child,
    );
  }
}

// change notifier builder
class NotifierBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const NotifierBuilder({
    Key? key,
    required this.builder,
    this.child,
    required this.notifier,
  }) : super(key: key);

  final ValueWidgetBuilder<T> builder;
  final Widget? child;
  final T notifier;

  @override
  _ChangeNotifierBuilderState<T> createState() =>
      _ChangeNotifierBuilderState<T>();
}

class _ChangeNotifierBuilderState<T extends ChangeNotifier>
    extends State<NotifierBuilder<T>> {
  late T notifier;

  @override
  void initState() {
    super.initState();
    notifier = widget.notifier;
    notifier.addListener(update);
  }

  @override
  void didUpdateWidget(NotifierBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.notifier != oldWidget.notifier) {
      oldWidget.notifier.removeListener(update);
      notifier = widget.notifier;
      notifier.addListener(update);
    }
  }

  @override
  void dispose() {
    notifier.removeListener(update);
    super.dispose();
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, notifier, widget.child);
  }
}
