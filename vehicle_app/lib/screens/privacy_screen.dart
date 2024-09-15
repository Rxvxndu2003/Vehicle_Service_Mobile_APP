import 'package:flutter/material.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';
import '../models/privacy_policy.dart';
import '../services/privacy_service.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  late Future<PrivacyPolicy> futurePrivacyPolicy;

  @override
  void initState() {
    super.initState();
    futurePrivacyPolicy = PrivacyService().fetchPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,
          size: 28, 
          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                            ),
          onPressed: () {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavbarRoots(initialIndex: 4,),
              ),
            );
          },
        ),
        title: Text(
          "Privacy",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 28, // Size of the notification icon
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: FutureBuilder<PrivacyPolicy>(
        future: futurePrivacyPolicy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final policy = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    policy.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 196, 0)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last Updated: ${policy.lastUpdated}',
                    style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  const Divider(height: 32, thickness: 2),
                  Text(
                    policy.introduction,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Collection'),
                  _buildSectionContent('Personal Information: ${policy.dataCollection.personalInformation.join(', ')}'),
                  _buildSectionContent('Usage Data: ${policy.dataCollection.usageData.join(', ')}'),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Usage'),
                  ...policy.dataUsage.map((dataUsage) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataUsage.purpose,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dataUsage.details,
                              style: const TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      )),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Sharing'),
                  _buildSectionContent('Third Parties: ${policy.dataSharing.thirdParties.join(', ')}'),
                  _buildSectionContent('Purpose: ${policy.dataSharing.purpose}'),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Security'),
                  _buildSectionContent(policy.dataSecurity.description),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Your Rights'),
                  ...policy.yourRights.map((right) => Text(
                        '- $right',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      )),
                  const Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Contact Information'),
                  _buildSectionContent('Company: ${policy.contactInformation.companyName}'),
                  _buildSectionContent('Address: ${policy.contactInformation.address}'),
                  _buildSectionContent('Email: ${policy.contactInformation.email}'),
                  _buildSectionContent('Phone: ${policy.contactInformation.phone}'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 196, 0)),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }
}