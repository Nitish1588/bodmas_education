import 'package:bodmas_education/login/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../widgets/app_snackbar.dart';
import 'widgets/custom_text_field.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
  }

  @override
  void dispose() {

    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [


            const SizedBox(height: 20),
            CustomTextField(
              controller: phoneController,
              label: "Mobile Number",
              hint: "Enter your mobile number",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                  onPressed: () async {
                    String phone = phoneController.text.trim();
                    if (phone.isEmpty) {
                      AppSnackBar.show(
                        context,
                        message: "Phone number is required",
                        type: SnackBarType.error,
                      );
                      return;
                    } else if (phone.length != 10) {
                      AppSnackBar.show(
                        context,
                        message: "Enter valid 10-digit phone number",
                        type: SnackBarType.warning,
                      );
                      return;
                    }
                    bool success = await AuthService.sendOtp(phoneController.text);

                    if (success) {

                      AppSnackBar.show(
                      context,
                      message: "OTP sent successfully to your Mobile No",
                      type: SnackBarType.success,
                    );


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OTPScreen(phone: phoneController.text),
                        ),
                      );
                    } else {
                      AppSnackBar.show(
                        context,
                        message: "Failed to send OTP",
                        type:SnackBarType.error,
                      );
                    }
                  },
                child: const Text("Send OTP"),
              ),
            )

          ],
        ),
      ),
    );
  }
}