import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class CustomNumberPad extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onDone;

  const CustomNumberPad({
    super.key,
    required this.controller,
    this.onDone,
  });

  void _onNumberTap(String number) {
    if (controller.text.length < 10) {
      controller.text += number;
    }
  }

  void _onBackspace() {
    if (controller.text.isNotEmpty) {
      controller.text = controller.text.substring(0, controller.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phone number display
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
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.none,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
        ),
        
        // Custom numeric keypad
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 12, // 0-9, backspace, and done
          itemBuilder: (context, index) {
            if (index < 9) {
              return _buildNumberButton((index + 1).toString());
            } else if (index == 9) {
              return _buildNumberButton('*');
            } else if (index == 10) {
              return _buildNumberButton('0');
            } else {
              return _buildActionButton(
                icon: Icons.backspace_outlined,
                onTap: _onBackspace,
              );
            }
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onDone,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE63946),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Send OTP', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _onNumberTap(number),
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Icon(icon, size: 28, color: Colors.black87),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  const CurvePainter();
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE63946)
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
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

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
            child: CustomPaint(
              painter: const CurvePainter(),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
            top: screenHeight * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomNumberPad(
                    controller: _phoneController,
                    onDone: _isLoading ? null : _sendOtp,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
