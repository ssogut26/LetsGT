import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';

@RoutePage()
class CreateActivityPage extends ConsumerStatefulWidget {
  const CreateActivityPage({super.key});

  @override
  ConsumerState<CreateActivityPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<CreateActivityPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppPaddings.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
              TextFormField(
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
              // Location
              ListTile(
                title: const Text('Select Location'),
                trailing: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).push(
                      MapRoute(),
                    );
                  },
                  icon: const Icon(Icons.map),
                ),
              ),
              ListTile(
                title: const Text('Select Date'),
                trailing: IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: FittedBox(
                            fit: BoxFit.contain,
                            child: DatePickerDialog(
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
              // Duration

              // Participants
              // Tags
            ],
          ),
        ),
      ),
    );
  }
}
