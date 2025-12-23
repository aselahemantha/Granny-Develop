import 'package:Granny/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/app_constants.dart';
import '../main_menu.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  SubscriptionScreenState createState() => SubscriptionScreenState();
}

class SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppConstants.backgroundSubscription,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose Subscription Plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.5, // Restrict width
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

                // Subscription Options
                _buildSubscriptionOption(
                  title: "Monthly Subscription",
                  price: "\$9.99 / month",
                  description: "Unlimited access for one month.",
                  onTap: () {
                    subscriptionProvider.subscribeUser(_phoneController.text);
                  },
                ),
                const SizedBox(height: 16),
                _buildSubscriptionOption(
                  title: "Daily Subscription",
                  price: "\$1.99 / day",
                  description: "24-hour access with full features.",
                  onTap: () {
                    subscriptionProvider.subscribeUser(_phoneController.text);
                  },
                ),
                const SizedBox(height: 16),

                // Login Button
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    onPressed: () async {
                        await _handleSubscription();

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Subscribe Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),


                // Show Subscription Status
                if (subscriptionProvider.subscriptionStatus != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Status: ${subscriptionProvider.subscriptionStatus}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubscription() async {

    if (phoneNumber.isEmpty) {
      _showSnackBar("Please enter a valid phone number");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<SubscriptionProvider>(context, listen: false);
    await provider.subscribeUser(phoneNumber);

    setState(() {
      isLoading = false;
    });

    if (provider.statusDetail == "SUCCESS" && provider.subscriptionStatus == "REGISTERED") {
      _showSnackBar("Subscription Successful!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      _showSnackBar("Subscription Unsuccessful! Try Again.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
      );
    }
  }

  Widget _buildSubscriptionOption({
    required String title,
    required String price,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(price,
                style: const TextStyle(fontSize: 16, color: Colors.green)),
            Text(description,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
          ],
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
