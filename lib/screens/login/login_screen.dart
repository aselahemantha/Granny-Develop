import 'package:Granny/screens/login/subscription_screen.dart';
import 'package:Granny/screens/main_menu.dart';
import 'package:Granny/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppConstants.backgroundLogin,
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Left Character Icon
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              AppConstants.grannyCharacterImage,
              fit: BoxFit.cover,
              height: 172,
              width: 114,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter Mobile Number",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Phone Input Field
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) {
                      setState(() {
                        phoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Login Button
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: _buildButton("Login", () async {
                    await _handleLogin();
                  }),
                ),

                const SizedBox(height: 16),

                const Text(
                  "If you are new?",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: _buildTextBox(
                    context,
                    "Subscribe Now",
                    const SubscriptionScreen(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Handle Login API Call
  Future<void> _handleLogin() async {
    if (phoneNumber.isEmpty) {
      _showSnackBar("Please enter a valid phone number");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<LoginProvider>(context, listen: false);
    await provider.checkSubscriptionStatus(phoneNumber);

    setState(() {
      isLoading = false;
    });


    if (provider.statusDetail == "SUCCESS" && provider.subscriptionStatus == "REGISTERED") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenu()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
      );
    }
  }

  // Generic Button Widget
  Widget _buildButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Clickable "Subscribe Now" Box
  Widget _buildTextBox(BuildContext context, String text, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Show SnackBar for Error Messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
