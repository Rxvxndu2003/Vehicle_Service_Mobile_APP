class Profile {
  final String customerId;
  final String phoneNumber;
  final String address;
  final String vehicleId;
  final String vehicleModel;

  Profile({
    required this.customerId,
    required this.phoneNumber,
    required this.address,
    required this.vehicleId,
    required this.vehicleModel,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      customerId: json['customer_id'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      vehicleId: json['vehicle_id'],
      vehicleModel: json['vehicle_model'],
    );
  }
}
