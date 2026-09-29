import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../owner/owner_registration_page.dart';
import '../supervisor/supervisor_portal_page.dart';

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

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();

  // Temporary OTP for development/testing.
  // Later this will be replaced with real OTP authentication.
  static const String demoOtp = '123456';

  static const Color primaryBlue = Color(0xFF1769AA);
  static const Color darkBlue = Color(0xFF123B5D);
  static const Color pageBackground = Color(0xFFF5F7FA);

  bool isVerifying = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // VERIFY OTP
  // ----------------------------------------------------------

  Future<void> _verifyOtp() async {
    final String enteredOtp = _otpController.text.trim();

    // Check whether OTP contains exactly 6 digits.
    if (enteredOtp.length != 6) {
      _showMessage(
        message: 'Please enter a valid 6-digit OTP',
        color: Colors.orange,
      );
      return;
    }

    setState(() {
      isVerifying = true;
    });

    // Small delay to simulate OTP verification.
    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isVerifying = false;
    });

    // Check the demo OTP.
    if (enteredOtp != demoOtp) {
      _showMessage(
        message: 'Invalid OTP. Please try again.',
        color: Colors.red,
      );
      return;
    }

    // OTP is correct.
    _showMessage(
      message: 'OTP verified successfully',
      color: Colors.green,
    );

    // Give the success message a short moment to display.
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    // ----------------------------------------------------------
    // ROLE-BASED NAVIGATION
    // ----------------------------------------------------------

    if (widget.role == 'Owner') {
      // First-time Owner flow:
      // OTP -> Owner Registration
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const OwnerRegistrationPage(),
        ),
        (route) => false,
      );
    } else if (widget.role == 'Supervisor') {
      // Supervisor flow:
      // OTP -> Supervisor Portal
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const SupervisorPortalPage(),
        ),
        (route) => false,
      );
    }
  }

  // ----------------------------------------------------------
  // RESEND OTP
  // ----------------------------------------------------------

  void _resendOtp() {
    // Temporary demo behavior.
    // Real SMS OTP will be connected later.

    _otpController.clear();

    _showMessage(
      message: 'OTP resent successfully. Demo OTP: 123456',
      color: primaryBlue,
    );
  }

  // ----------------------------------------------------------
  // SNACKBAR
  // ----------------------------------------------------------

  void _showMessage({
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // ----------------------------------------------------------
  // UI
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final bool isOwner = widget.role == 'Owner';

    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        backgroundColor: pageBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkBlue,
          ),
        ),

        title: const Text(
          'OTP Verification',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: darkBlue,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 25),

              // ROLE ICON
              Center(
                child: Container(
                  width: 95,
                  height: 95,

                  decoration: BoxDecoration(
                    color: isOwner
                        ? const Color(0xFFDDEAF5)
                        : const Color(0xFFEAF6EC),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    isOwner
                        ? Icons.business_center_outlined
                        : Icons.engineering_outlined,
                    size: 46,
                    color: isOwner
                        ? primaryBlue
                        : const Color(0xFF2E7D32),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Center(
                child: Text(
                  '${widget.role} Verification',
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  'Enter the 6-digit OTP sent to\n'
                  '+91 ${widget.phoneNumber}',
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // DEVELOPMENT OTP INFO
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                  ),

                  child: const Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Colors.green,
                      ),

                      SizedBox(width: 8),

                      Text(
                        'Demo OTP: 123456',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkBlue,
                ),
              ),

              const SizedBox(height: 10),

              // OTP INPUT
              TextField(
                controller: _otpController,

                keyboardType: TextInputType.number,

                maxLength: 6,

                textAlign: TextAlign.center,

                autofocus: true,

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 10,
                  color: darkBlue,
                ),

                decoration: InputDecoration(
                  counterText: '',

                  hintText: '------',

                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    letterSpacing: 10,
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 19,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),

                    borderSide: const BorderSide(
                      color: Color(0xFFDDE3E8),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),

                    borderSide: const BorderSide(
                      color: primaryBlue,
                      width: 1.5,
                    ),
                  ),
                ),

                // Automatically verify when all 6 digits
                // have been entered.
                onSubmitted: (_) {
                  _verifyOtp();
                },
              ),

              const SizedBox(height: 28),

              // VERIFY / LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton(
                  onPressed:
                      isVerifying ? null : _verifyOtp,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,

                    disabledBackgroundColor:
                        primaryBlue.withValues(alpha: 0.6),

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: isVerifying
                      ? const SizedBox(
                          width: 24,
                          height: 24,

                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login as ${widget.role}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 22),

              // RESEND OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    "Didn't receive the OTP?",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  TextButton(
                    onPressed: _resendOtp,

                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  isOwner
                      ? 'After verification, you can complete your Owner registration.'
                      : 'After verification, you will enter the Supervisor portal.',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}