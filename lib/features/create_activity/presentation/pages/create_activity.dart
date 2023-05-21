import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/confirm_reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class ActivityNotifier extends ChangeNotifier {
  String? _activityName;
  String? _activityDescription;
  String? _selectedDate;
  String _selectedTime = '12:00';

  String? get activityName => _activityName;
  String? get activityDescription => _activityDescription;
  String? get selectedDate => _selectedDate;
  String get selectedTime => _selectedTime;

  set activityName(String? value) {
    _activityName = value;
    notifyListeners();
  }

  set activityDescription(String? value) {
    _activityDescription = value;
    notifyListeners();
  }

  set selectedDate(String? value) {
    _selectedDate = value;
    notifyListeners();
  }

  set selectedTime(String value) {
    _selectedTime = value;
    notifyListeners();
  }

  Future<void> createActivity(String selectedLocation) async {
    await MyAuthService().createActivity(
      activityName: activityName ?? '',
      activityDescription: activityDescription ?? '',
      selectedLocation: selectedLocation,
      selectedDate: selectedDate ?? '',
    );
    notifyListeners();
  }
}

final activityProvider = ChangeNotifierProvider(
  (ref) => ActivityNotifier(),
);

@RoutePage()
class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({super.key, this.locationInfo});

  final String? locationInfo;

  @override
  ConsumerState<CreateActivityPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<CreateActivityPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> participants = [];
  String? formattedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    print(selectedTime);

    final selectedDateTime = DateTime(
      picked!.year,
      picked.month,
      picked.day,
      selectedTime!.hour,
      selectedTime.minute,
    );

    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final activityHandler = ref.watch(activityProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppPaddings.pagePadding,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: AppPaddings.fieldAndButtonPadding,
                    child: Text(
                      'Activity Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Activity Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          activityHandler.activityName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Activity Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          activityHandler.activityDescription = value;
                        },
                      ),
                    ),
                  ],
                ),
                // Location
                resizableHeightBox(
                  context,
                  keyboardClosedHeight: 0.02,
                ),

                Column(
                  children: [
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Time and Location',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: ListTile(
                        title: Text(widget.locationInfo ?? 'Select Location'),
                        trailing: IconButton(
                          onPressed: () {
                            AutoRouter.of(context).push(
                              const MapRoute(),
                            );
                          },
                          icon: const Icon(Icons.map),
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: ListTile(
                        title: Text(
                          activityHandler.selectedDate.toString() == 'null'
                              ? 'Select Date'
                              : 'Date: ${activityHandler.selectedDate}',
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await _selectDateTime(context).whenComplete(
                              () => activityHandler.selectedDate =
                                  formattedDateTime ?? '',
                            );
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    // Participants
                    resizableHeightBox(
                      context,
                      keyboardClosedHeight: 0.02,
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: AppPaddings.fieldAndButtonPadding,
                        child: Text(
                          'Participants',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppPaddings.fieldAndButtonPadding,
                      child: ListTile(
                        title: const Text('Who Is Coming?'),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  content: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text('Friends'),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    resizableHeightBox(
                      context,
                      keyboardClosedHeight: 0.02,
                    ),
                    AppElevatedButton(
                      text: 'CREATE ACTIVITY',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          await activityHandler
                              .createActivity(
                                widget.locationInfo ?? '',
                              )
                              .whenComplete(
                                () async => AutoRouter.of(context).replace(
                                  const ActivitiesRoute(),
                                ),
                              );
                        }
                      },
                    ),
                    resizableHeightBox(
                      context,
                      keyboardClosedHeight: 0.02,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
