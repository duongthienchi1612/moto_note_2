import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../bloc/add_device_bloc/add_device_bloc.dart';
import '../constants.dart';
import '../dependencies.dart';
import '../model/master_data/accessory_entity.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../theme/app_colors.dart';
import 'custom_date_picker.dart';
import 'custom_input_field.dart';
import 'custom_text_field.dart';
import 'input_device_name.dart';
import 'list_device_type.dart';

class AddDeviceForm extends StatefulWidget {
  const AddDeviceForm({super.key});

  @override
  State<AddDeviceForm> createState() => _AddDeviceFormState();
}

class _AddDeviceFormState extends State<AddDeviceForm> {
  final bloc = injector.get<AddDeviceBloc>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (context) => bloc..add(LoadData()),
        child: BlocBuilder<AddDeviceBloc, AddDeviceState>(
          builder: (context, state) {
            if (state is AddDeviceLoaded) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(child: Text(localizations.addDeviceFormTitle, style: textTheme.headlineMedium)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Device Name
                              InputDeviceName(
                                localizations: localizations,
                                accessories: state.accessories,
                                onSelected: (value) {
                                  state.model.deviceName = value;
                                  bloc.add(OnChange(state.model));
                                },
                                onChanged: (value) {
                                  state.model.deviceName = value;
                                  bloc.add(OnChange(state.model));
                                },
                              ),
                              const SizedBox(height: 16),
                              // Device Type
                              Text(
                                localizations.deviceType,
                                style: textTheme.titleLarge,
                              ),
                              SizedBox(height: 8),
                              ListDeviceType(
                                  accessoriesType: state.accessoriesType,
                                  deviceTypeSelected: state.model.deviceTypeId,
                                  onSelected: (id) {
                                    state.model.deviceTypeId = id;
                                    bloc.add(OnChange(state.model));
                                  }),
                              SizedBox(height: 16),
                              // Last Replacement
                              Row(
                                children: [
                                  // Last Replacement Km
                                  Expanded(
                                    child: CustomInputField(
                                      label: localizations.lastReplacement,
                                      value: state.model.lastReplacementKm?.toString() ?? '',
                                      onChanged: (value) {
                                        state.model.lastReplacementKm = int.tryParse(value);
                                        bloc.add(OnChange(state.model));
                                      },
                                      maxLength: 5,
                                      textInputType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Last Replacement Date
                                  Expanded(
                                    child: CustomDatePicker(
                                        context: context,
                                        label: localizations.date,
                                        date: state.model.lastReplacementDate,
                                        onChanged: (value) {
                                          state.model.lastReplacementDate = value;
                                          bloc.add(OnChange(state.model));
                                        }),
                                  ),
                                ],
                              ),
                              // Next Replacement
                              CustomInputField(
                                label: localizations.nextReplacement,
                                value: state.model.nextReplacementKm?.toString() ?? '',
                                onChanged: (value) {
                                  state.model.nextReplacementKm = int.tryParse(value);
                                  bloc.add(OnChange(state.model));
                                },
                                maxLength: 5,
                                textInputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                              // Note
                              CustomInputField(
                                label: localizations.notes,
                                value: state.model.note,
                                onChanged: (value) {
                                  state.model.note = value;
                                  bloc.add(OnChange(state.model));
                                },
                              ),
                              // Save Button
                              OutlinedButton(
                                onPressed: () async {
                                  await bloc.onSave(state.model);
                                  Navigator.pop(context);
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
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
