import 'package:flutter/material.dart';

class ConstructionDetailsStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const ConstructionDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  State<ConstructionDetailsStep> createState() => _ConstructionDetailsStepState();
}

class _ConstructionDetailsStepState extends State<ConstructionDetailsStep> {
  String? _selectedConstructionMethod;
  String? _selectedPriority;
  final TextEditingController _plotAreaController = TextEditingController();
  final TextEditingController _builtUpAreaController = TextEditingController();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  @override
  void dispose() {
    _plotAreaController.dispose();
    _builtUpAreaController.dispose();
    _floorsController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Construction Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _plotAreaController,
                  decoration: const InputDecoration(
                    labelText: 'Total Plot Area *',
                    border: OutlineInputBorder(),
                    suffixText: 'sq.ft',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter plot area';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: () {
                  // Toggle between sq.ft and sq.m
                  // Implementation needed
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _builtUpAreaController,
            decoration: const InputDecoration(
              labelText: 'Built-up Area',
              border: OutlineInputBorder(),
              suffixText: 'sq.ft',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _floorsController,
            decoration: const InputDecoration(
              labelText: 'Number of Floors',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Construction Method',
              border: OutlineInputBorder(),
            ),
            value: _selectedConstructionMethod,
            items: const [
              DropdownMenuItem(
                value: 'rcc',
                child: Text('RCC (Reinforced Cement Concrete)'),
              ),
              DropdownMenuItem(
                value: 'steel',
                child: Text('Steel Structure'),
              ),
              DropdownMenuItem(
                value: 'mixed',
                child: Text('Mixed (RCC + Steel)'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedConstructionMethod = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select construction method';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _budgetController,
            decoration: const InputDecoration(
              labelText: 'Estimated Budget',
              border: OutlineInputBorder(),
              prefixText: '₹ ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text(
            'Project Priority',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: const Text('Low'),
                selected: _selectedPriority == 'low',
                onSelected: (selected) {
                  setState(() {
                    _selectedPriority = selected ? 'low' : null;
                  });
                },
                selectedColor: Colors.green[100],
              ),
              ChoiceChip(
                label: const Text('Medium'),
                selected: _selectedPriority == 'medium',
                onSelected: (selected) {
                  setState(() {
                    _selectedPriority = selected ? 'medium' : null;
                  });
                },
                selectedColor: Colors.orange[100],
              ),
              ChoiceChip(
                label: const Text('High'),
                selected: _selectedPriority == 'high',
                onSelected: (selected) {
                  setState(() {
                    _selectedPriority = selected ? 'high' : null;
                  });
                },
                selectedColor: Colors.red[100],
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_selectedPriority != null)
            Text(
              _selectedPriority == 'high'
                  ? 'High priority projects will be given top attention.'
                  : _selectedPriority == 'medium'
                      ? 'Medium priority projects follow normal scheduling.'
                      : 'Low priority projects may have longer timelines.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
