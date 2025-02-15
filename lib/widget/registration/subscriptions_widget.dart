import 'package:flutter/material.dart';
import '../home_page_widget.dart'; // Import DashboardWidget for navigation

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8, // Show part of adjacent cards
  );
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Subscription Tiers',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // Navigate back to the Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardWidget()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: 3, // Gold, Platinum, Diamond
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(value) * 400,
                        width: Curves.easeInOut.transform(value) * 300,
                        child: child,
                      ),
                    );
                  },
                  child: _buildSubscriptionCard(
                    title: index == 0
                        ? 'Gold'
                        : index == 1
                        ? 'Platinum'
                        : 'Diamond',
                    price: index == 0
                        ? '₹299/six-months'
                        : index == 1
                        ? '₹499/six-months'
                        : '₹999/six-months',
                    features: index == 0
                        ? [
                      'Upto 2.00 Tuition',
                      'Get Certified for Free',
                    ]
                        : index == 1
                        ? [
                      'Upto 5.00 Tuition',
                      'Get Certified for Free',
                      'Personal loan facility',
                    ]
                        : [
                      'Upto 11.00 Tuition',
                      'Get Certified for Free',
                      'Personal loan facility',
                      'Subject specific Tuition',
                      'Free Teacher Training',
                      "Tutor's Health Insurance",
                    ],
                    unavailableFeatures: index == 0
                        ? [
                      'Personal loan facility',
                      'Subject specific Tuition',
                      'Free Teacher Training',
                      "Tutor's Health Insurance",
                    ]
                        : index == 1
                        ? [
                      'Subject specific Tuition',
                      'Free Teacher Training',
                      "Tutor's Health Insurance",
                    ]
                        : [],
                    cardColor: index == 0
                        ? Colors.amber.shade50
                        : index == 1
                        ? Colors.blueGrey.shade50
                        : Colors.purple.shade50,
                    icon: index == 0
                        ? Icons.star
                        : index == 1
                        ? Icons.workspace_premium
                        : Icons.diamond,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Dot Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.red : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String> features,
    required List<String> unavailableFeatures,
    required Color cardColor,
    required IconData icon,
  }) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 40,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Text(feature, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  ],
                ),
              )),
              ...unavailableFeatures.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
