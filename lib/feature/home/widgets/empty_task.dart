import 'package:flutter/material.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty.png'),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Tasks not found, add task',
            style: Theme.of(context).textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}
