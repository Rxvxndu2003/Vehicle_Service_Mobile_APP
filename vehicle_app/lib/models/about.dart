class AboutData {
  final About about;
  final List<Service> services;
  final List<Fact> facts;
  final List<TeamMember> team;

  AboutData({required this.about, required this.services, required this.facts, required this.team});

  factory AboutData.fromJson(Map<String, dynamic> json) {
    var servicesList = json['service'] as List;
    var factsList = json['facts'] as List;
    var teamList = json['team'] as List;

    List<Service> services = servicesList.map((i) => Service.fromJson(i)).toList();
    List<Fact> facts = factsList.map((i) => Fact.fromJson(i)).toList();
    List<TeamMember> team = teamList.map((i) => TeamMember.fromJson(i)).toList();

    return AboutData(
      about: About.fromJson(json['about']),
      services: services,
      facts: facts,
      team: team,
    );
  }
}

class About {
  final String image;
  final int experienceYears;
  final String title;
  final String description;
  final List<Feature> features;

  About({required this.image, required this.experienceYears, required this.title, required this.description, required this.features});

  factory About.fromJson(Map<String, dynamic> json) {
    var featuresList = json['features'] as List;
    List<Feature> features = featuresList.map((i) => Feature.fromJson(i)).toList();

    return About(
      image: json['image'],
      experienceYears: json['experience_years'],
      title: json['title'],
      description: json['description'],
      features: features,
    );
  }
}

class Feature {
  final String number;
  final String title;
  final String subtitle;

  Feature({required this.number, required this.title, required this.subtitle});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      number: json['number'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}

class Service {
  final String icon;
  final String title;
  final String description;
  final String link;

  Service({required this.icon, required this.title, required this.description, required this.link});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      icon: json['icon'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
    );
  }
}

class Fact {
  final String icon;
  final int number;
  final String text;

  Fact({required this.icon, required this.number, required this.text});

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      icon: json['icon'],
      number: json['number'],
      text: json['text'],
    );
  }
}

class TeamMember {
  final String image;
  final String name;
  final String designation;
  final SocialLinks socialLinks;

  TeamMember({required this.image, required this.name, required this.designation, required this.socialLinks});

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      image: json['image'],
      name: json['name'],
      designation: json['designation'],
      socialLinks: SocialLinks.fromJson(json['social_links']),
    );
  }
}

class SocialLinks {
  final String facebook;
  final String twitter;
  final String instagram;

  SocialLinks({required this.facebook, required this.twitter, required this.instagram});

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      facebook: json['facebook'],
      twitter: json['twitter'],
      instagram: json['instagram'],
    );
  }
}