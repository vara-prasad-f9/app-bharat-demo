import 'package:flutter/material.dart';

class LocationDetailsStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const LocationDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  State<LocationDetailsStep> createState() => _LocationDetailsStepState();
}

class _LocationDetailsStepState extends State<LocationDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initialData if provided
    if (widget.initialData != null) {
      _addressController.text = widget.initialData!['address'] ?? '';
      _cityController.text = widget.initialData!['city'] ?? '';
      _stateController.text = widget.initialData!['state'] ?? '';
      _countryController.text = widget.initialData!['country'] ?? '';
      _pincodeController.text = widget.initialData!['pincode'] ?? '';
      _landmarkController.text = widget.initialData!['landmark'] ?? '';
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSaved({
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'country': _countryController.text,
        'pincode': _pincodeController.text,
        'landmark': _landmarkController.text,
      });
    }
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
            'Location Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Country',
              hintText: 'India',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            initialValue: 'India',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'State *',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter state';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'District',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'City/Town *',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter city/town';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Pincode *',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter pincode';
              }
              if (value.length != 6) {
                return 'Please enter a valid 6-digit pincode';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Site Address *',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter site address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'GPS Location',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on),
                  ),
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on),
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
         
            },
            icon: const Icon(Icons.my_location),
            label: const Text('Get Current Location'),
          ),
        ],
        ),
      ),
    );
  }
}
