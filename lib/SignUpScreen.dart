import 'package:chatbot/GetStarted.dart';
import 'package:chatbot/LoginScreen.dart';
import 'package:chatbot/main.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  bool _isFormValid = false;
  bool _isChecked = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)  => SilentMoonApp()));
                  },
                ),
              ),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50.0),
              _buildSocialButton(
                  'Continue with Facebook', Color(0xFF7583CA), Icons.facebook),
              SizedBox(height: 20.0),
              _buildSocialButton(
                  'Continue with Google', Colors.white, Icons.email,
                  isGoogle: true),
              SizedBox(height: 40.0),
              Text('OR LOG IN WITH EMAIL',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 35.0),
              _buildTextField(
                  _usernameController, 'Username', Icons.check, true),
              SizedBox(height: 18.0),
              _buildTextField(_emailController, 'Email', Icons.check, true),
              SizedBox(height: 18.0),
              _buildTextField(
                  _passwordController, 'Password', Icons.visibility_off, false,
                  isPassword: true),
              SizedBox(height: 18.0),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                        _validateForm();
                      });
                    },
                  ),
                  Text('I have read the '),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Privacy Policy',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFormValid ? Color(0xFF8E8EEB) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(double.infinity, 50.0),
                ),
                onPressed: _isFormValid ? () {
                  setState(() {
                    loading=false;
                  });
         _auth.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString()).then((value){
     
         }).onError((error, stackTrace) {
          setState(() {
            loading=false;
          });
           Utils().toastmessage(error.toString());
         },);
                  Navigator.push(context, MaterialPageRoute(builder: (context)  => LoginPage()));
                } : null,
                child: loading? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),)
                : Text('SIGN UP', style: TextStyle(fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, Color color, IconData icon,
      {bool isGoogle = false}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: Size(double.infinity, 50.0),
      ),
      icon: Icon(icon, color: isGoogle ? Colors.red : Colors.white),
      label: Text(
        text,
        style: TextStyle(
            color: isGoogle ? Colors.black : Colors.white, fontSize: 16.0),
      ),
      onPressed: () {},
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      IconData icon, bool showIcon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: showIcon
            ? Icon(icon, color: Colors.green)
            : IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
      ),
    );
  }
}