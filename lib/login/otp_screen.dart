import 'package:bodmas_education/login/user_info_sheet.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_text_field.dart';


class OTPScreen extends StatelessWidget {

  final String phone;

  const OTPScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {

    TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Text("OTP sent to $phone"),

            const SizedBox(height: 20),

            CustomTextField(
              controller: otpController,
              label: "Mobile Number",
              hint: "Enter your mobile number",
              icon: Icons.password,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Green background
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                child: const Text("Verify OTP"),
                onPressed: () {

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return const UserInfoSheet();
                    },
                  );

                },
              ),
            )

          ],
        ),
      ),
    );
  }
}

