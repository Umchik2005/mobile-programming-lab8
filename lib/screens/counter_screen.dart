import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    setState(() => _loading = true);
    final val = await SharedPrefsService.getCounter();
    setState(() {
      _counter = val;
      _loading = false;
    });
  }

  Future<void> _setCounter(int newVal) async {
    setState(() => _loading = true);
    await SharedPrefsService.setCounter(newVal);
    setState(() {
      _counter = newVal;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persistent Counter')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$_counter', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () => _setCounter(_counter - 1), child: const Text('-')),
                      const SizedBox(width: 12),
                      ElevatedButton(onPressed: () => _setCounter(_counter + 1), child: const Text('+')),
                      const SizedBox(width: 12),
                      ElevatedButton(onPressed: () => _setCounter(0), child: const Text('Reset')),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
