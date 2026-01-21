// ignore_for_file: unused_import

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class DocumentationStep extends StatefulWidget {
  const DocumentationStep({super.key});

  @override
  State<DocumentationStep> createState() => _DocumentationStepState();
}

class _DocumentationStepState extends State<DocumentationStep> {
  final List<Map<String, dynamic>> _documents = [];
  final List<Map<String, dynamic>> _sitePhotos = [];
  final List<Map<String, dynamic>> _approvalDocuments = [];

  Future<void> _pickFiles(
      List<Map<String, dynamic>> list, List<String>? allowedExtensions) async {
    // In a real app, you would use file_picker or image_picker here
    // For now, we'll simulate adding a file
    setState(() {
      list.add({
        'name': 'example_file.pdf',
        'path': '/path/to/example_file.pdf',
        'size': 1024 * 1024, // 1MB
        'extension': 'pdf',
        'uploaded': false,
      });
    });
    
    // Show a message that this is a demo
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File picker would open here in a real app'),
        ),
      );
    }
  }

  void _removeFile(List<Map<String, dynamic>> list, int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  Widget _buildFileList(
      String title, List<Map<String, dynamic>> files, Function() onAddPressed) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            if (files.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No files added yet'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return ListTile(
                    leading: _getFileIcon(file['extension']),
                    title: Text(
                      file['name'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${_formatFileSize(file['size'])} • ${file['uploaded'] ? 'Uploaded' : 'Pending'}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeFile(files, index),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _getFileIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return const Icon(Icons.image, color: Colors.blue);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description, color: Colors.blue);
      case 'xls':
      case 'xlsx':
        return const Icon(Icons.table_chart, color: Colors.green);
      default:
        return const Icon(Icons.insert_drive_file);
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Documentation & Media',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildFileList(
            'Site Plan / Blueprints (PDF/Image)',
            _documents,
            () => _pickFiles(_documents, ['pdf', 'jpg', 'jpeg', 'png']),
          ),
          _buildFileList(
            'Initial Site Photos',
            _sitePhotos,
            () => _pickFiles(_sitePhotos, ['jpg', 'jpeg', 'png']),
          ),
          _buildFileList(
            'Government Approval Documents (Optional)',
            _approvalDocuments,
            () => _pickFiles(_approvalDocuments, ['pdf', 'jpg', 'jpeg', 'png']),
          ),
          const SizedBox(height: 16),
          const Text(
            'Note:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const Text(
            '• Maximum file size: 10MB per file\n'
            '• Supported formats: PDF, JPG, JPEG, PNG\n'
            '• Site plan/blueprint is required before status update',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
