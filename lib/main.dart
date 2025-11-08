import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/username_screen.dart';
import 'screens/counter_screen.dart';
import 'screens/theme_screen.dart';
import 'services/shared_prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load theme preference before running app so initial theme is correct
  final isDark = await SharedPrefsService.getDarkMode();
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  const MyApp({Key? key, required this.isDark}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
  }

  // Allow child screens to trigger a theme refresh by calling this method
  void refreshTheme() async {
    final val = await SharedPrefsService.getDarkMode();
    setState(() => _isDark = val);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Programming Lab 8',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(),
      routes: {
        '/username': (_) => const UsernameScreen(),
        '/counter': (_) => const CounterScreen(),
        '/theme': (_) => const ThemeScreen(),
      },
    );
  }
}
