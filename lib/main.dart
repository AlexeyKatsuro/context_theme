import 'package:attr_theme/theme/color_theme.dart';
import 'package:attr_theme/theme/inverse_surface_theme.dart';
import 'package:attr_theme/theme/surface_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: (context, child) {
        final theme = Theme.of(context);
        return MaterialColorTheme(
          primary: theme.colorScheme.primary,
          background: theme.colorScheme.background,
          foreground: theme.colorScheme.onBackground,
          child: child!,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget result = Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: SurfaceTheme.of(context).background(context),
      body: Center(
        child: Column(
          children: [
            const Expanded(child: Block()),
            Expanded(
              child: SurfaceTheme(
                child: Column(
                  children: const [
                    Block(),
                    InverseSurfaceTheme(
                      child: Block(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return result;
  }
}

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SurfaceTheme.of(context);
    return Container(
      width: 100,
      height: 100,
      color: theme.background(context),
      child: Text(
        'Child',
        style: TextStyle(color: theme.foreground(context)),
      ),
    );
  }
}
