import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import '../dependencies.dart';
import '../preference/user_reference.dart';
import 'custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditCurrentKmForm extends StatefulWidget {
  final int currentKm;

  const EditCurrentKmForm({
    super.key,
    required this.currentKm,
  });
  
  @override
  State<EditCurrentKmForm> createState() => _EditCurrentKmFormState();
}

class _EditCurrentKmFormState extends State<EditCurrentKmForm> {

  late int _currentKm;

  @override
  void initState() {
    _currentKm = widget.currentKm;
    super.initState();
  }

  final userRef = injector.get<UserReference>();
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.setCurrentKmFormTitle,
              style: textTheme.headlineSmall,
            ),
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
            OutlinedButton(
              onPressed: () async {
                Navigator.pop(context, _currentKm);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                backgroundColor: Colors.blue,
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(localizations.save, style: textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
