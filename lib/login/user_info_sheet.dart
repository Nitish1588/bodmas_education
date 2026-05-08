import 'package:bodmas_education/login/services/auth_service.dart';
import 'package:bodmas_education/login/services/session.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';
import 'widgets/custom_text_field.dart';

class UserInfoSheet extends StatelessWidget {

  final String phone;

  const UserInfoSheet({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "Enter Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
             color: Colors.black87,
              letterSpacing: 1.1,
            ),
          ),

          const SizedBox(height: 10),

          CustomTextField(controller: nameController, label: "Name", hint: "Name", icon: Icons.person),
          const SizedBox(height: 5),
          CustomTextField(controller: emailController, label: "Email", hint: "Email", icon: Icons.email),

          const SizedBox(height: 10),

          SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Green background
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
              onPressed: () async {

                var res = await AuthService.register(
                  phone,
                  nameController.text,
                  emailController.text,
                );

                if (res != null && res["status"] == true) {

                  AppSnackBar.show(context, message: "Login Successfully",
                  type: SnackBarType.success);

                 // await Session.saveToken(res["token"]);

                  String token = res["token"];
                  await Session.saveToken(token);

                  var me = await AuthService.getMe(token);
                  if (me != null) {
                    await Session.saveUser(me["student"]);
                  }

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MainMenu()),
                        (route) => false,
                  );

                }
              },
              child: const Text("Continue"),
            ),
          )
        ],
      ),
    );
  }
}