import 'package:flutter/material.dart';
import 'widgets/custom_text_field.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController phoneController = TextEditingController();

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
                  backgroundColor: const Color(0xFF4CAF50), // Green background
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OTPScreen(phone: phoneController.text)),
                  );
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