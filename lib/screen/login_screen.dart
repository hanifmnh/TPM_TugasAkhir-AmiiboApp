import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:projectakhir/model/user.dart';
import 'package:projectakhir/main.dart';
import 'package:projectakhir/screen/register_screen.dart';
import 'package:projectakhir/navigation/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  late Box<UserModel> _myBox;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkIsLogin();
    _myBox = Hive.box(boxName);
  }

  void checkIsLogin() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));

    bool? isLogin = (prefs.getString('username') != null) ? true : false;

    if(isLogin && mounted){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNavbar(),
        ), (route) => false
      );
    }
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

  void _login() async {
    if (_formfield.currentState!.validate()) {
      bool found = false;
      final username = userController.text.trim();
      final password = passController.text.trim();
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      found = checkLogin(username, hashedPassword);

      if (!found) {
        _showSnackbar('Username or Password is Wrong');
      } else {
        await prefs.setString('username', username);
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavbar(),
            ),
                (route) => false,
          );
        }
        _showSnackbar('Login Success');
      }
    }
  }

  // Navigate to RegisterScreen
  void _goToRegister() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ), (route) => false);
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
                  onPressed: _login,
                  child: const SizedBox(
                    child: Center(
                      child: Text(
                        "Login",
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
                  onTap: _goToRegister, // Navigate to RegisterScreen
                  child: const Text(
                    "Belum punya akun?",
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

  int getLength() {
    return _myBox.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _myBox.getAt(i)!.username &&
          password == _myBox.getAt(i)!.password) {
        ("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }
    return found;
  }

  bool checkUsers(String username) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _myBox.getAt(i)!.username) {
        found = true;
        break;
      } else {
        found = false;
      }
    }
    return found;
  }
}