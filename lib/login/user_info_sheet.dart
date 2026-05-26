import 'package:bodmas_education/login/services/auth_service.dart';
import 'package:bodmas_education/login/services/session.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';
import 'widgets/custom_text_field.dart';

class UserInfoSheet extends StatefulWidget {

  final String phone;

  const UserInfoSheet({
    super.key,
    required this.phone,
  });

  @override
  State<UserInfoSheet> createState() => _UserInfoSheetState();
}

class _UserInfoSheetState extends State<UserInfoSheet> {

  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                String name = nameController.text.trim();
                String email = emailController.text.trim();

                if (name.isEmpty) {

                  AppSnackBar.show(
                    context,
                    message: "Enter name",
                    type: SnackBarType.warning,
                  );

                  return;
                }

                if (email.isEmpty || !email.contains("@")) {

                  AppSnackBar.show(
                    context,
                    message: "Enter valid email",
                    type: SnackBarType.error,
                  );

                  return;
                }
                var res = await AuthService.register(
                  widget.phone,
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