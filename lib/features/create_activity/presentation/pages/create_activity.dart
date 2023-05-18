import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';

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
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppPaddings.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    ),
                  ),
                ],
              ),
              // Location
              Column(
                children: [
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
                        selectedDate.toString() == 'null'
                            ? 'Select Date'
                            : '${'Date: ${selectedDate.toString().substring(
                                  0,
                                  10,
                                )} ${selectedTime?.format(context) ?? ''}'} ',
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                          ).whenComplete(() async {
                            selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                          });
                          setState(() {
                            selectedDate = date;
                            selectedDate?.toUtc();
                          });
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  // Participants
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
