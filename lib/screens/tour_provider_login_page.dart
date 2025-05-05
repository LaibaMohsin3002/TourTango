import 'package:flutter/material.dart';
import 'tour_provider_signup_page.dart';
import 'tour_provider_home_page.dart';
import 'package:tourtango/api.dart';

class TourProviderLoginPage extends StatefulWidget {
  const TourProviderLoginPage({super.key});

  @override
  _TourProviderLoginPageState createState() => _TourProviderLoginPageState();
}

class _TourProviderLoginPageState extends State<TourProviderLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validator
  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Call the API login function
    final result = await providerLogin(email, password);

    if (result.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error'])),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TourProviderHomePage(companyEmail: result['email']),
        ),
      );
    }
  }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fix the errors before submitting')),
      );
    }}


  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TourProviderSignupPage()),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TourProviderSignupPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
    body: Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16,
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tour Provider Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: _emailValidator,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: _passwordValidator,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _navigateToForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: const Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}