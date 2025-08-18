// lib/pages/count.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountPage extends StatelessWidget {
  const CountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
        ),
        body: const Center(
          child: CounterDisplay(),
        ),
        floatingActionButton: const CounterButton(),
      ),
    );
  }
}

class CounterState extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterState>();
    return Text(
      'Count: ${counter.count}',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.read<CounterState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'decrement',
          onPressed: counter.decrement,
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'increment',
          onPressed: counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
