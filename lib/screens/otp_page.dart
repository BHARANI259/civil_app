import 'package:flutter/material.dart';
import 'owner_form.dart';

class OtpPage extends StatefulWidget {
  const OtpPage();

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otp = TextEditingController();    //helps get the text typed in the OTP box
  String error = '';

  void verifyOtp() {
    if (otp.text == '123456') {
      Navigator.pushReplacement(     // if otp crt naa,otp page to next page
        context,
        MaterialPageRoute(builder: (_) => const OwnerForm()),   // next page is owner page
      );
    } else {
      setState(() => error = 'Enter correct OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      backgroundColor: Colors.grey[100],
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
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
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