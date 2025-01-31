import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../bloc/add_device_bloc/add_device_bloc.dart';
import '../constants.dart';
import '../dependencies.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../theme/app_colors.dart';
import 'custom_input_field.dart';
import 'custom_text_field.dart';
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
                              CustomInputField(
                                  label: localizations.deviceName,
                                  value: state.model.deviceName,
                                  onChanged: (name) {
                                    state.model.deviceName = name;
                                    bloc.add(OnChange(state.model));
                                  }),
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
                                      textInputType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Last Replacement Date
                                  Expanded(
                                    child: _buildDatePicker(
                                      localizations.date,
                                      state.model.lastReplacementDate,
                                      (value) {
                                        state.model.lastReplacementDate = value;
                                        bloc.add(OnChange(state.model));
                                      },
                                    ),
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

  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime?) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: OutlinedButton.icon(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - Constants.rangeOfYear),
                lastDate: DateTime.now(),
              );
              onChange(pickedDate);
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
            icon: const Icon(Icons.calendar_month),
            label: Center(
              child: Text(
                date != null ? DateFormat('dd-MM-yyyy').format(date) : '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
