import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/feature/home/widgets/empty_task.dart';
import 'package:taskati/feature/home/widgets/home_header.dart';
import 'package:taskati/feature/home/widgets/tasks_list.dart';
import 'package:taskati/feature/home/widgets/today_headline.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime? _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const HomeHeader(),
                const SizedBox(
                  height: 15,
                ),
                const TodayHeadlineWidget(),
                const SizedBox(
                  height: 20,
                ),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: _selectedValue,
                  selectionColor: AppColors.primaryColor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: const TextStyle()
                      .copyWith(color: Theme.of(context).primaryColor),
                  monthTextStyle: const TextStyle()
                      .copyWith(color: Theme.of(context).primaryColor),
                  dayTextStyle: const TextStyle()
                      .copyWith(color: Theme.of(context).primaryColor),
                  onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                      print(_selectedValue!.toIso8601String());
                    });
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: Hive.box<Task>('task').listenable(),
                  builder:
                      (BuildContext context, Box<Task> value, Widget? child) {
                    List<Task> tasks = value.values.where((element) {
                      if (element.date.split('T').first ==
                          _selectedValue!.toIso8601String().split('T').first) {
                        return true;
                      } else {
                        return false;
                      }
                    }).toList();

                    if (tasks.isEmpty) {
                      return const EmptyTaskWidget();
                    } else {
                      return TaskListWidget(tasks: tasks, value: value);
                    }
                  },
                )
              ]))),
    );
  }
}
