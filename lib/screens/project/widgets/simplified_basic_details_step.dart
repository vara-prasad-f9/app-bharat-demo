import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/project_model.dart';

class SimplifiedBasicDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const SimplifiedBasicDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SimplifiedBasicDetailsStepState createState() => _SimplifiedBasicDetailsStepState();
}

class _SimplifiedBasicDetailsStepState extends State<SimplifiedBasicDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                'Project Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          
            const SizedBox(height: 16),
            
            // Project Code (Read-only)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Project Code',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.projectCode ?? 'PRJ-${DateTime.now().millisecondsSinceEpoch}',
                readOnly: true,
                onChanged: (value) {
                  setState(() {
                    widget.projectData.projectCode = value.trim();
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Construction Start Date
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Construction Start Date',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                ),
                controller: TextEditingController(
                  text: widget.projectData.constructionStartDate != null
                      ? '${widget.projectData.constructionStartDate!.day.toString().padLeft(2, '0')}-${widget.projectData.constructionStartDate!.month.toString().padLeft(2, '0')}-${widget.projectData.constructionStartDate!.year}'
                      : '',
                ),
                readOnly: true,
                validator: (value) {
                  if (widget.projectData.constructionStartDate == null) {
                    return 'Construction start date is required';
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: widget.projectData.constructionStartDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() {
                      widget.projectData.constructionStartDate = picked;
                      widget.onChanged(widget.projectData);
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Expected Completion Date
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Expected Completion Date',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                  suffixIcon: Icon(Icons.calendar_today, size: 20),
                ),
                controller: TextEditingController(
                  text: widget.projectData.expectedCompletionDate != null
                      ? '${widget.projectData.expectedCompletionDate!.day.toString().padLeft(2, '0')}-${widget.projectData.expectedCompletionDate!.month.toString().padLeft(2, '0')}-${widget.projectData.expectedCompletionDate!.year}'
                      : '',
                ),
                readOnly: true,
                validator: (value) {
                  if (widget.projectData.expectedCompletionDate == null) {
                    return 'Expected completion date is required';
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: widget.projectData.expectedCompletionDate ?? DateTime.now().add(const Duration(days: 365)),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() {
                      widget.projectData.expectedCompletionDate = picked;
                      widget.onChanged(widget.projectData);
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Country (Read-only, default India)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: 'India',
                readOnly: true,
              ),
            ),
            const SizedBox(height: 16),
            
            // State (Read-only, default N/A)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: 'N/A',
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
