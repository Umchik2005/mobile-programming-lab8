import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';

class ThemeScreen extends StatefulWidget {
  // The parent may rebuild the app; this screen only updates SharedPreferences
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isDark = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final val = await SharedPrefsService.getDarkMode();
    setState(() {
      _isDark = val;
      _loading = false;
    });
  }

  Future<void> _toggle(bool v) async {
    setState(() => _loading = true);
    await SharedPrefsService.setDarkMode(v);
    setState(() {
      _isDark = v;
      _loading = false;
    });
    // Optionally show a message
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Theme preference saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Toggle')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Dark mode', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Switch(value: _isDark, onChanged: _toggle),
                ],
              ),
      ),
    );
  }
}
