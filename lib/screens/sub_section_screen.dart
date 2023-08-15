import 'package:flutter/material.dart';
import '../domain/entities/sub_section.dart';
import '../calls/app_calls.dart';

class SubSectionScreen extends StatefulWidget {
  const SubSectionScreen(this.subsections, {super.key});
  final List<SubSection> subsections;

  @override
  State<SubSectionScreen> createState() => _SubSectionScreenState();
}

class _SubSectionScreenState extends State<SubSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subsection')),
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
