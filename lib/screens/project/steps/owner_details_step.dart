// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OwnerDetailsStep extends StatefulWidget {
  const OwnerDetailsStep({super.key});

  @override
  State<OwnerDetailsStep> createState() => _OwnerDetailsStepState();
}

class _OwnerDetailsStepState extends State<OwnerDetailsStep> {
  bool _isCompany = false;
  bool _sameAsSiteAddress = false;
  String? _selectedIdProofType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Owner Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Owner Type:'),
              const SizedBox(width: 16),
              ChoiceChip(
                label: const Text('Individual'),
                selected: !_isCompany,
                onSelected: (selected) {
                  setState(() {
                    _isCompany = !selected;
                  });
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: const Text('Company'),
                selected: _isCompany,
                onSelected: (selected) {
                  setState(() {
                    _isCompany = selected;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!_isCompany)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Owner Full Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter owner name';
                }
                return null;
              },
            ),
          if (_isCompany) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Company Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if ((value == null || value.isEmpty) && _isCompany) {
                  return 'Please enter company name';
                }
                return null;
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              if (value.length != 10) {
                return 'Please enter a valid 10-digit mobile number';
              }
              return null;
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
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _sameAsSiteAddress,
                onChanged: (value) {
                  setState(() {
                    _sameAsSiteAddress = value ?? false;
                  });
                },
              ),
              const Text('Same as Site Address'),
            ],
          ),
          if (!_sameAsSiteAddress) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Owner Address',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
          ],
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'ID Proof Type',
              border: OutlineInputBorder(),
            ),
            value: _selectedIdProofType,
            items: const [
              DropdownMenuItem(
                value: 'aadhaar',
                child: Text('Aadhaar'),
              ),
              DropdownMenuItem(
                value: 'pan',
                child: Text('PAN'),
              ),
              DropdownMenuItem(
                value: 'other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedIdProofType = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select ID proof type';
              }
              return null;
            },
          ),
          if (_selectedIdProofType != null) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: '${_selectedIdProofType?.toUpperCase()} Number *',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter ${_selectedIdProofType?.toUpperCase()} number';
                }
                return null;
              },
            ),
          ],
        ],
      ),
    );
  }
}
