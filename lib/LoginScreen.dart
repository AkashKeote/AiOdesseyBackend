import 'package:chatbot/GetStarted.dart';
import 'package:chatbot/SignUpScreen.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false; // Toggle password visibility
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty; // Removed username check
    });
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastmessage(value.user!.email.toString());
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GetStarted()));
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastmessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon:
                          Icon(Icons.arrow_back, color: Colors.grey, size: 30),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => main.SilentMoonScreen()));
                      },
                    ),
                  ),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Color(0xFF3F414E),
                      fontFamily: 'HelveticaBold',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF7583CA),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Image.asset('assets/images/fb.png',
                        height: 18, width: 20),
                    label: Text(
                      'CONTINUE WITH FACEBOOK',
                      style: TextStyle(fontFamily: 'HelveticaMedium'),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Image.asset('assets/images/google.png',
                        height: 18, width: 30),
                    label: Text(
                      'CONTINUE WITH GOOGLE',
                      style: TextStyle(fontFamily: 'HelveticaMedium'),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 30),
                  Text(
                    'OR LOG IN WITH EMAIL',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'HelveticaBold',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(
                          fontFamily: 'HelveticaLight',
                          color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          fontFamily: 'HelveticaLight',
                          color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isFormValid ? Color(0xFF8E97FD) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(double.infinity, 50.0),
                    ),
                    onPressed: _isFormValid ? login : null,
                    child: loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text('Login',
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'HelveticaMedium')),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'HelveticaBold'), // Default style
                      children: [
                        TextSpan(text: "DON'T HAVE AN ACCOUNT? "),
                        WidgetSpan(
                          alignment:
                              PlaceholderAlignment.middle, // Aligns with text
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateAccountScreen()));
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Color(0xFF6366F1),
                                  fontFamily: 'HelveticaMedium'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
