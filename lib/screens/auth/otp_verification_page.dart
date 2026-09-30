import 'package:flutter/material.dart';
import '../owner/owner_registration_page.dart';
import '../supervisor/supervisor_dashboard_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String role;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.role,
  });

  @override
  State<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState
    extends State<OtpVerificationPage> {
  final otp = TextEditingController();
  String error = '';

  void verifyOtp() {
    if (otp.text != '123456') {
      setState(() => error = 'Enter correct OTP');
      return;
    }

    if (widget.role == 'Owner') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OwnerRegistrationPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SupervisorDashboardPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text('Your OTP is 123456'),

            const SizedBox(height: 25),

            TextField(
              controller: otp,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),

            if (error.isNotEmpty)
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: verifyOtp,
                child: const Text('Verify OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}