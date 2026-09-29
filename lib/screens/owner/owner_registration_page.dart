import 'package:flutter/material.dart';

import 'supervisor_registration_page.dart';

class OwnerRegistrationPage extends StatefulWidget {
  const OwnerRegistrationPage({super.key});

  @override
  State<OwnerRegistrationPage> createState() =>
      _OwnerRegistrationPageState();
}

class _OwnerRegistrationPageState
    extends State<OwnerRegistrationPage> {
  // ----------------------------------------------------------
  // FORM KEYS
  // ----------------------------------------------------------

  final GlobalKey<FormState> _ownerFormKey =
      GlobalKey<FormState>();

  final GlobalKey<FormState> _projectFormKey =
      GlobalKey<FormState>();

  // ----------------------------------------------------------
  // CONTROLLERS
  // ----------------------------------------------------------

  final TextEditingController _fullNameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _companyNameController =
      TextEditingController();

  final TextEditingController _projectNameController =
      TextEditingController();

  final TextEditingController _siteAddressController =
      TextEditingController();

  // ----------------------------------------------------------
  // COLORS
  // ----------------------------------------------------------

  static const Color primaryBlue = Color(0xFF1769AA);
  static const Color darkBlue = Color(0xFF123B5D);
  static const Color pageBackground = Color(0xFFF5F7FA);

  // ----------------------------------------------------------
  // STATE
  // ----------------------------------------------------------

  int currentStep = 0;

  String? selectedProjectType;

  bool isSaving = false;

  final List<String> projectTypes = [
    'Residential (House/Villa)',
    'Commercial (Shop/Office)',
    'Renovation / Remodelling',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _companyNameController.dispose();
    _projectNameController.dispose();
    _siteAddressController.dispose();

    super.dispose();
  }

  // ----------------------------------------------------------
  // VALIDATION
  // ----------------------------------------------------------

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the owner name';
    }

    if (value.trim().length < 3) {
      return 'Name must contain at least 3 characters';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    // Email is optional.
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final RegExp emailPattern = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validateProjectName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the project name';
    }

    return null;
  }

  String? _validateSiteAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the site address';
    }

    return null;
  }

  // ----------------------------------------------------------
  // STEP NAVIGATION
  // ----------------------------------------------------------

  void _goToProjectDetails() {
    if (!_ownerFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      currentStep = 1;
    });
  }

  void _goBackToOwnerDetails() {
    setState(() {
      currentStep = 0;
    });
  }

  // ----------------------------------------------------------
  // PIN LOCATION
  // ----------------------------------------------------------

  void _pinLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'GPS / Map location selection will be integrated next.',
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // COMPLETE REGISTRATION
  // ----------------------------------------------------------

  Future<void> _completeRegistration() async {
    if (!_projectFormKey.currentState!.validate()) {
      return;
    }

    if (selectedProjectType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select the project type',
          ),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    // Temporary simulated save.
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isSaving = false;
    });

    _showRegistrationSuccess();
  }

  void _showRegistrationSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            size: 58,
            color: Colors.green,
          ),

          title: const Text(
            'Owner Registered',
            textAlign: TextAlign.center,
          ),

          content: Text(
            '${_fullNameController.text.trim()} has been registered successfully.\n\n'
            'Project: ${_projectNameController.text.trim()}\n'
            'Type: $selectedProjectType',
            textAlign: TextAlign.center,
          ),

          actionsAlignment: MainAxisAlignment.center,

          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SupervisorRegistrationPage(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),

              icon: const Icon(
                Icons.person_add_alt_1,
              ),

              label: const Text(
                'Add Supervisor',
              ),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // MAIN UI
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Owner Registration',
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

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _buildHeader(),

              const SizedBox(height: 25),

              _buildProgressIndicator(),

              const SizedBox(height: 25),

              if (currentStep == 0)
                _buildOwnerProfileStep()
              else
                _buildProjectProfileStep(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER
  // ----------------------------------------------------------

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,

          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FD),
            borderRadius: BorderRadius.circular(16),
          ),

          child: const Icon(
            Icons.business_center_outlined,
            size: 34,
            color: primaryBlue,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                currentStep == 0
                    ? 'Owner Profile'
                    : 'Project Profile',

                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                currentStep == 0
                    ? 'Enter the basic information of the owner.'
                    : 'Enter the details of the construction project.',

                style: const TextStyle(
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

  // ----------------------------------------------------------
  // PROGRESS INDICATOR
  // ----------------------------------------------------------

  Widget _buildProgressIndicator() {
    final double progress =
        currentStep == 0 ? 0.5 : 1.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [
            const Text(
              'Registration Progress',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkBlue,
              ),
            ),

            Text(
              'Step ${currentStep + 1} of 2',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),

          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor:
                const Color(0xFFDCE5ED),

            valueColor:
                const AlwaysStoppedAnimation<Color>(
              primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // STEP 1
  // ----------------------------------------------------------

  Widget _buildOwnerProfileStep() {
    return Form(
      key: _ownerFormKey,

      child: _buildCard(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Full Name',
              requiredField: true,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _fullNameController,
              validator: _validateName,
              keyboardType: TextInputType.name,
              textCapitalization:
                  TextCapitalization.words,

              decoration: _inputDecoration(
                hint: 'Enter full name',
                icon: Icons.person_outline,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Email Address',
              optional: true,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _emailController,
              validator: _validateEmail,
              keyboardType:
                  TextInputType.emailAddress,

              decoration: _inputDecoration(
                hint: 'Enter email address',
                icon: Icons.email_outlined,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Used for weekly PDF progress reports or invoices.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Company Name',
              optional: true,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _companyNameController,
              textCapitalization:
                  TextCapitalization.words,

              decoration: _inputDecoration(
                hint:
                    'Enter company name if applicable',
                icon: Icons.apartment_outlined,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Optional for commercial developers.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                onPressed: _goToProjectDetails,

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                child: const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    Text(
                      'Continue to Project Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width: 8),

                    Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // STEP 2
  // ----------------------------------------------------------

  Widget _buildProjectProfileStep() {
    return Form(
      key: _projectFormKey,

      child: _buildCard(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              'Site Information',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Project Name',
              requiredField: true,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _projectNameController,
              validator: _validateProjectName,
              textCapitalization:
                  TextCapitalization.words,

              decoration: _inputDecoration(
                hint: 'e.g. My Dream Home',
                icon: Icons.home_work_outlined,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Project Type',
              requiredField: true,
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedProjectType,

              decoration: _inputDecoration(
                hint: 'Select project type',
                icon: Icons.category_outlined,
              ),

              items: projectTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedProjectType = value;
                });
              },

              validator: (value) {
                if (value == null) {
                  return 'Please select project type';
                }

                return null;
              },
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Site Address',
              requiredField: true,
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _siteAddressController,
              validator: _validateSiteAddress,
              keyboardType:
                  TextInputType.streetAddress,
              textCapitalization:
                  TextCapitalization.sentences,
              maxLines: 4,

              decoration: _inputDecoration(
                hint:
                    'Enter complete construction site address',
                icon: Icons.location_on_outlined,
              ).copyWith(
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 22),

            _buildLabel(
              'Pin Location',
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: _pinLocation,

              style: OutlinedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, 54),

                foregroundColor: primaryBlue,

                side: const BorderSide(
                  color: primaryBlue,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              icon: const Icon(
                Icons.map_outlined,
              ),

              label: const Text(
                'Pin Site Location on Map',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        _goBackToOwnerDetails,

                    style: OutlinedButton.styleFrom(
                      minimumSize:
                          const Size(0, 54),

                      foregroundColor: primaryBlue,

                      side: const BorderSide(
                        color: primaryBlue,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Back',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  flex: 2,

                  child: ElevatedButton(
                    onPressed: isSaving
                        ? null
                        : _completeRegistration,

                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size(0, 54),

                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),

                    child: isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,

                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Complete Registration',
                            textAlign:
                                TextAlign.center,

                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // COMMON CARD
  // ----------------------------------------------------------

  Widget _buildCard({
    required Widget child,
  }) {
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
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: child,
    );
  }

  // ----------------------------------------------------------
  // LABEL
  // ----------------------------------------------------------

  Widget _buildLabel(
    String label, {
    bool requiredField = false,
    bool optional = false,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: darkBlue,
          ),
        ),

        if (requiredField)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.red,
            ),
          ),

        if (optional)
          const Text(
            '  (Optional)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
      ],
    );
  }

  // ----------------------------------------------------------
  // INPUT DECORATION
  // ----------------------------------------------------------

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
}