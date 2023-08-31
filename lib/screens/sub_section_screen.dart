import 'package:flutter/material.dart';
import '../domain/entities/sub_section.dart';
import '../domain/entities/section.dart';
import '../calls/app_calls.dart';
import '../widgets/change_status_dialog.dart';

class SubSectionScreen extends StatefulWidget {
  const SubSectionScreen(this.subsections, this.section, {super.key});
  final List<SubSection> subsections;
  final Section section;
  @override
  State<SubSectionScreen> createState() => _SubSectionScreenState();
}

class _SubSectionScreenState extends State<SubSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subsections'),
        actions: [
          IconButton.filled(
            onPressed: () async {
              await loadTestStart(widget.section.questions);
            },
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primaryContainer),
          ),
          ChangeStatusDialog(widget.section.questions),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ...widget.subsections.map((subSection) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () async => await loadSubSectionQuestions(subSection.questions),
                      child: Text(subSection.value),
                    ),
                    const SizedBox(height: 5),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
