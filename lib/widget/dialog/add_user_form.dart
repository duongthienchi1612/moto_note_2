import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import '../base/base_widget.dart';
import '../custom_text_field.dart';

class AddUserForm extends StatefulWidget {
  final String? userName;
  final bool? isAddNew;
  const AddUserForm({super.key, required this.userName, this.isAddNew = false});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends BaseState<AddUserForm> {


  late String _userName;

  @override
  void initState() {
    _userName = widget.userName ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.addUserNameFormTitle,
                  style: theme.textTheme.headlineMedium,
                ),
                Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 8),
            CustomTextField(
              data: _userName,
              onChange: (value) {
                if (StringUtils.isNullOrEmpty(value)) return;
                _userName = value;
              },
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context, _userName);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(widget.isAddNew! ? localizations.add : localizations.save, style: theme.textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}