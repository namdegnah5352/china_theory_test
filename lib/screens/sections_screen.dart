import 'package:flutter/material.dart';
import '../config/navigation/global_nav.dart';
import '../domain/entities/section.dart';
import '../calls/app_calls.dart';
import 'app_drawer.dart';
import '../calls/app_calls.dart';
import '../domain/entities/sub_section.dart';

GlobalNav globalNav = GlobalNav.instance;

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  List<Section> sections = globalNav.sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sections'),
        actions: [
          IconButton.filled(
            onPressed: () async {
              await loadTestStart(globalNav.questions!);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ...sections.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () async {
                      await loadSubSection(section.subsections, section);
                    },
                    child: Text(section.value),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
