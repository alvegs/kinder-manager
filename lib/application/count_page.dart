import 'package:flutter/material.dart';
import 'package:kindermanager/application/show_count_page.dart';

import 'package:provider/provider.dart';

import '../model/section.dart';
import '../services/firebase_database.dart';

class CountPage extends StatefulWidget {
  final Section section;

  const CountPage({Key? key, required this.section}) : super(key: key);

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirebaseDatabase>(context, listen: false);
    return ShowCountPage(
        status: "ARRIVED", sectionId: widget.section.id, database: database);
  }
}
