// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/project_model.dart';

class OwnerDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const OwnerDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _OwnerDetailsStepState createState() => _OwnerDetailsStepState();
}

class _OwnerDetailsStepState extends State<OwnerDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Owner Details Section
            const Text(
              'Owner Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Owner Name (Required)
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Owner Name *',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.ownerName ?? '',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Owner name is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.projectData.ownerName = value;
                  widget.onChanged(widget.projectData);
                  _formKey.currentState?.validate();
                },
                onFieldSubmitted: (_) {
                  _formKey.currentState?.validate();
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Owner Phone Number
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Owner Phone Number',
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                  labelStyle: TextStyle(fontSize: 13),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                initialValue: widget.projectData.ownerPhoneNumber ?? '',
                onChanged: (value) {
                  widget.projectData.ownerPhoneNumber = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Owner Email ID
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Owner Email ID',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.projectData.ownerEmail ?? '',
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value!)) {
                      return 'Enter a valid email address';
                    }
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.projectData.ownerEmail = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Supervisor Details Section
            const Text(
              'Supervisor Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Supervisor Name
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Supervisor Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.supervisorName ?? '',
                onChanged: (value) {
                  widget.projectData.supervisorName = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Supervisor Phone Number
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Supervisor Phone Number',
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                  labelStyle: TextStyle(fontSize: 13),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                initialValue: widget.projectData.supervisorPhoneNumber ?? '',
                onChanged: (value) {
                  widget.projectData.supervisorPhoneNumber = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Watchman Details Section
            const Text(
              'Watchman Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Watchman Name
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Watchman Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.watchmanName ?? '',
                onChanged: (value) {
                  widget.projectData.watchmanName = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Watchman Phone Number
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Watchman Phone Number',
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                  labelStyle: TextStyle(fontSize: 13),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                initialValue: widget.projectData.watchmanPhoneNumber ?? '',
                onChanged: (value) {
                  widget.projectData.watchmanPhoneNumber = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
