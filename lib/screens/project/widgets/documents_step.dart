// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/widgets/photo_picker.dart';

class DocumentsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const DocumentsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DocumentsStepState createState() => _DocumentsStepState();
}

class _DocumentsStepState extends State<DocumentsStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Documentation & Media',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Site Plan / Blueprints Section
          _buildDocumentSection(
            title: 'Site Plan / Blueprints',
            subtitle: 'Upload PDF or Image files (max 5 files)',
            initialFiles: widget.projectData.sitePlans ?? [],
            onFilesChanged: (files) {
              setState(() {
                widget.projectData.sitePlans = files;
                widget.onChanged(widget.projectData);
              });
            },
            maxFiles: 5,
            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
          ),
          
          const SizedBox(height: 24),
          
          // Initial Site Photos Section
          _buildDocumentSection(
            title: 'Initial Site Photos',
            subtitle: 'Upload photos of the site (max 10 files)',
            initialFiles: widget.projectData.sitePhotos ?? [],
            onFilesChanged: (files) {
              setState(() {
                widget.projectData.sitePhotos = files;
                widget.onChanged(widget.projectData);
              });
            },
            maxFiles: 10,
            allowedExtensions: ['jpg', 'jpeg', 'png'],
          ),
          
          const SizedBox(height: 24),
          
          // Government Approval Documents Section (Optional)
          _buildDocumentSection(
            title: 'Government Approval Documents',
            subtitle: 'Upload any required government approval documents',
            initialFiles: widget.projectData.governmentApprovals ?? [],
            onFilesChanged: (files) {
              setState(() {
                widget.projectData.governmentApprovals = files;
                widget.onChanged(widget.projectData);
              });
            },
            maxFiles: 5,
            allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection({
    required String title,
    required String subtitle,
    required List<String>? initialFiles,
    required Function(List<String>?) onFilesChanged,
    required int maxFiles,
    required List<String> allowedExtensions,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (!isRequired) ...[
              const SizedBox(width: 8),
              const Text(
                '(Optional)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        PhotoPicker(
          initialPhotos: initialFiles,
          onPhotosChanged: onFilesChanged,
          maxPhotos: maxFiles,
          label: 'Add ${title.split(' ').first}',
        ),
      ],
    );
  }
}
