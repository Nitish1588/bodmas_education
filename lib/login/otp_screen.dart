import 'package:bodmas_education/login/services/auth_service.dart';
import 'package:bodmas_education/login/services/session.dart';
import 'package:bodmas_education/login/user_info_sheet.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';
import 'widgets/custom_text_field.dart';


class OTPScreen extends StatefulWidget {

  final String phone;

  const OTPScreen({super.key, required this.phone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();

    otpController = TextEditingController();
  }

  @override
  void dispose() {

    otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Text("OTP sent to ${widget.phone}"),

            const SizedBox(height: 20),

            CustomTextField(
              controller: otpController,
              label: "Enter 6-digit OTP",
              hint: "Enter OTP",
              icon: Icons.lock,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                child: const Text("Verify OTP"),
                  onPressed: () async {

                    String otp = otpController.text.trim();

                    if (otp.isEmpty) {
                      AppSnackBar.show(
                        context,
                        message: "Enter OTP",
                        type: SnackBarType.warning,
                      );
                      return;
                    } else if (otp.length != 6) {
                      AppSnackBar.show(
                        context,
                        message: "Please enter 6-digit OTP",
                        type: SnackBarType.error,
                      );
                      return;
                    }


                    var res = await AuthService.verifyOtp(widget.phone, otpController.text);

                    if (res == null) {
                      AppSnackBar.show(context,
                          message: "Server error",
                        type: SnackBarType.error,
                      );
                      return;
                    }

                    if (res["status"] == true) {

                      String type = res["type"];

                      print("TYPE: $type");

                      if (type == "login") {

                        // ✅ TOKEN ONLY FOR LOGIN
                        String token = res["token"];
                        await Session.saveToken(token);

                        //await Session.saveUser(response["student"]);

                        var me = await AuthService.getMe(token);
                        if (me != null) {
                          await Session.saveUser(me["student"]);
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MainMenu()),
                              (route) => false,
                        );

                        AppSnackBar.show(context, message: "Login Successfully",
                            type: SnackBarType.success);

                      } else if (type == "register") {

                        // ❌ TOKEN save
                        // bottom sheet

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          enableDrag: false,
                          builder: (_) => UserInfoSheet(phone: widget.phone),
                        );
                      }

                    } else {
                      AppSnackBar.show(context, message: "Invalid OTP",
                      type: SnackBarType.error,
                      );
                    }
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}

