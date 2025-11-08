import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _savedUsername;
  int _counter = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    setState(() => _isLoading = true);
    try {
      final username = await SharedPrefsService.getUsername();
      final counter = await SharedPrefsService.getCounter();
      setState(() {
        _savedUsername = username;
        _counter = counter;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Called when returning from other screens to refresh displayed values.
  Future<void> _navigateAndRefresh(Widget page) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    await _loadSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Part A — SharedPreferences')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Saved username:', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Text(_savedUsername ?? '(none)', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Counter', style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              Text('$_counter', style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => _navigateAndRefresh(// lazy import to keep route simple
                                // We will import screens where needed when creating files
                                ),
                            child: const Text('Open Counter'),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _navigateAndRefresh(const Placeholder()),
                    child: const Text('Username Screen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _navigateAndRefresh(const Placeholder()),
                    child: const Text('Counter Screen'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _navigateAndRefresh(const Placeholder()),
                    child: const Text('Theme Toggle'),
                  ),
                ],
              ),
            ),
    );
  }
}
