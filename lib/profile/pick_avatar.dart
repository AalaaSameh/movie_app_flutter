import 'package:flutter/material.dart';

class PickAvatar extends StatelessWidget {
  const PickAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      "assets/images/avatar1.png",
      "assets/images/avatar2.png",
      "assets/images/avatar3.png",
      "assets/images/avatar4.png",
      "assets/images/avatar5.png",
      "assets/images/avatar6.png",
      "assets/images/avatar7.png",
      "assets/images/avatar8.png",
      "assets/images/avatar9.png",
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pick Avatar",
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: avatars.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, avatars[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    avatars[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
