import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';
import 'package:projectakhir/main.dart';
import 'package:projectakhir/model/user.dart';
import 'package:projectakhir/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formfield = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  late SharedPreferences prefs;
  late Box<UserModel> _myBox;

  @override
  void initState() {
    super.initState();
    initial();
    _myBox = Hive.box(boxName);
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _register() async{
    if (_formfield.currentState!.validate()) {
      final username = userController.text.trim();
      final password = passController.text.trim();

      if (_myBox.containsKey(username)) {
        // Username already exists
        _showSnackbar('Username already exists');
      } else {
        final hashedPassword = sha256.convert(utf8.encode(password)).toString();
        _myBox.add(UserModel(
          username: username,
          password: hashedPassword,
        ));
        _showSnackbar('Registration successful');
        await prefs.remove("username");
        _goToLogin();
      }
    }
  }

  // Navigate to LoginScreen
  void _goToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ), (route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: userController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Password",
                    contentPadding: const EdgeInsets.all(8.0),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off
                      ),
                    ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _register,
                  child: const SizedBox(
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    height: 50,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _goToLogin, // Navigate to RegisterScreen
                  child: const Text(
                    "Sudah punya akun?",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
