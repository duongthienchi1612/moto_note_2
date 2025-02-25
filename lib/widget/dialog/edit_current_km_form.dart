import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../base/base_widget.dart';
import '../custom_text_field.dart';

class EditCurrentKmForm extends StatefulWidget {
  final int currentKm;

  const EditCurrentKmForm({
    super.key,
    required this.currentKm,
  });
  
  @override
  State<EditCurrentKmForm> createState() => _EditCurrentKmFormState();
}

class _EditCurrentKmFormState extends BaseState<EditCurrentKmForm> {

  late int _currentKm;

  @override
  void initState() {
    super.initState();
    _currentKm = widget.currentKm;
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
                  localizations.setCurrentKmFormTitle,
                  style: theme.textTheme.headlineMedium,
                ),
                Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 8),
            CustomTextField(
              data: widget.currentKm.toString(),
              textInputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChange: (value) {
                if (StringUtils.isNullOrEmpty(value)) return;
                _currentKm = int.tryParse(value)!;
              },
              maxLength: 5,
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context, _currentKm);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(localizations.save, style: theme.textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
