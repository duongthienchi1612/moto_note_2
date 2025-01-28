import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/add_device_bloc/add_device_bloc.dart';
import '../constants.dart';
import '../dependencies.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../theme/app_colors.dart';
import 'custom_text_field.dart';

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
                padding: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ),
                    Center(
                      child: Text(localizations.addDeviceFormTitle, style: textTheme.headlineMedium),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Device Name
                              Text(
                                localizations.deviceName,
                                style: textTheme.titleLarge,
                              ),
                              CustomTextField(
                                data: state.model.deviceName,
                                onChange: (name) {
                                state.model.deviceName = name;
                                bloc.add(OnChange(state.model));
                              }),
                              // Device Type
                              Text(
                                localizations.deviceType,
                                style: textTheme.titleLarge,
                              ),
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
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(localizations.lastReplacement, style: textTheme.titleLarge),
                                        CustomTextField(onChange: (value) {}),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(localizations.date, style: textTheme.titleLarge),
                                        CustomTextField(onChange: (value) {}),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Next Replacement
                              Text(localizations.nextReplacement, style: textTheme.titleLarge),
                              CustomTextField(onChange: (value) {}),
                              // Note
                              Text(localizations.notes, style: textTheme.titleLarge),
                              CustomTextField(onChange: (value) {}),
                              Container(
                                width: double.infinity,
                                color: Colors.blue,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    bloc.onSave(state.model);
                                  },
                                  child: Text(localizations.save),
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

class ListDeviceType extends StatelessWidget {
  final List<AccessoryTypeEntity> accessoriesType;
  final int? deviceTypeSelected;
  final Function(int) onSelected;
  const ListDeviceType({required this.accessoriesType, this.deviceTypeSelected, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...accessoriesType
                  .take(4)
                  .map(
                    (e) => AnimatedContainer(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: deviceTypeSelected == e.id ? AppColors.devicesType[e.id]! : Colors.white,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        border: Border.all(
                          color: deviceTypeSelected == e.id ? Colors.black : Colors.grey,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            textStyle: deviceTypeSelected == e.id ? textTheme.titleLarge : textTheme.bodyLarge),
                        onPressed: () => onSelected(e.id!),
                        child: Text(e.nameVi!),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          Row(
            children: [
              ...accessoriesType
                  .skip(4)
                  .map(
                    (e) => AnimatedContainer(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.only(right: 8),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: deviceTypeSelected == e.id ? AppColors.devicesType[e.id]! : Colors.white,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        border: Border.all(
                          color: deviceTypeSelected == e.id ? Colors.black : Colors.grey,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            textStyle: deviceTypeSelected == e.id ? textTheme.titleLarge : textTheme.bodyLarge),
                        onPressed: () => onSelected(e.id!),
                        child: Text(e.nameVi!),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
