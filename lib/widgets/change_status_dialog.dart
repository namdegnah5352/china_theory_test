import 'package:china_theory_test/config/constants.dart';
import 'package:flutter/material.dart';
import '../domain/entities/question.dart';
import '../config/text_styles.dart';
import '../config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

class ChangeStatusDialog extends StatefulWidget {
  const ChangeStatusDialog(this.questions, {super.key});
  final List<Question> questions;

  @override
  State<ChangeStatusDialog> createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<ChangeStatusDialog> {
  late String learntValue;

  @override
  void initState() {
    learntValue = AppConstants.notLearnt;
    super.initState();
  }

  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Question Status'),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: const Text('From'),
                  ),
                  Expanded(child: const Text('To')),
                ],
              ),
              const SizedBox(height: 10),
              Row(),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FilledButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget getStatusDropdown() {
    return LimitedBox(
      maxWidth: 90,
      maxHeight: 56,
      child: DropdownButtonFormField<String>(
        value: learntValue,
        style: skillsBody,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(),
        ),
        items: quantities,
        menuMaxHeight: 300,
        onChanged: (value) {
          learntValue = value!;
          //globalNav.notLearts.changeStatus(widget.question.id, learntValue);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => openDialog(context),
      icon: const Icon(Icons.sledding),
    );
  }
}
