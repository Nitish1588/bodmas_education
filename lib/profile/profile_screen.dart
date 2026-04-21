import 'package:bodmas_education/Mentorship/mentorship.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  final nameController = TextEditingController(text: "John Doe");
  final phoneController = TextEditingController(text: "9876543210");
  final emailController = TextEditingController(text: "john@gmail.com");
  final addressController = TextEditingController(text: "Delhi, India");
  final aboutController =
  TextEditingController(text: "Student at Bodmas Education");
  final dobController = TextEditingController(text: "12 Jan 2000");

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text = DateFormat('dd MMM yyyy').format(picked);
      setState(() {});
    }
  }

  Widget buildField(String label, TextEditingController controller,
      {bool enabled = true, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          readOnly: onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildViewTile(String label, String value, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Text(
              isEditing ? "Save" : "Edit",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 Top Card (Image + Basic Details)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=5"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nameController.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(phoneController.text,
                            style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text(emailController.text,
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 Details Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  if (!isEditing) ...[
                    buildViewTile(
                        "Address", addressController.text, Icons.location_on),
                    buildViewTile(
                        "About", aboutController.text, Icons.info),
                    buildViewTile(
                        "DOB", dobController.text, Icons.calendar_today),
                  ] else ...[
                    buildField("Name", nameController),
                    const SizedBox(height: 12),

                    /// ❌ Mobile Not Editable
                    buildField("Mobile", phoneController, enabled: false),
                    const SizedBox(height: 12),

                    buildField("Email", emailController),
                    const SizedBox(height: 12),
                    buildField("Address", addressController),
                    const SizedBox(height: 12),
                    buildField("About", aboutController),
                    const SizedBox(height: 12),
                    buildField("DOB", dobController,
                        onTap: () => selectDate()),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Help & Privacy
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text("Help"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text("Privacy Policy"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MentorshipScreen()),
                  );

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFFFFFFF),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}