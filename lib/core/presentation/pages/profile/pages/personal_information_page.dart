
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../../auth/widgets/fashion_background.dart';


class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState
    extends State<PersonalInformationPage> {
  static const Color espresso = Color(0xFF29211F);
  static const Color berry = Color(0xFF91475B);
  static const Color dustyRose = Color(0xFFD7AAA5);
  static const Color ivory = Color(0xFFFFFAF5);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isEditing = false;
  String _selectedGender = 'Female';

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthCubit>().state;

    _nameController.text = state.userName ?? '';
    _ageController.text = state.userAge?.toString() ?? '';
    _selectedGender = state.userGender ?? 'Female';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _startEditing(AuthState state) {
    setState(() {
      _nameController.text = state.userName ?? '';
      _ageController.text = state.userAge?.toString() ?? '';
      _selectedGender = state.userGender ?? 'Female';
      _isEditing = true;
    });
  }

  Future<void> _saveChanges() async {
    _dismissKeyboard();

    if (!_formKey.currentState!.validate()) return;

    final ageText = _ageController.text.trim();
    final int? age =
    ageText.isEmpty ? null : int.tryParse(ageText);

    await context.read<AuthCubit>().updatePersonalInfo(
      name: _nameController.text.trim(),
      gender: _selectedGender,
      age: age,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated &&
            _isEditing) {
          setState(() => _isEditing = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: berry,
            ),
          );
        }

        if (state.status == AuthStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSaving = state.status == AuthStatus.loading;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: _dismissKeyboard,
            behavior: HitTestBehavior.translucent,
            child: Material(
              color: Colors.transparent,
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  decoration: TextDecoration.none,
                ),
                child: FashionBackground(
                  overlayOpacity: 0.90,
                  child: SafeArea(
                    child: Column(
                      children: [
                        _buildHeader(),
                        Expanded(
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              18,
                              20,
                              35,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  _buildIntro(),
                                  const SizedBox(height: 22),

                                  if (_isEditing) ...[
                                    _buildTextField(
                                      title: 'FULL NAME',
                                      controller: _nameController,
                                      icon: Icons.person_outline_rounded,
                                      hint: 'Enter your full name',
                                    ),
                                    const SizedBox(height: 17),

                                    _buildGenderSelector(),
                                    const SizedBox(height: 17),

                                    _buildTextField(
                                      title: 'AGE (OPTIONAL)',
                                      controller: _ageController,
                                      icon: Icons.cake_outlined,
                                      hint: 'Enter your age',
                                      isAge: true,
                                    ),
                                    const SizedBox(height: 17),

                                    _buildInfoCard(
                                      title: 'EMAIL ADDRESS',
                                      value: state.userEmail ?? '',
                                      icon: Icons.email_outlined,
                                      locked: true,
                                    ),
                                    const SizedBox(height: 25),

                                    _buildSaveButton(isSaving),
                                    const SizedBox(height: 12),

                                    _buildCancelButton(state),
                                  ] else ...[
                                    _buildInfoCard(
                                      title: 'FULL NAME',
                                      value: state.userName ?? 'User',
                                      icon: Icons.person_outline_rounded,
                                    ),
                                    _buildInfoCard(
                                      title: 'EMAIL ADDRESS',
                                      value: state.userEmail ?? '',
                                      icon: Icons.email_outlined,
                                      locked: true,
                                    ),
                                    _buildInfoCard(
                                      title: 'GENDER',
                                      value:
                                      state.userGender ?? 'Not selected',
                                      icon: Icons.wc_rounded,
                                    ),
                                    _buildInfoCard(
                                      title: 'AGE',
                                      value:
                                      state.userAge?.toString() ??
                                          'Not added',
                                      icon: Icons.cake_outlined,
                                    ),
                                    const SizedBox(height: 12),

                                    _buildEditButton(
                                          () => _startEditing(state),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _dismissKeyboard();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: espresso,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Personal Information',
              style: TextStyle(
                color: espresso,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (!_isEditing)
            IconButton(
              onPressed: () => _startEditing(
                context.read<AuthCubit>().state,
              ),
              icon: const Icon(
                Icons.edit_outlined,
                color: berry,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT YOU',
          style: TextStyle(
            color: berry,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your personal details',
          style: TextStyle(
            color: espresso,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    bool locked = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          _iconBox(icon),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: berry.withValues(alpha: 0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  value.isEmpty ? 'Not available' : value,
                  style: const TextStyle(
                    color: espresso,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            locked
                ? Icons.lock_outline_rounded
                : Icons.check_circle_rounded,
            color: dustyRose,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isAge = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: berry,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            keyboardType:
            isAge ? TextInputType.number : TextInputType.name,
            style: const TextStyle(
              color: espresso,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: berry, size: 21),
              hintText: hint,
              hintStyle: TextStyle(
                color: espresso.withValues(alpha: 0.4),
                fontSize: 13,
                decoration: TextDecoration.none,
              ),
              filled: true,
              fillColor: const Color(0xFFF7EFEC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: dustyRose.withValues(alpha: 0.35),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: berry,
                  width: 1.4,
                ),
              ),
            ),
            validator: (value) {
              final text = value?.trim() ?? '';

              if (!isAge && text.isEmpty) {
                return 'Please enter your name.';
              }

              if (isAge && text.isNotEmpty) {
                final age = int.tryParse(text);

                if (age == null || age < 1 || age > 120) {
                  return 'Enter a valid age between 1 and 120.';
                }
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GENDER',
            style: TextStyle(
              color: berry,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              _genderOption('Female', Icons.female_rounded),
              const SizedBox(width: 12),
              _genderOption('Male', Icons.male_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderOption(String gender, IconData icon) {
    final selected = _selectedGender == gender;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _selectedGender = gender);
        },
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: selected ? berry : const Color(0xFFF7EFEC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? berry
                  : dustyRose.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? ivory : berry,
                size: 25,
              ),
              const SizedBox(height: 5),
              Text(
                gender,
                style: TextStyle(
                  color: selected ? ivory : espresso,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(bool isSaving) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: ElevatedButton(
        onPressed: isSaving ? null : _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: berry,
          foregroundColor: ivory,
          disabledBackgroundColor: dustyRose,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: isSaving
            ? const SizedBox(
          width: 21,
          height: 21,
          child: CircularProgressIndicator(
            color: ivory,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'SAVE CHANGES',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(AuthState state) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: () {
          _dismissKeyboard();

          setState(() {
            _isEditing = false;
            _nameController.text = state.userName ?? '';
            _ageController.text = state.userAge?.toString() ?? '';
            _selectedGender = state.userGender ?? 'Female';
          });
        },
        child: const Text(
          'CANCEL',
          style: TextStyle(
            color: berry,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton(VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: const Text(
          'EDIT INFORMATION',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: berry,
          foregroundColor: ivory,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: dustyRose.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: berry, size: 23),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: ivory.withValues(alpha: 0.96),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: dustyRose.withValues(alpha: 0.35),
      ),
      boxShadow: [
        BoxShadow(
          color: espresso.withValues(alpha: 0.035),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}