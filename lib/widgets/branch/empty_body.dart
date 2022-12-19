import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets_paths.dart';

class EmptyBody extends StatelessWidget {
  const EmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SvgPicture.asset(AssetsPaths.todoListBackground),
              SvgPicture.asset(AssetsPaths.todoList),
            ],
          ),
          const Text(
            'На данный момент задачи отсутствуют',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
