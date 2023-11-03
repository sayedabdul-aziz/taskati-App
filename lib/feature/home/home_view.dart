import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/feature/add_task/add_task_view.dart';
import 'package:taskati/feature/home/widgets/home_header.dart';
import 'package:taskati/feature/home/widgets/task_item.dart';

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
                Row(children: [
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTaskView(),
                      ));
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor),
                      child: Text(
                        '+ add Task',
                        style: getSmallTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
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
                    List<int> indexs = [];
                    int index = 0;
                    List<Task> tasks = value.values.where((element) {
                      index++;
                      if (element.date.split('T').first ==
                          _selectedValue!.toIso8601String().split('T').first) {
                        indexs.add(index);
                        return true;
                      } else {
                        return true;
                      }
                    }).toList();

                    if (tasks.isEmpty) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/empty.png'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Tasks not found, add task')
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            Task item = tasks[index];
                            return Dismissible(
                              key: UniqueKey(),
                              secondaryBackground: Container(
                                color: AppColors.redColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.delete_forever_rounded,
                                        color: AppColors.lightBg,
                                      ),
                                      Text(
                                        'Delete Task',
                                        style: getSmallTextStyle(
                                            color: AppColors.lightBg),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              background: Container(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check,
                                          color: AppColors.lightBg),
                                      Text(
                                        'Complete Task',
                                        style: getSmallTextStyle(
                                            color: AppColors.lightBg),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  setState(() {
                                    value.putAt(
                                        indexs[index],
                                        Task(
                                            title: item.title,
                                            note: item.note,
                                            date: item.date,
                                            startTime: item.startTime,
                                            endTime: item.endTime,
                                            color: 3,
                                            isComplete: true));
                                  });
                                } else {
                                  setState(() {
                                    value.deleteAt(indexs[index]);
                                  });
                                }
                              },
                              child: TaskItem(
                                task: item,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ]))),
    );
  }
}
