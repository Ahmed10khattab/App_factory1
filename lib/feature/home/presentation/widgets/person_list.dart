import 'package:appfactorytest/feature/home/presentation/screen/dummy_data/users_data.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/person_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: DummyData.posts.length,
                    itemBuilder: (context, index) {
                      return PersonHomeWidget(index: index);
                    },
                  ),
                );
  }
}