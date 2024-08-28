import 'package:flutter/material.dart';
import '../models/privacy_policy.dart';
import '../services/privacy_service.dart';

class PrivacyPage extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
      body: FutureBuilder<PrivacyPolicy>(
        future: futurePrivacyPolicy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 196, 0)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last Updated: ${policy.lastUpdated}',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  Divider(height: 32, thickness: 2),
                  Text(
                    policy.introduction,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Collection'),
                  _buildSectionContent('Personal Information: ${policy.dataCollection.personalInformation.join(', ')}'),
                  _buildSectionContent('Usage Data: ${policy.dataCollection.usageData.join(', ')}'),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Usage'),
                  ...policy.dataUsage.map((dataUsage) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataUsage.purpose,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dataUsage.details,
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      )),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Sharing'),
                  _buildSectionContent('Third Parties: ${policy.dataSharing.thirdParties.join(', ')}'),
                  _buildSectionContent('Purpose: ${policy.dataSharing.purpose}'),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Data Security'),
                  _buildSectionContent(policy.dataSecurity.description),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Your Rights'),
                  ...policy.yourRights.map((right) => Text(
                        '- $right',
                        style: TextStyle(fontSize: 16, height: 1.5),
                      )),
                  Divider(height: 32, thickness: 2),
                  _buildSectionTitle('Contact Information'),
                  _buildSectionContent('Company: ${policy.contactInformation.companyName}'),
                  _buildSectionContent('Address: ${policy.contactInformation.address}'),
                  _buildSectionContent('Email: ${policy.contactInformation.email}'),
                  _buildSectionContent('Phone: ${policy.contactInformation.phone}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 196, 0)),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }
}