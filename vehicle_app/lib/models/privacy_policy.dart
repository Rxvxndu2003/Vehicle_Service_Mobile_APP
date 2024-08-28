class PrivacyPolicy {
  final String title;
  final String lastUpdated;
  final String introduction;
  final DataCollection dataCollection;
  final List<DataUsage> dataUsage;
  final DataSharing dataSharing;
  final DataSecurity dataSecurity;
  final List<String> yourRights;
  final ContactInformation contactInformation;

  PrivacyPolicy({
    required this.title,
    required this.lastUpdated,
    required this.introduction,
    required this.dataCollection,
    required this.dataUsage,
    required this.dataSharing,
    required this.dataSecurity,
    required this.yourRights,
    required this.contactInformation,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    var dataUsageFromJson = json['dataUsage'] as List;
    List<DataUsage> dataUsageList = dataUsageFromJson.map((data) => DataUsage.fromJson(data)).toList();

    return PrivacyPolicy(
      title: json['title'] ?? 'No Title Available',
      lastUpdated: json['lastUpdated'] ?? 'No Last Updated Date Available',
      introduction: json['introduction'] ?? 'No Introduction Available',
      dataCollection: DataCollection.fromJson(json['dataCollection'] ?? {}),
      dataUsage: dataUsageList,
      dataSharing: DataSharing.fromJson(json['dataSharing'] ?? {}),
      dataSecurity: DataSecurity.fromJson(json['dataSecurity'] ?? {}),
      yourRights: List<String>.from(json['yourRights'] ?? []),
      contactInformation: ContactInformation.fromJson(json['contactInformation'] ?? {}),
    );
  }
}

class DataCollection {
  final List<String> personalInformation;
  final List<String> usageData;

  DataCollection({
    required this.personalInformation,
    required this.usageData,
  });

  factory DataCollection.fromJson(Map<String, dynamic> json) {
    return DataCollection(
      personalInformation: List<String>.from(json['personalInformation'] ?? []),
      usageData: List<String>.from(json['usageData'] ?? []),
    );
  }
}

class DataUsage {
  final String purpose;
  final String details;

  DataUsage({
    required this.purpose,
    required this.details,
  });

  factory DataUsage.fromJson(Map<String, dynamic> json) {
    return DataUsage(
      purpose: json['purpose'] ?? 'No Purpose Available',
      details: json['details'] ?? 'No Details Available',
    );
  }
}

class DataSharing {
  final List<String> thirdParties;
  final String purpose;

  DataSharing({
    required this.thirdParties,
    required this.purpose,
  });

  factory DataSharing.fromJson(Map<String, dynamic> json) {
    return DataSharing(
      thirdParties: List<String>.from(json['thirdParties'] ?? []),
      purpose: json['purpose'] ?? 'No Purpose Available',
    );
  }
}

class DataSecurity {
  final String description;

  DataSecurity({
    required this.description,
  });

  factory DataSecurity.fromJson(Map<String, dynamic> json) {
    return DataSecurity(
      description: json['description'] ?? 'No Description Available',
    );
  }
}

class ContactInformation {
  final String companyName;
  final String address;
  final String email;
  final String phone;

  ContactInformation({
    required this.companyName,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory ContactInformation.fromJson(Map<String, dynamic> json) {
    return ContactInformation(
      companyName: json['companyName'] ?? 'No Company Name Available',
      address: json['address'] ?? 'No Address Available',
      email: json['email'] ?? 'No Email Available',
      phone: json['phone'] ?? 'No Phone Number Available',
    );
  }
}
