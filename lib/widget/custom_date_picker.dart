import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.context,
    required this.label,
    required this.date,
    required this.onChanged,
  });

  final BuildContext context;
  final String label;
  final DateTime? date;
  final Function(DateTime? p1) onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.titleLarge),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: OutlinedButton.icon(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - Constants.rangeOfYear),
                lastDate: DateTime.now(),
              );
              onChanged(pickedDate);
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
            icon: const Icon(Icons.calendar_month),
            label: Center(
              child: Text(
                date != null ? DateFormat('dd-MM-yyyy').format(date!) : '',
                style: textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
