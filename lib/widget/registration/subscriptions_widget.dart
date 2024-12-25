import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Subscription Page',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Horizontal layout for larger screens (laptop)
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildSubscriptionCard(
                        title: 'Basic Plan',
                        description: '''
₹299/six-months
Upto 2.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSubscriptionCard(
                        title: 'Standard Plan',
                        description: '''
₹499/six-months
Upto 5.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSubscriptionCard(
                        title: 'Subject Specific',
                        description: '''
₹999/six-months
Upto 11.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                        context: context,
                      ),
                    ),
                  ],
                );
              } else {
                // Vertical layout for smaller screens (mobile)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Subscription Tiers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    _buildSubscriptionCard(
                      title: 'Basic Plan',
                      description: '''
₹299/six-months
Upto 2.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                      context: context,
                    ),
                    const SizedBox(height: 20),
                    _buildSubscriptionCard(
                      title: 'Standard Plan',
                      description: '''
₹499/six-months
Upto 5.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                      context: context,
                    ),
                    const SizedBox(height: 20),
                    _buildSubscriptionCard(
                      title: 'Subject Specific',
                      description: '''
₹999/six-months
Upto 11.00 Tuition
Get Certified for Free
Personal loan facility
Subject specific Tuition
Free Teacher Training
Tutor's Health Insurance''',
                      context: context,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String description,
    required BuildContext context,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _subscribe(title, context);
              },
              child: const Text('Apply Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50), // Ensures button has size
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _subscribe(String plan, BuildContext context) {
    // Show loading indicator while processing
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate a delay for subscription process (e.g., API call)
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close the loading dialog

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Subscription Confirmed'),
          content: Text('You have subscribed to the $plan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to another page, for example:
                // Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
