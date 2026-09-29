import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupervisorPortalPage extends StatefulWidget {
  const SupervisorPortalPage({super.key});

  @override
  State<SupervisorPortalPage> createState() =>
      _SupervisorPortalPageState();
}

class _SupervisorPortalPageState
    extends State<SupervisorPortalPage> {
  // ----------------------------------------------------------
  // COLORS
  // ----------------------------------------------------------

  static const Color primaryBlue = Color(0xFF1769AA);
  static const Color darkBlue = Color(0xFF123B5D);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color green = Color(0xFF2E7D32);

  // ----------------------------------------------------------
  // FORM
  // ----------------------------------------------------------

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ----------------------------------------------------------
  // WORKER CONTROLLERS
  // ----------------------------------------------------------

  final TextEditingController _headcountController =
      TextEditingController();

  final TextEditingController _wageController =
      TextEditingController();

  // ----------------------------------------------------------
  // MATERIAL CONTROLLERS
  // ----------------------------------------------------------

  final TextEditingController _quantityController =
      TextEditingController();

  // ----------------------------------------------------------
  // WORKER DATA
  // ----------------------------------------------------------

  String? selectedWorkerCategory;

  final List<String> workerCategories = [
    'Masons',
    'Helpers',
    'Electricians',
    'Plumbers',
    'Carpenters',
    'Painters',
    'Steel Workers',
    'Other',
  ];

  double totalSalary = 0;

  // ----------------------------------------------------------
  // MATERIAL DATA
  // ----------------------------------------------------------

  String? selectedMaterial;

  final List<String> materialItems = [
    'Cement',
    'Sand',
    'Steel Rods',
    'Bricks',
    'Blue Metal',
    'M-Sand',
    'Wood',
    'Electrical Materials',
    'Plumbing Materials',
  ];

  final Map<String, String> materialUnits = {
    'Cement': 'Bags',
    'Sand': 'Tons',
    'Steel Rods': 'Kg',
    'Bricks': 'Numbers',
    'Blue Metal': 'Tons',
    'M-Sand': 'Tons',
    'Wood': 'Cubic Feet',
    'Electrical Materials': 'Numbers',
    'Plumbing Materials': 'Numbers',
  };

  String selectedUnit = '-';

  DateTime? requiredByDate;

  String urgencyLevel = 'Medium';

  // ----------------------------------------------------------
  // DISPOSE
  // ----------------------------------------------------------

  @override
  void dispose() {
    _headcountController.dispose();
    _wageController.dispose();
    _quantityController.dispose();

    super.dispose();
  }

  // ----------------------------------------------------------
  // SALARY CALCULATION
  // ----------------------------------------------------------

  void _calculateSalary() {
    final int headcount =
        int.tryParse(_headcountController.text.trim()) ?? 0;

    final double wage =
        double.tryParse(_wageController.text.trim()) ?? 0;

    setState(() {
      totalSalary = headcount * wage;
    });
  }

  // ----------------------------------------------------------
  // DATE PICKER
  // ----------------------------------------------------------

  Future<void> _selectRequiredDate() async {
    final DateTime today = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: requiredByDate ?? today,
      firstDate: today,
      lastDate: DateTime(
        today.year + 2,
      ),
    );

    if (pickedDate != null) {
      setState(() {
        requiredByDate = pickedDate;
      });
    }
  }

  // ----------------------------------------------------------
  // FORMAT DATE
  // ----------------------------------------------------------

  String _formatDate(DateTime date) {
    final String day =
        date.day.toString().padLeft(2, '0');

    final String month =
        date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  // ----------------------------------------------------------
  // VALIDATION
  // ----------------------------------------------------------

  String? _validateHeadcount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter total headcount';
    }

    final int? headcount = int.tryParse(value);

    if (headcount == null || headcount <= 0) {
      return 'Enter a valid headcount';
    }

    return null;
  }

  String? _validateWage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter daily wage';
    }

    final double? wage = double.tryParse(value);

    if (wage == null || wage <= 0) {
      return 'Enter a valid wage amount';
    }

    return null;
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter required quantity';
    }

    final double? quantity = double.tryParse(value);

    if (quantity == null || quantity <= 0) {
      return 'Enter a valid quantity';
    }

    return null;
  }

  // ----------------------------------------------------------
  // SUBMIT
  // ----------------------------------------------------------

  void _submitDailyUpdate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedWorkerCategory == null) {
      _showMessage(
        'Please select worker category',
        Colors.orange,
      );
      return;
    }

    if (selectedMaterial == null) {
      _showMessage(
        'Please select material item',
        Colors.orange,
      );
      return;
    }

    if (requiredByDate == null) {
      _showMessage(
        'Please select the material required date',
        Colors.orange,
      );
      return;
    }

    _showSuccessDialog();
  }

  void _showMessage(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // ----------------------------------------------------------
  // SUCCESS DIALOG
  // ----------------------------------------------------------

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 55,
          ),
          title: const Text(
            'Daily Update Submitted',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Worker details and material requirements '
            'have been submitted successfully.',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Supervisor Portal',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            Text(
              'Daily Site Update',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              _showLogoutDialog();
            },
            icon: const Icon(
              Icons.logout,
              color: darkBlue,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),

                const SizedBox(height: 25),

                _buildWorkerSalaryCard(),

                const SizedBox(height: 22),

                _buildMaterialRequirementCard(),

                const SizedBox(height: 28),

                _buildSubmitButton(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // WELCOME
  // ----------------------------------------------------------

  Widget _buildWelcomeSection() {
    return Row(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF6EC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.engineering_outlined,
            size: 34,
            color: green,
          ),
        ),

        const SizedBox(width: 15),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Site Update',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Update today\'s workforce and material requirements.',
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

  // ----------------------------------------------------------
  // WORKER & SALARY CARD
  // ----------------------------------------------------------

  Widget _buildWorkerSalaryCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            icon: Icons.groups_outlined,
            title: 'Worker & Salary',
            subtitle: 'Enter today\'s workforce details.',
          ),

          const SizedBox(height: 24),

          _buildLabel(
            'Worker Category',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: selectedWorkerCategory,
            decoration: _inputDecoration(
              hint: 'Select worker category',
              icon: Icons.engineering_outlined,
            ),
            items: workerCategories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedWorkerCategory = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select worker category';
              }

              return null;
            },
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Total Headcount',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _headcountController,
            validator: _validateHeadcount,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (_) {
              _calculateSalary();
            },
            decoration: _inputDecoration(
              hint: 'Enter number of workers',
              icon: Icons.groups_2_outlined,
            ),
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Daily Wage Rate per Worker',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _wageController,
            validator: _validateWage,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'),
              ),
            ],
            onChanged: (_) {
              _calculateSalary();
            },
            decoration: _inputDecoration(
              hint: 'Enter wage per worker',
              icon: Icons.currency_rupee,
            ),
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Total Salary Today',
          ),

          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF6EC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFCFE8D2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calculate_outlined,
                  color: green,
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'Calculated Salary',
                    style: TextStyle(
                      fontSize: 14,
                      color: darkBlue,
                    ),
                  ),
                ),

                Text(
                  '₹${totalSalary.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Total Salary = Headcount × Daily Wage Rate',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // MATERIAL CARD
  // ----------------------------------------------------------

  Widget _buildMaterialRequirementCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            icon: Icons.inventory_2_outlined,
            title: 'Material Requirement',
            subtitle: 'Enter materials required for the site.',
          ),

          const SizedBox(height: 24),

          _buildLabel(
            'Material Item',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: selectedMaterial,
            decoration: _inputDecoration(
              hint: 'Select material',
              icon: Icons.inventory_outlined,
            ),
            items: materialItems.map((material) {
              return DropdownMenuItem<String>(
                value: material,
                child: Text(
                  material,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedMaterial = value;

                if (value != null) {
                  selectedUnit =
                      materialUnits[value] ?? '-';
                } else {
                  selectedUnit = '-';
                }
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select material';
              }

              return null;
            },
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Quantity Required',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _quantityController,
            validator: _validateQuantity,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'),
              ),
            ],
            decoration: _inputDecoration(
              hint: 'Enter quantity',
              icon: Icons.numbers,
            ),
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Unit of Measurement',
          ),

          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFDDE3E8),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.straighten_outlined,
                  color: primaryBlue,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    selectedUnit == '-'
                        ? 'Select a material first'
                        : selectedUnit,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selectedUnit == '-'
                          ? FontWeight.normal
                          : FontWeight.w600,
                      color: selectedUnit == '-'
                          ? Colors.grey
                          : darkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Required By Date',
            requiredField: true,
          ),

          const SizedBox(height: 8),

          InkWell(
            onTap: _selectRequiredDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 17,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFDDE3E8),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: primaryBlue,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      requiredByDate == null
                          ? 'Select required date'
                          : _formatDate(requiredByDate!),
                      style: TextStyle(
                        fontSize: 14,
                        color: requiredByDate == null
                            ? Colors.grey
                            : darkBlue,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          _buildLabel(
            'Urgency Level',
            requiredField: true,
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildUrgencyOption(
                  label: 'Low',
                  icon: Icons.keyboard_arrow_down,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _buildUrgencyOption(
                  label: 'Medium',
                  icon: Icons.remove,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _buildUrgencyOption(
                  label: 'High',
                  icon: Icons.priority_high,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // URGENCY RADIO-LIKE OPTION
  // ----------------------------------------------------------

  Widget _buildUrgencyOption({
    required String label,
    required IconData icon,
  }) {
    final bool selected = urgencyLevel == label;

    Color selectedColor;

    switch (label) {
      case 'Low':
        selectedColor = Colors.green;
        break;

      case 'High':
        selectedColor = Colors.red;
        break;

      default:
        selectedColor = Colors.orange;
    }

    return InkWell(
      onTap: () {
        setState(() {
          urgencyLevel = label;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? selectedColor
                : const Color(0xFFDDE3E8),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected
                  ? selectedColor
                  : Colors.grey,
              size: 20,
            ),

            const SizedBox(height: 5),

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: selected
                    ? selectedColor
                    : darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SUBMIT BUTTON
  // ----------------------------------------------------------

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _submitDailyUpdate,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: const Icon(
          Icons.send_outlined,
        ),
        label: const Text(
          'Submit Daily Update',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CARD
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
  // SECTION HEADER
  // ----------------------------------------------------------

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryBlue,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
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
  // LABEL
  // ----------------------------------------------------------

  Widget _buildLabel(
    String text, {
    bool requiredField = false,
  }) {
    return Row(
      children: [
        Text(
          text,
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
      ],
    );
  }

  // ----------------------------------------------------------
  // INPUT STYLE
  // ----------------------------------------------------------

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
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

  // ----------------------------------------------------------
  // LOGOUT
  // ----------------------------------------------------------

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}