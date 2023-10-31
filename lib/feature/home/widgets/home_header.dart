import 'package:flutter/material.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Sayed',
            style: getHeadlineStyle(),
          ),
          //
          Text(
            'Have A Nice Day.',
            style: getSmallTextStyle(),
          ),
        ],
      ),
      const Spacer(),
      CircleAvatar(
        radius: 26,
        backgroundColor: AppColors.primaryColor,
        child: const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQFDhvxrg5StnA/profile-displayphoto-shrink_800_800/0/1695348909031?e=2147483647&v=beta&t=8TBqalVNWxNEn4bAgjU4dY_JnHZJ6YGGM8aSzufrjCo')),
      )
    ]);
  }
}
