import 'package:flutter/material.dart';

class AssignmentDetailsStep extends StatefulWidget {
  const AssignmentDetailsStep({super.key});

  @override
  State<AssignmentDetailsStep> createState() => _AssignmentDetailsStepState();
}

class _AssignmentDetailsStepState extends State<AssignmentDetailsStep> {
  final List<String> _selectedContractors = [];
  final List<String> _selectedSuppliers = [];
  String? _selectedEngineer;
  String? _selectedAdmin;

  // Mock data - replace with actual data from your backend
  final List<String> _contractors = [
    'ABC Construction',
    'XYZ Builders',
    'PQR Contractors',
    'MNO Constructions',
  ];

  final List<String> _suppliers = [
    'Cement Plus',
    'Steel King',
    'Brick House',
    'Tiles R Us',
  ];

  final List<String> _engineers = [
    'Rahul Sharma',
    'Priya Patel',
    'Amit Singh',
    'Neha Gupta',
  ];

  final List<String> _admins = [
    'Admin User',
    'Site Manager',
    'Project Coordinator',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Assignment Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'Assigned Contractors',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildMultiSelectField(
            hint: 'Select Contractors',
            items: _contractors,
            selectedItems: _selectedContractors,
            onChanged: (selected) {
              setState(() {
                _selectedContractors.clear();
                _selectedContractors.addAll(selected);
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Assigned Suppliers',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildMultiSelectField(
            hint: 'Select Suppliers',
            items: _suppliers,
            selectedItems: _selectedSuppliers,
            onChanged: (selected) {
              setState(() {
                _selectedSuppliers.clear();
                _selectedSuppliers.addAll(selected);
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Assigned Site Engineer',
              border: OutlineInputBorder(),
            ),
            value: _selectedEngineer,
            items: _engineers
                .map((engineer) => DropdownMenuItem(
                      value: engineer,
                      child: Text(engineer),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedEngineer = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Admin-in-Charge',
              border: OutlineInputBorder(),
            ),
            value: _selectedAdmin,
            items: _admins
                .map((admin) => DropdownMenuItem(
                      value: admin,
                      child: Text(admin),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedAdmin = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select an admin';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          if (_selectedContractors.isNotEmpty ||
              _selectedSuppliers.isNotEmpty ||
              _selectedEngineer != null ||
              _selectedAdmin != null) ...[
            const Text(
              'Assigned Team',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedContractors.isNotEmpty) ...[
                      const Text(
                        'Contractors:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._selectedContractors.map((contractor) => Text('• $contractor')).toList(),
                      const SizedBox(height: 8),
                    ],
                    if (_selectedSuppliers.isNotEmpty) ...[
                      const Text(
                        'Suppliers:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._selectedSuppliers.map((supplier) => Text('• $supplier')).toList(),
                      const SizedBox(height: 8),
                    ],
                    if (_selectedEngineer != null) ...[
                      const Text(
                        'Site Engineer:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('• $_selectedEngineer'),
                      const SizedBox(height: 8),
                    ],
                    if (_selectedAdmin != null) ...[
                      const Text(
                        'Admin-in-Charge:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('• $_selectedAdmin'),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMultiSelectField({
    required String hint,
    required List<String> items,
    required List<String> selectedItems,
    required void Function(List<String>) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: selectedItems.map((item) {
              return Chip(
                label: Text(item),
                onDeleted: () {
                  setState(() {
                    selectedItems.remove(item);
                    onChanged(selectedItems);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Add $hint'),
              isDense: true,
              items: items
                  .where((item) => !selectedItems.contains(item))
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged([...selectedItems, newValue]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
