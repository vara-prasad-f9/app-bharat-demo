// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';


class CurvePainter extends CustomPainter {
  final Color color;

  const CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.85,
      size.width * 0.5, size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.65,
      size.width, size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  late final TextEditingController _phoneController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_phoneController.text.length != 10) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);
    
    // In a real app, you would call your API here
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;
    
    setState(() => _isLoading = false);
    
    // Navigate to OTP screen
    ref.read(authProvider.notifier).setPhoneNumber(_phoneController.text);
    if (mounted) {
      context.push('/otp-verify');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FB), // Light pink background
      body: Stack(
        children: [
          // Curved red header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.45,
            child: const CustomPaint(
              painter:  CurvePainter(color: Color(0xFFE63946)),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo Circle
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/logo.png"),
                      radius: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bharatplus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Login Form
          Positioned(
            top: screenHeight * 0.45,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        const Text('+91', style: TextStyle(fontSize: 16, color: Colors.black87)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: 'Enter 10-digit number',
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              // Update the controller with only digits
                              final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                              if (digitsOnly != value) {
                                _phoneController.value = TextEditingValue(
                                  text: digitsOnly,
                                  selection: TextSelection.collapsed(offset: digitsOnly.length),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE63946),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Send OTP', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFE63946),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'For demo purposes, use 1234567890 as phone number',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
