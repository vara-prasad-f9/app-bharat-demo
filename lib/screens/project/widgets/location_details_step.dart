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
          widget.projectData.country = place.country ?? 'India';
          widget.projectData.state = place.administrativeArea ?? '';
          widget.projectData.district = place.subAdministrativeArea ?? '';
          widget.projectData.city = place.locality ?? '';
          widget.projectData.area = place.subLocality ?? '';
          widget.projectData.pincode = place.postalCode ?? '';
          widget.projectData.fullAddress = [
            if (place.street?.isNotEmpty ?? false) place.street,
            if (place.subLocality?.isNotEmpty ?? false) place.subLocality,
            if (place.locality?.isNotEmpty ?? false) place.locality,
            if (place.administrativeArea?.isNotEmpty ?? false)
              place.administrativeArea,
            if (place.postalCode?.isNotEmpty ?? false) place.postalCode,
            if (place.country?.isNotEmpty ?? false) place.country,
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
            const Text(
              'Location Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.country,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'State *',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.state,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'State is required' : null,
              onChanged: (value) {
                widget.projectData.state = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'District',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.district ?? '',
              onChanged: (value) {
                widget.projectData.district = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'City/Town *',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.city ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'City/Town is required' : null,
              onChanged: (value) {
                widget.projectData.city = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Area/Locality *',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.area ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Area/Locality is required' : null,
              onChanged: (value) {
                widget.projectData.area = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Landmark (Optional)',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.projectData.landmark ?? '',
              onChanged: (value) {
                widget.projectData.landmark = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Pincode *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              initialValue: widget.projectData.pincode ?? '',
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Pincode is required';
                if (value!.length != 6 || int.tryParse(value) == null) {
                  return 'Enter a valid 6-digit pincode';
                }
                return null;
              },
              onChanged: (value) {
                widget.projectData.pincode = value;
                widget.onChanged(widget.projectData);
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
              initialValue: widget.projectData.fullAddress ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Full address is required' : null,
              onChanged: (value) {
                widget.projectData.fullAddress = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'GPS Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: widget.projectData.latitude?.toStringAsFixed(6) ??
                          'Not set',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: widget.projectData.longitude?.toStringAsFixed(6) ??
                          'Not set',
                    ),
                  ),
                ),
              ],
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
            if (widget.projectData.latitude != null &&
                widget.projectData.longitude != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Location captured: ${widget.projectData.latitude!.toStringAsFixed(6)}, ${widget.projectData.longitude!.toStringAsFixed(6)}',
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
