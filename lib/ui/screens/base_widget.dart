import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T model;
  final Widget? child;
  final Function(T) onModelReady;
  final bool create;

  const BaseWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    required this.onModelReady,
    this.create = true,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.create
        ? ChangeNotifierProvider<T>(
            create: (context) => model,
            child: Consumer<T>(
              builder: widget.builder,
              child: widget.child,
            ),
          )
        : ChangeNotifierProvider<T>.value(
            value: model,
            child: Consumer<T>(
              builder: widget.builder,
              child: widget.child,
            ),
          );
  }
}
