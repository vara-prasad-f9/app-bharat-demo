// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:searchfield/searchfield.dart';

enum SuggestionState {
  hidden,
  expanded,
  floating,
}

class SearchFieldThemeData {
  final InputDecoration searchInputDecoration;
  
  const SearchFieldThemeData({
    required this.searchInputDecoration,
  });
}

class SearchField<T> extends StatefulWidget {
  final TextEditingController? controller;
  final List<SearchFieldListItem<T>> suggestions;
  final SuggestionState suggestionState;
  final double itemHeight;
  final int maxSuggestionsInViewPort;
  final Function(SearchFieldListItem<T>)? onSuggestionTap;
  final InputDecoration? decoration;
  final SearchFieldThemeData? searchInputDecoration;

  const SearchField({
    Key? key,
    this.controller,
    required this.suggestions,
    this.suggestionState = SuggestionState.hidden,
    this.itemHeight = 50.0,
    this.maxSuggestionsInViewPort = 5,
    this.onSuggestionTap,
    this.decoration,
    this.searchInputDecoration,
  }) : super(key: key);

  @override
  _SearchFieldState<T> createState() => _SearchFieldState<T>();
}

class _SearchFieldState<T> extends State<SearchField<T>> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: widget.decoration ?? widget.searchInputDecoration?.searchInputDecoration,
    );
  }
}

class TeamAssignmentStep extends ConsumerStatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const TeamAssignmentStep({
    super.key,
    required this.projectData,
    required this.onChanged,
  });

  @override
  ConsumerState<TeamAssignmentStep> createState() => _TeamAssignmentStepState();
}

class _TeamAssignmentStepState extends ConsumerState<TeamAssignmentStep> {
  // Sample data - Replace with actual data from your API/database
  final List<String> _contractors = [
    'ABC Constructions',
    'XYZ Builders',
    'PQR Infrastructure',
    'LMN Constructions',
    'EFG Builders',
  ];

  final List<String> _suppliers = [
    'Shree Cement',
    'UltraTech Cement',
    'JSW Steel',
    'Tata Steel',
    'Hindalco',
  ];

  final List<String> _engineers = [
    'Rajesh Kumar',
    'Priya Sharma',
    'Amit Patel',
    'Sneha Reddy',
    'Vikram Singh',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Contractors'),
            const SizedBox(height: 8),
            _buildMultiSelectSearchField(
              hint: 'Search and select contractors',
              items: _contractors,
              selectedItems: widget.projectData.assignedContractors ?? [],
              onChanged: (selected) {
                setState(() {
                  widget.projectData.assignedContractors = selected;
                });
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Suppliers'),
            const SizedBox(height: 8),
            _buildMultiSelectSearchField(
              hint: 'Search and select suppliers',
              items: _suppliers,
              selectedItems: widget.projectData.assignedSuppliers ?? [],
              onChanged: (selected) {
                setState(() {
                  widget.projectData.assignedSuppliers = selected;
                });
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Engineers'),
            const SizedBox(height: 8),
            _buildSearchField(
              hint: 'Select site engineer',
              items: _engineers,
              selectedItem: widget.projectData.siteEngineer,
              onChanged: (selected) {
                setState(() {
                  widget.projectData.siteEngineer = selected;
                });
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Admin In Charge'),
            const SizedBox(height: 8),
            _buildSearchField(
              hint: 'Select admin in charge',
              items: _engineers,
              selectedItem: widget.projectData.adminInCharge,
              onChanged: (selected) {
                setState(() {
                  widget.projectData.adminInCharge = selected;
                });
                widget.onChanged(widget.projectData);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMultiSelectSearchField({
    required String hint,
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: const Icon(Icons.search),
          ),
          onTap: () {
            // Create a local copy of selected items for the dialog
            List<String> localSelectedItems = List.from(selectedItems);
            
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setDialogState) {
                    return AlertDialog(
                      title: Text('Select $hint'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(item),
                              value: localSelectedItems.contains(item),
                              onChanged: (bool? selected) {
                                setDialogState(() {
                                  if (selected == true) {
                                    if (!localSelectedItems.contains(item)) {
                                      localSelectedItems.add(item);
                                    }
                                  } else {
                                    localSelectedItems.remove(item);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Update the parent widget's state with the final selection
                            onChanged(localSelectedItems);
                            Navigator.pop(context);
                          },
                          child: const Text('Done'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        if (selectedItems.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedItems.map((item) => Chip(
              label: Text(item),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                final selected = List<String>.from(selectedItems);
                selected.remove(item);
                onChanged(selected);
              },
            )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildSearchField({
    required String hint,
    required List<String> items,
    required String? selectedItem,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: selectedItem,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
