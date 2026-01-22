// ignore_for_file: unused_field, library_private_types_in_public_api, use_super_parameters, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../models/project_model.dart';

class ConstructionDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const ConstructionDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ConstructionDetailsStepState createState() => _ConstructionDetailsStepState();
}

class _ConstructionDetailsStepState extends State<ConstructionDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _constructionMethods = ['RCC', 'Steel', 'Mixed'];
  final List<String> _projectPriorities = ['Low', 'Medium', 'High'];
  
  final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 0,
    locale: 'en_IN',
  );

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
              'Construction Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Total Plot Area',
                      border: OutlineInputBorder(),
                      suffixText: 'sq.ft',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    initialValue: widget.projectData.totalPlotArea?.toString(),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.projectData.totalPlotArea = double.tryParse(value);
                      } else {
                        widget.projectData.totalPlotArea = null;
                      }
                      widget.onChanged(widget.projectData);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Built-up Area',
                      border: OutlineInputBorder(),
                      suffixText: 'sq.ft',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    initialValue: widget.projectData.builtUpArea?.toString(),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.projectData.builtUpArea = double.tryParse(value);
                        widget.onChanged(widget.projectData);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Number of Floors *',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    initialValue: widget.projectData.numberOfFloors?.toString(),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Number of floors is required';
                      }
                      if (int.tryParse(value!) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.projectData.numberOfFloors = int.tryParse(value);
                        widget.onChanged(widget.projectData);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Construction Method *',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: widget.projectData.constructionMethod,
                    items: _constructionMethods.map((method) {
                      return DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.projectData.constructionMethod = value;
                        widget.onChanged(widget.projectData);
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select construction method' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Estimated Budget',
                border: const OutlineInputBorder(),
                prefixText: '₹ ',
                suffixText: 'INR',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              initialValue: widget.projectData.estimatedBudget?.toString(),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  widget.projectData.estimatedBudget = double.tryParse(value);
                  widget.onChanged(widget.projectData);
                }
              },
            ),
            if (widget.projectData.estimatedBudget != null) ...[
              const SizedBox(height: 8),
              Text(
                '${_formatNumber(widget.projectData.estimatedBudget!)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Project Priority',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.projectPriority,
              items: _projectPriorities.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.projectData.projectPriority = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Additional Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter any additional construction details or notes...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              maxLines: 4,
              onChanged: (value) {
                // Handle additional notes
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 10000000) {
      return '${(number / 10000000).toStringAsFixed(2)} Crore';
    } else if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(2)} Lakh';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)} Thousand';
    }
    return number.toStringAsFixed(2);
  }
}
