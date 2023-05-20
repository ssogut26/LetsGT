import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/confirm_reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class ActivityNotifier extends ChangeNotifier {
  String? _activityName;
  String? _activityDescription;
  String? _selectedLocation;
  String? _selectedDate;
  String _selectedTime = '12:00';

  String? get activityName => _activityName;
  String? get activityDescription => _activityDescription;
  String? get selectedLocation => _selectedLocation;
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

  set selectedLocation(String? value) {
    _selectedLocation = value;
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

  Future<void> createActivity() async {
    await MyAuthService().createActivity(
      activityName: activityName ?? '',
      activityDescription: activityDescription ?? '',
      selectedLocation: selectedLocation ?? '',
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
            child: Expanded(
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
                                : '${'Date: ${activityHandler.selectedDate.toString().substring(
                                      0,
                                      10,
                                    )} ${activityHandler.selectedTime}'} ',
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              ).whenComplete(() async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                setState(() {
                                  activityHandler.selectedTime =
                                      selectedTime?.format(context) ?? '';
                                });
                              });
                              setState(() {
                                activityHandler.selectedDate =
                                    date?.toString() ?? '';
                              });
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
                            await activityHandler.createActivity().whenComplete(
                                  () async => AutoRouter.of(context).pop(),
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
      ),
    );
  }
}
