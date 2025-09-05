import 'package:flutter/material.dart';
import 'package:test_project/utils/app_assets.dart';
import 'package:test_project/utils/app_colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.amberColor),
        title: const Text("Pick Avatar",style: TextStyle(color: AppColors.amberColor),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: ImageIcon(AssetImage(AppAssets.nameIcon),color: AppColors.whiteColor,),
                labelText: "Name",
                labelStyle: const TextStyle(color: AppColors.whiteColor),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: ImageIcon(AssetImage(AppAssets.phoneIcon),color: AppColors.whiteColor),
                labelText: "phone",
                labelStyle: const TextStyle(color: AppColors.whiteColor),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Align(
            alignment: Alignment.centerLeft,
                child:const Text("Reset Password",style: TextStyle(color: AppColors.whiteColor),)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Delete Account")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Delete Profile",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.amberColor,minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),),
              child: const Text("Update Data", style: TextStyle(color: Colors.black)),
            ),

          ],
        ),
      ),
    );
  }
}
