import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/add_device_bloc/add_device_bloc.dart';
import '../dependencies.dart';
import '../theme/app_colors.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      child: Text(
                        localizations.addDeviceFormTitle,
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Device Name
                            Text(
                              localizations.deviceName,
                              style: textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: TextEditingController(text: ''),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              localizations.deviceType,
                              style: textTheme.titleLarge,
                            ),
                            ...state.accessoriesType
                                .map((e) => TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      child: Text(e.nameVi!),
                                    )))
                                .toList(),
                            SizedBox(
                              height: 16,
                            ),
                            // Last Replacement
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localizations.lastReplacement,
                                        style: textTheme.titleLarge,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextField(
                                        controller: TextEditingController(text: ''),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(22),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localizations.date,
                                        style: textTheme.titleLarge,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextField(
                                        controller: TextEditingController(text: ''),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(22),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // Next Replacement
                            Text(
                              localizations.nextReplacement,
                              style: textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: TextEditingController(text: ''),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // Note
                            Text(
                              localizations.notes,
                              style: textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: TextEditingController(text: ''),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.blue,
                              height: 40,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(localizations.save),
                              ),
                            )
                          ],
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
