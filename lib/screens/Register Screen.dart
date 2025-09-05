import 'package:flutter/material.dart';
import 'package:movie_app/firebase/firebase_manage.dart';
import 'package:movie_app/models/user_request_data.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF6BD00)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Register",
          style: TextStyle(color: Color(0xFFF6BD00)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/avatar1.png"),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/avatar2.png"),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/avatar3.png"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Avatar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Name
              TextFormField(
                controller:nameController ,
                validator: (value) {
                    if (value==null || value.isEmpty){
                    return"Name is Required";
                    }
                    return null;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge, color: Colors.white),
                  hintText: "Name",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value==null || value.isEmpty){
                    return"Email is Required";
                  }
                  final bool emailValid =
                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$")
                      .hasMatch(value);
                  if(emailValid==false){
                    return"Email Not Valid";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),


              // Password
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value==null || value.isEmpty) {
                    return "Password is Required";
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextFormField(
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value==null || value.isEmpty) {
                    return "Password is Required";
                  }
                  if(value!=passwordController.text){
                    return "Password not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),

              // Phone Number
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value==null || value.isEmpty){
                    return"Phone is Required";
                  }
                  if(value.length!=11){
                    return "Phone Is Invalid";
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone, color: Colors.white),
                  hintText: "Phone Number",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 25),


              // Create Account button
              ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){UserData user =UserData(
                      nameController.text,
                      emailController.text,
                      "",
                      phoneController.text);
                  FirebaseManager.signUp(user: user, password: passwordController.text,
                  onSuccess: (){
                    Navigator.pushNamed(context, "/HomePage.routeName");
                  },
                  onError: (value){
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text("error"),
                      content: Text(value),
                      actions: [
                        ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text("okay"))
                      ],
                    ),);

                  }
                  );}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6BD00),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 15),

              // Already Have Account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have Account ? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // go back to login
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xFFF6BD00)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Flags
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/LR.png", height: 30),
                  const SizedBox(width: 10),
                  Image.asset("assets/images/EG.png", height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: const TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
