import 'package:Granny/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/subscription_provider.dart';
import '../../../providers/unsubscription_provider.dart';
import '../../../utils/app_constants.dart';
import '../../login/login_screen.dart';
import '../../main_menu.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isMusicEnabled = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    String phoneNumber = loginProvider.phoneNumber ?? "Not Available";
    String subscriptionStatus = loginProvider.subscriptionStatus ?? "Not Subscribed";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.settingsBackground,
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          SafeArea(
            child: Column(
              children: [
                // Top bar with icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 30, color: Colors.white),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainMenu()),
                                (route) => false,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu, size: 30, color: Colors.white),
                        onPressed: () {
                          // Handle menu button press
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logged-in Phone Number
                            _buildDetailField("Phone Number", phoneNumber),
                            const SizedBox(height: 16),

                            // Subscription Status
                            Consumer<SubscriptionProvider>(
                              builder: (context, subscriptionProvider, _) {
                                return _buildDetailField(
                                  "Subscription Status",
                                  subscriptionStatus ?? "Not Subscribed",
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            // Background Music Toggle
                            _buildMusicToggle(),
                            const SizedBox(height: 24),

                            // Unsubscribe Button
                            _buildUnsubscribeButton(phoneNumber),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build detail fields
  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMusicToggle() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Background Music",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: musicProvider.isMusicEnabled,
                onChanged: (value) {
                  musicProvider.toggleMusic(value); // Pass the `value`
                },
                activeColor: Colors.yellow,
              ),
            ],
          ),
        );
      },
    );
  }



  // Unsubscribe Button Widget
  Widget _buildUnsubscribeButton(String phoneNumber) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirm Unsubscribe"),
              content: const Text("Are you sure you want to unsubscribe?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    _handleSubscription(phoneNumber);
                  },
                  child: const Text("Unsubscribe"),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: const Text(
          "Unsubscribe",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubscription(phoneNumber) async {

    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<UnSubscriptionProvider>(context, listen: false);
    await provider.unsubscribeUser(phoneNumber);

    setState(() {
      isLoading = false;
    });

    if (provider.statusDetail == "SUCCESS" && provider.subscriptionStatus == "UNREGISTERED") {
      _showSnackBar("Successful!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      _showSnackBar("Unsuccessful! Try Again.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
