import 'package:flutter/material.dart';
import 'package:vehicle_app/Services/about_service.dart';
import 'package:vehicle_app/models/about.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<AboutData> futureAboutData;

  @override
  void initState() {
    super.initState();
    futureAboutData = AboutService().loadAboutData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: FutureBuilder<AboutData>(
        future: futureAboutData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return buildAboutContent(snapshot.data!);
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget buildAboutContent(AboutData data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(data.about.image), // Use AssetImage
            const SizedBox(height: 16),
            Text(data.about.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(data.about.description),
            const SizedBox(height: 32),
            const Text('Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...data.about.features.map((feature) => ListTile(
              leading: CircleAvatar(child: Text(feature.number)),
              title: Text(feature.title),
              subtitle: Text(feature.subtitle),
            )),
            const SizedBox(height: 32),
            const Text('Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...data.services.map((service) => ListTile(
              leading: const Icon(Icons.circle), // Replace with appropriate icon
              title: Text(service.title),
              subtitle: Text(service.description),
              trailing: TextButton(
                onPressed: () {},
                child: Text(service.link),
              ),
            )),
            const SizedBox(height: 32),
            const Text('Facts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...data.facts.map((fact) => ListTile(
              leading: const Icon(Icons.circle), // Replace with appropriate icon
              title: Text(fact.text),
              trailing: Text(fact.number.toString()),
            )),
            const SizedBox(height: 32),
            const Text('Our Team', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...data.team.map((member) => ListTile(
              leading: Image.asset(member.image, width: 50, height: 50, fit: BoxFit.cover), // Use AssetImage
              title: Text(member.name),
              subtitle: Text(member.designation),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.facebook), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.call_made_sharp), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.chat_sharp), onPressed: () {}),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
