import 'package:flutter/material.dart';

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder(
      {super.key, required this.builder, required this.defaultBrightness});
  final Brightness defaultBrightness;

  final Widget Function(BuildContext context, Brightness brightness) builder;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
  static _ThemeBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeBuilderState>();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness _brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    _brightness = widget.defaultBrightness;

    if (mounted) {
      setState(() {});
    }
  }

  void changeTheme() {
    setState(() {
      _brightness =
          _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    });
  }

  Brightness getCurrentTheme() {
    return _brightness;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness);
  }
}
