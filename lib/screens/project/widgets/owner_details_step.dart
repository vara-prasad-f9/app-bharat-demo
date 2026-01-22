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
            const Text(
              'Owner Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Owner Type *',
                border: OutlineInputBorder(),
              ),
              value: widget.projectData.ownerType,
              items: _ownerTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
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
            const SizedBox(height: 16),
            if (widget.projectData.ownerType == 'Individual')
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Owner Full Name *',
                  border: OutlineInputBorder(),
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
                },
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
                },
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number *',
                border: OutlineInputBorder(),
                prefixText: '+91 ',
              ),
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
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Alternate Mobile Number',
                border: OutlineInputBorder(),
                prefixText: '+91 ',
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
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
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
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Owner Address same as Site Address'),
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
              const SizedBox(height: 16),
              const Text(
                'Owner Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Address',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                onChanged: (value) {
                  // Handle owner address change
                },
              ),
            ],
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'ID Proof Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'ID Proof Type',
                border: OutlineInputBorder(),
              ),
              value: widget.projectData.idProofType,
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
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: widget.projectData.idProofType == 'Aadhaar'
                    ? 'Aadhaar Number'
                    : widget.projectData.idProofType == 'PAN'
                        ? 'PAN Number'
                        : 'ID Number',
                border: const OutlineInputBorder(),
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
          ],
        ),
      ),
    );
  }
}
