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
  final List<String> _ownerTypes = ['Individual', 'Company'];
  final List<String> _idProofTypes = ['Aadhaar', 'PAN', 'Other'];
  bool _isSameAsSiteAddress = false;

  @override
  void initState() {
    super.initState();
    _isSameAsSiteAddress = widget.projectData.isSameAsSiteAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                'Owner Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Owner Type *',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.ownerType,
                items: _ownerTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, style: const TextStyle(fontSize: 13)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.projectData.ownerType = value;
                    if (value == 'Company') {
                      widget.projectData.ownerName = null;
                    }
                    widget.onChanged(widget.projectData);
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select owner type' : null,
              ),
            ),
            const SizedBox(height: 16),
            if (widget.projectData.ownerType == 'Individual')
              SizedBox(
                height: 50,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Owner Full Name *',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 13)
                  ),
                  initialValue: widget.projectData.ownerName ?? '',
                  validator: (value) =>
                      (widget.projectData.ownerType == 'Individual' &&
                              (value?.isEmpty ?? true))
                          ? 'Owner name is required'
                          : null,
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
            if (widget.projectData.ownerType == 'Company') ...[
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Company Name *',
                  border: OutlineInputBorder(),
                ),
                initialValue: widget.projectData.companyName ?? '',
                validator: (value) =>
                    (widget.projectData.ownerType == 'Company' &&
                            (value?.isEmpty ?? true))
                        ? 'Company name is required'
                        : null,
                onChanged: (value) {
                  widget.projectData.companyName = value;
                  widget.onChanged(widget.projectData);
                  _formKey.currentState?.validate();
                },
                onFieldSubmitted: (_) {
                  _formKey.currentState?.validate();
                },
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Mobile Number *',
                border: const OutlineInputBorder(),
                prefixText: '+91 ',
                labelStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                errorStyle: const TextStyle(fontSize: 11, height: 0.8),
                errorMaxLines: 2,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400, width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              initialValue: widget.projectData.mobileNumber ?? '',
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Mobile number is required';
                }
                if (value!.length != 10) {
                  return 'Enter a valid 10-digit mobile number';
                }
                return null;
              },
              onChanged: (value) {
                widget.projectData.mobileNumber = value;
                widget.onChanged(widget.projectData);
                // Clear error when user starts typing
                if (value.isNotEmpty) {
                  _formKey.currentState?.validate();
                }
              },
              onFieldSubmitted: (_) {
                _formKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height:50,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Alternate Mobile Number',
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                  labelStyle: TextStyle(fontSize: 13)
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                initialValue: widget.projectData.alternateMobileNumber ?? '',
                onChanged: (value) {
                  widget.projectData.alternateMobileNumber = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height:50,
              child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 13)
              ),
              keyboardType: TextInputType.emailAddress,
              initialValue: widget.projectData.email ?? '',
              validator: (value) {
                if (value?.isNotEmpty == true) {
                  final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value!)) {
                    return 'Enter a valid email address';
                  }
                }
                return null;
              },
              onChanged: (value) {
                widget.projectData.email = value;
                widget.onChanged(widget.projectData);
              },
            ),
            ),
            const SizedBox(height: 6),
            SwitchListTile(
              title: const Text('Owner Address same as Site Address', style: TextStyle(fontSize: 12)),
              value: _isSameAsSiteAddress,
              onChanged: (value) {
                setState(() {
                  _isSameAsSiteAddress = value;
                  widget.projectData.isSameAsSiteAddress = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            if (!_isSameAsSiteAddress) ...[
              const SizedBox(height: 6),
              const Text(
                'Owner Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Full Address',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 13)
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    // Handle owner address change
                    widget.projectData.ownerAddress = value;
                    widget.onChanged(widget.projectData);
                  },
                  initialValue: widget.projectData.ownerAddress ?? '',
                ),
              ),
            ],
            const SizedBox(height: 6),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'ID Proof Details',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'ID Proof Type',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13)
                ),
                initialValue: widget.projectData.idProofType,
                items: _idProofTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.projectData.idProofType = value;
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 6),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: widget.projectData.idProofType == 'Aadhaar'
                      ? 'Aadhaar Number'
                      : widget.projectData.idProofType == 'PAN'
                          ? 'PAN Number'
                          : 'ID Number',
                  border: const OutlineInputBorder(),
                  labelStyle: const TextStyle(fontSize: 13),
                  hintText: widget.projectData.idProofType == 'Aadhaar'
                      ? 'XXXX XXXX XXXX'
                      : widget.projectData.idProofType == 'PAN'
                          ? 'ABCDE1234F'
                          : 'Enter ID number',
                ),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  if (widget.projectData.idProofType == 'Aadhaar')
                    FilteringTextInputFormatter.digitsOnly,
                  if (widget.projectData.idProofType == 'Aadhaar')
                    LengthLimitingTextInputFormatter(12),
                  if (widget.projectData.idProofType == 'PAN')
                    LengthLimitingTextInputFormatter(10),
                ],
                initialValue: widget.projectData.idProofNumber ?? '',
                onChanged: (value) {
                  widget.projectData.idProofNumber = value;
                  widget.onChanged(widget.projectData);
                },
                validator: (value) {
                  if (value?.isNotEmpty == true) {
                    if (widget.projectData.idProofType == 'Aadhaar' &&
                        value!.length != 12) {
                      return 'Aadhaar must be 12 digits';
                    }
                    if (widget.projectData.idProofType == 'PAN' &&
                        value!.length != 10) {
                      return 'PAN must be 10 characters';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
