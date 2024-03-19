import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import '../../../data/utility/urls.dart';
import '../../widgets/background_wallpaper.dart';
import '../../widgets/snack_bar_message.dart';
import 'pin_verification_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVerificationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Minimum length password 8 characters with Letters and Number combination',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your New Password';
                      }
                      if (value!.length <= 6) {
                        return 'Password must be more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Confirm Password';
                      } else if (value != _passwordTEController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _passwordVerificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()){
                                await _setNewPasswordVerification();
                              }
                            },
                            child: const Text("Confirm")),
                      )),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have Account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setNewPasswordVerification() async {
    _passwordVerificationInProgress = true;
    setState(() {});

    final userNewPassword = _passwordTEController.text;
    final userEmail = widget.email;
    final userOtp = widget.otp;

    Map<String, dynamic> inputParams = {
      "email": userEmail,
      "OTP": userOtp,
      "password": userNewPassword,
    };

    final response = await NetworkCaller.postRequest(Urls.resetPassword, inputParams);

    _passwordVerificationInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, "Password Reset! Please Sign in");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen() ), (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Password Reset Failed! Try again', true);
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
