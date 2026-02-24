// ignore_for_file: use_super_parameters, library_private_types_in_public_api, deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import '../../../models/project_model.dart';

class BasicDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const BasicDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BasicDetailsStepState createState() => _BasicDetailsStepState();
}

class _BasicDetailsStepState extends State<BasicDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _projectTypes = [
    'Community',
    'Villa',
    'Building',
    'Flat',
    'Individual',
    'Group housing',
    'Industrial',
    'Business',
    'Commercial complex',
    'SEZ',
    'Small house',
    'Farm house',
    'Stadium',
    'Parks',
    'Government',
    'Residential',
    'Commercial',
    'Infrastructure',
    'Others',
  ];
  final List<String> _projectStages = [
    'Planning',
    'Foundation',
    'Structure',
    'Brick Work',
    'Finishing',
    'Completed',
  ];
  final List<String> _projectStatuses = ['In Progress', 'On Hold'];

  @override
  void initState() {
    super.initState();
    if (widget.projectData.projectName != null) {
      _formKey.currentState?.validate();
    }
  }

  @override
  void didUpdateWidget(covariant BasicDetailsStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.projectData != oldWidget.projectData) {
      _formKey.currentState?.validate();
    }
  }

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
                'Basic Project Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),
            // Project Name (Required)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Project Name *',
                  border: OutlineInputBorder(),
                  hintText: 'Enter project name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.projectName,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Project name is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    widget.projectData.projectName = value.trim();
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Project Type (Required)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Type *',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                // Create rows with 3 items each for Project Type
                ...List.generate((_projectTypes.length / 3).ceil(), (rowIndex) {
                  final startIndex = rowIndex * 3;
                  final endIndex = (startIndex + 3).clamp(
                    0,
                    _projectTypes.length,
                  );
                  final rowTypes = _projectTypes.sublist(startIndex, endIndex);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        ...rowTypes.map((type) {
                          IconData icon;
                          switch (type) {
                            case 'Community':
                              icon = Icons.group_work;
                              break;
                            case 'Villa':
                              icon = Icons.home;
                              break;
                            case 'Building':
                              icon = Icons.apartment;
                              break;
                            case 'Flat':
                              icon = Icons.domain;
                              break;
                            case 'Individual':
                              icon = Icons.person;
                              break;
                            case 'Group housing':
                              icon = Icons.groups;
                              break;
                            case 'Industrial':
                              icon = Icons.factory;
                              break;
                            case 'Business':
                              icon = Icons.business;
                              break;
                            case 'Commercial complex':
                              icon = Icons.store;
                              break;
                            case 'SEZ':
                              icon = Icons.location_on;
                              break;
                            case 'Small house':
                              icon = Icons.home_outlined;
                              break;
                            case 'Farm house':
                              icon = Icons.agriculture;
                              break;
                            case 'Stadium':
                              icon = Icons.stadium;
                              break;
                            case 'Parks':
                              icon = Icons.park;
                              break;
                            case 'Government':
                              icon = Icons.account_balance;
                              break;
                            case 'Residential':
                              icon = Icons.house;
                              break;
                            case 'Commercial':
                              icon = Icons.business_center;
                              break;
                            case 'Infrastructure':
                              icon = Icons.construction;
                              break;
                            case 'Others':
                              icon = Icons.more_horiz;
                              break;
                            default:
                              icon = Icons.category;
                          }

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.projectData.projectType = type;
                                  widget.onChanged(widget.projectData);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right:
                                      rowTypes.indexOf(type) <
                                          rowTypes.length - 1
                                      ? 8.0
                                      : 0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        widget.projectData.projectType == type
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: widget.projectData.projectType == type
                                      ? Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.1)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 14,
                                      color:
                                          widget.projectData.projectType == type
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        type,
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          color:
                                              widget.projectData.projectType ==
                                                  type
                                              ? Theme.of(context).primaryColor
                                              : Colors.black,
                                          fontWeight:
                                              widget.projectData.projectType ==
                                                  type
                                              ? FontWeight.w500
                                              : FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        // Add empty boxes if the row is not full to maintain alignment
                        ...List.generate(
                          3 - rowTypes.length,
                          (index) => const Expanded(child: SizedBox()),
                        ),
                      ],
                    ),
                  );
                }),
                if (widget.projectData.projectType == null ||
                    widget.projectData.projectType!.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Text(
                      'Please select a project type',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // Current Stage (Radio Buttons with Icons)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Stage',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                // Create rows with 3 items each
                ...List.generate((_projectStages.length / 3).ceil(), (
                  rowIndex,
                ) {
                  final startIndex = rowIndex * 3;
                  final endIndex = (startIndex + 3).clamp(
                    0,
                    _projectStages.length,
                  );
                  final rowStages = _projectStages.sublist(
                    startIndex,
                    endIndex,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: rowStages.map((stage) {
                        IconData icon;
                        switch (stage) {
                          case 'Planning':
                            icon = Icons.edit_note;
                            break;
                          case 'Foundation':
                            icon = Icons.foundation;
                            break;
                          case 'Structure':
                            icon = Icons.domain;
                            break;
                          case 'Brick Work':
                            icon = Icons.grid_view;
                            break;
                          case 'Finishing':
                            icon = Icons.brush;
                            break;
                          case 'Completed':
                            icon = Icons.check_circle;
                            break;
                          default:
                            icon = Icons.circle;
                        }

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.projectData.currentStage = stage;
                                widget.onChanged(widget.projectData);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right:
                                    rowStages.indexOf(stage) <
                                        rowStages.length - 1
                                    ? 8.0
                                    : 0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      widget.projectData.currentStage == stage
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade300,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                color: widget.projectData.currentStage == stage
                                    ? Theme.of(
                                        context,
                                      ).primaryColor.withValues(alpha: 0.1)
                                    : Colors.transparent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    icon,
                                    size: 16,
                                    color:
                                        widget.projectData.currentStage == stage
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    stage,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color:
                                          widget.projectData.currentStage ==
                                              stage
                                          ? Theme.of(context).primaryColor
                                          : Colors.black,
                                      fontWeight:
                                          widget.projectData.currentStage ==
                                              stage
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            // Project Status (Radio Buttons)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Status *',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _projectStatuses.map((status) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.projectData.projectStatus = status;
                          widget.onChanged(widget.projectData);
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: status,
                            groupValue: widget.projectData.projectStatus,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  widget.projectData.projectStatus = value;
                                  widget.onChanged(widget.projectData);
                                });
                              }
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text(status, style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 16),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate() &&
                    (widget.projectData.projectStatus == null ||
                        widget.projectData.projectStatus!.isEmpty))
                  const Text(
                    'Project status is required',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
