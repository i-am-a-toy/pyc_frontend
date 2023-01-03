import 'package:flutter/material.dart';
import 'package:pyc/components/appbar/default_app_bar.dart';

class GroupUpsertScreen extends StatelessWidget {
  const GroupUpsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDefaultAppBar(
        title: '등록하기',
      ),
    );
  }
}
