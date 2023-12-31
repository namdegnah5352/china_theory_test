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
  late _temp from;
  late _temp to;

  @override
  void initState() {
    from = _temp(value: AppConstants.notLearnt);
    to = _temp(value: AppConstants.notLearnt);
    super.initState();
  }

  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Question Status'),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(child: Text('From')),
                  getStatusDropdown(from),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Text('To')),
                  getStatusDropdown(to),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Okay'),
              onPressed: () {
                widget.questions.changeStatus(from.value, to.value);
                Navigator.of(context).pop();
              }),
          FilledButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget getStatusDropdown(_temp valueToSet) {
    return LimitedBox(
      maxWidth: 120,
      maxHeight: 56,
      child: DropdownButtonFormField<String>(
        value: valueToSet.value,
        style: skillsBody,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(),
        ),
        items: quantities,
        menuMaxHeight: 300,
        onChanged: (value) {
          valueToSet.value = value!;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => openDialog(context),
      icon: Icon(Icons.sledding, color: Theme.of(context).colorScheme.primaryContainer),
    );
  }
}

class _temp {
  String value;
  _temp({required this.value});
}
