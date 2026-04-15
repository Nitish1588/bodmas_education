import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';
import 'widgets/custom_text_field.dart';



class UserInfoSheet extends StatelessWidget {
  const UserInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "Enter Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          CustomTextField(
            controller: nameController,
            label: "Name",
            hint: "Enter your name",
            icon: Icons.person,
          ),

          const SizedBox(height: 10),

          CustomTextField(
            controller: emailController,
            label: "Email",
            hint: "Enter your email",
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
              ),
              child: const Text("Next"),
              onPressed: () {

                Navigator.pop(context); // bottom sheet close

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MainMenu()),
                      (route) => false,
                );

              },
            ),
          ),

        ],
      ),
    );
  }
}