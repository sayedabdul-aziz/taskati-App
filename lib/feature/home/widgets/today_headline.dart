import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/feature/add_task/add_task_view.dart';

class TodayHeadlineWidget extends StatelessWidget {
  const TodayHeadlineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.MMMMEEEEd().format(DateTime.now()),
              style: getTitleStyle()),
          //
          Text(
            'Today',
            style: getTitleStyle(),
          ),
        ],
      ),
      const Spacer(),
      CustomButton(
        text: '+ add Task',
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTaskView(),
          ));
        },
      )
    ]);
  }
}
