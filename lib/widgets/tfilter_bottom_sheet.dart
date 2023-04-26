import 'package:flutter/material.dart';

enum TodoFilter { all, completed, incompleted }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet(
      {Key? key, required this.filter, required this.onApply})
      : super(key: key);
  final TodoFilter filter;
  final Function(TodoFilter) onApply;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  onApply(TodoFilter filter) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filter applied: $filter'),
      ),
    );
    widget.onApply(filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('All'),
            trailing: Checkbox(
              value: widget.filter == TodoFilter.all,
              onChanged: (value) {
                if (value == true) onApply(TodoFilter.all);
              },
            ),
          ),
          ListTile(
            title: const Text('Completed'),
            trailing: Checkbox(
              value: widget.filter == TodoFilter.completed,
              onChanged: (value) {
                if (value == true) onApply(TodoFilter.completed);
              },
            ),
          ),
          ListTile(
            title: const Text('InCompleted'),
            trailing: Checkbox(
              value: widget.filter == TodoFilter.incompleted,
              onChanged: (value) {
                if (value == true) onApply(TodoFilter.incompleted);
              },
            ),
          ),
        ],
      ),
    );
  }
}
