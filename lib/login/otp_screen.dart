import 'package:flutter/material.dart';

import '../home/home_screen.dart';


class OTPScreen extends StatelessWidget {

  final String phone;

  const OTPScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {

    TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification",style: TextStyle(color: Color(0xFFFFFFFF),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Text("OTP sent to $phone"),

            const SizedBox(height: 20),


            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                labelStyle: TextStyle(color: Color(0xFF333333)),
                //hintText: "Enter OTP",
                //prefixIcon: Icon(Icons.confirmation_number, color: Color(0xFF333333)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF333333), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF0B3E11), width: 2),
                ),
              ),
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

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
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