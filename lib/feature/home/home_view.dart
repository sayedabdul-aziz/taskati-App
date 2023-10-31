import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
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
                  initialSelectedDate: DateTime.now(),
                  selectionColor: AppColors.primaryColor,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    setState(() {
                      // _selectedValue = date;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const TaskItem();
                    },
                  ),
                )
              ]))),
    );
  }
}
