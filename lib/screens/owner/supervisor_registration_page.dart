import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupervisorRegistrationPage extends StatefulWidget {
  const SupervisorRegistrationPage({super.key});

  @override
  State<SupervisorRegistrationPage> createState() =>
      _SupervisorRegistrationPageState();
}

class _SupervisorRegistrationPageState
    extends State<SupervisorRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _mobileController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _locationController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  static const Color primaryBlue = Color(0xFF1769AA);
  static const Color darkBlue = Color(0xFF123B5D);
  static const Color pageBackground = Color(0xFFF5F7FA);

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter supervisor name';
    }

    if (value.trim().length < 3) {
      return 'Name must contain at least 3 characters';
    }

    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter mobile number';
    }

    if (value.trim().length != 10) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email address';
    }

    final RegExp emailPattern = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter site or location';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password';
    }

    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm the password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  String _generateSupervisorId() {
    final String timestamp =
        DateTime.now().millisecondsSinceEpoch.toString();

    final String lastSix =
        timestamp.substring(timestamp.length - 6);

    return 'SUP-$lastSix';
  }

  Future<void> _createSupervisor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isCreating = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isCreating = false;
    });

    final String supervisorId = _generateSupervisorId();
    final String password = _passwordController.text;

    _showCredentialsDialog(
      supervisorId: supervisorId,
      password: password,
    );
  }

  void _showCredentialsDialog({
    required String supervisorId,
    required String password,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            size: 55,
            color: Colors.green,
          ),

          title: const Text(
            'Supervisor Created',
            textAlign: TextAlign.center,
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Supervisor details were created successfully.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFDDE3E8),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Supervisor ID',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    SelectableText(
                      supervisorId,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    SelectableText(
                      password,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Share this Supervisor ID and password with the supervisor.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          actionsAlignment: MainAxisAlignment.center,

          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'Supervisor ID: $supervisorId\nPassword: $password',
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Credentials copied',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.copy_outlined,
              ),
              label: const Text(
                'Copy',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),

              child: const Text(
                'Done',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        title: const Text(
          'Add Supervisor',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: darkBlue,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _buildHeader(),

                const SizedBox(height: 25),

                _buildProgress(),

                const SizedBox(height: 25),

                _buildSupervisorDetailsCard(),

                const SizedBox(height: 25),

                _buildCreateButton(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,

          decoration: BoxDecoration(
            color: const Color(0xFFEAF6EC),
            borderRadius: BorderRadius.circular(16),
          ),

          child: const Icon(
            Icons.engineering_outlined,
            size: 35,
            color: Color(0xFF2E7D32),
          ),
        ),

        const SizedBox(width: 15),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Supervisor Details',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),

              SizedBox(height: 4),

              Text(
                'Add the supervisor who will manage daily site activities.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Registration Progress',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkBlue,
              ),
            ),

            Text(
              'Step 2 of 2',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),

          child: const LinearProgressIndicator(
            value: 1,
            minHeight: 7,
            backgroundColor: Color(0xFFDCE5ED),
            valueColor: AlwaysStoppedAnimation<Color>(
              primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupervisorDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE1E7ED),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Basic Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Full Name'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _nameController,
            validator: _validateName,
            textCapitalization: TextCapitalization.words,

            decoration: _inputDecoration(
              hint: 'Enter supervisor name',
              icon: Icons.person_outline,
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Mobile Number'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _mobileController,
            validator: _validateMobile,
            keyboardType: TextInputType.phone,
            maxLength: 10,

            decoration: _inputDecoration(
              hint: 'Enter mobile number',
              icon: Icons.phone_android,
            ).copyWith(
              counterText: '',
              prefixText: '+91  ',
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Email Address'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,

            decoration: _inputDecoration(
              hint: 'Enter email address',
              icon: Icons.email_outlined,
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Site / Location'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _locationController,
            validator: _validateLocation,
            textCapitalization: TextCapitalization.words,

            decoration: _inputDecoration(
              hint: 'Enter assigned site or location',
              icon: Icons.location_on_outlined,
            ),
          ),

          const SizedBox(height: 25),

          const Divider(),

          const SizedBox(height: 15),

          const Text(
            'Login Credentials',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Create a password for the supervisor. The Supervisor ID will be generated automatically.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Password'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _passwordController,
            obscureText: obscurePassword,
            validator: _validatePassword,

            decoration: _inputDecoration(
              hint: 'Create supervisor password',
              icon: Icons.lock_outline,
            ).copyWith(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },

                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          _buildLabel('Confirm Password'),

          const SizedBox(height: 8),

          TextFormField(
            controller: _confirmPasswordController,
            obscureText: obscureConfirmPassword,
            validator: _validateConfirmPassword,

            decoration: _inputDecoration(
              hint: 'Re-enter supervisor password',
              icon: Icons.lock_outline,
            ).copyWith(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword =
                        !obscureConfirmPassword;
                  });
                },

                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,

      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: darkBlue,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),

      prefixIcon: Icon(
        icon,
        color: primaryBlue,
      ),

      filled: true,
      fillColor: const Color(0xFFF9FAFB),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 16,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDDE3E8),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryBlue,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton.icon(
        onPressed: isCreating
            ? null
            : _createSupervisor,

        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        icon: isCreating
            ? const SizedBox.shrink()
            : const Icon(
                Icons.person_add_alt_1,
              ),

        label: isCreating
            ? const SizedBox(
                width: 23,
                height: 23,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                'Create Supervisor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}