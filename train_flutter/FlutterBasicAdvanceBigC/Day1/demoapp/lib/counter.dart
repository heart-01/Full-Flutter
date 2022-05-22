import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cat.jpeg',
                width: 200,
              ),

              const Text(
                'กดปุ่มด้านล่างเพื่อเพิ่มจำนวน',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 100,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // ตำแหน่ง floatingButton
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _decrement();
              },
              tooltip: 'decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                _reset();
              },
              tooltip: 'reset',
              child: const Icon(Icons.restore),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                _increment();
              },
              tooltip: 'increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
