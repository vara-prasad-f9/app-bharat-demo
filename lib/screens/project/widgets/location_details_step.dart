// ignore_for_file: use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../models/project_model.dart';

class LocationDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const LocationDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LocationDetailsStepState createState() => _LocationDetailsStepState();
}

class _LocationDetailsStepState extends State<LocationDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingLocation = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')),
        );
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are permanently denied.'),
          ),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          widget.projectData.latitude = position.latitude;
          widget.projectData.longitude = position.longitude;
          widget.projectData.city = place.locality ?? '';
          widget.projectData.area = place.subLocality ?? '';
          widget.projectData.pincode = place.postalCode ?? '';
          widget.projectData.fullAddress = [
            if (place.street?.isNotEmpty ?? false) place.street,
            if (place.subLocality?.isNotEmpty ?? false) place.subLocality,
            if (place.locality?.isNotEmpty ?? false) place.locality,
            if (place.postalCode?.isNotEmpty ?? false) place.postalCode,
          ].where((s) => s != null).join(', ');
          
          widget.onChanged(widget.projectData);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
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
            Center(
              child: const Text(
                'Location Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'City/Town',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                  filled: true,
                  fillColor: Colors.grey,
                ),
                initialValue: 'Visakhapatnam',
                readOnly: true,
                onChanged: (value) {
                  widget.projectData.city = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'Area/Locality *',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.area ?? '',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Area/Locality is required' : null,
                onChanged: (value) {
                  widget.projectData.area = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'Landmark (Optional)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.landmark ?? '',
                onChanged: (value) {
                  widget.projectData.landmark = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                initialValue: widget.projectData.pincode ?? '',
                onChanged: (value) {
                  widget.projectData.pincode = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelText: 'location',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 13),
                  hintText: 'Enter location',
                ),
                initialValue: widget.projectData.fullAddress ?? '',
                onChanged: (value) {
                  widget.projectData.fullAddress = value;
                  widget.onChanged(widget.projectData);
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: _isLoadingLocation
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.location_on),
              label: Text(_isLoadingLocation
                  ? 'Getting Location...'
                  : 'Get Current Location'),
              onPressed: _isLoadingLocation ? null : _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            if (widget.projectData.fullAddress?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Location captured: ${widget.projectData.fullAddress}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
