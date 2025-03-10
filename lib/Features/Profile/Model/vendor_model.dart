// ignore_for_file: non_constant_identifier_names
class VendorModel {
  final String owner_name;
  final String email;
  final String business_name;
  final int contact_number;
  final String address;
  final String city;
  final String state;
  final int pincode;
  final String store_logo;
  final String store_description;
  final int store_type;
  final String closing_time;
  final String opening_time;
  final int fssai_no;
  final String fssai_certicate;
  final String bussiness_location;
  final String business_landmark;
  final String display_image;
  final bool is_active;
  final bool is_approved;
  final String store_type_name;
  final int id;
  final String store_id;

  VendorModel({
    required this.store_id,
    required this.store_type_name,
    required this.id,
    required this.owner_name,
    required this.email,
    required this.business_name,
    required this.contact_number,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.store_logo,
    required this.store_description,
    required this.store_type,
    required this.closing_time,
    required this.opening_time,
    required this.fssai_no,
    required this.fssai_certicate,
    required this.bussiness_location,
    required this.business_landmark,
    required this.display_image,
    required this.is_active,
    required this.is_approved,
  });

  factory VendorModel.fromMap(Map<String, dynamic> vendorMap) {
    return VendorModel(
      store_id: vendorMap["store_id"],
      id: vendorMap["id"],
      owner_name: vendorMap["owner_name"],
      email: vendorMap["email"],
      business_name: vendorMap["business_name"],
      contact_number: vendorMap["contact_number"] != null 
          ? int.parse(vendorMap["contact_number"].toString()) 
          : 0, // Default to 0 if null
      address: vendorMap["address"],
      city: vendorMap["city"],
      state: vendorMap["state"],
      pincode: vendorMap["pincode"] != null 
          ? int.parse(vendorMap["pincode"].toString()) 
          : 0, // Default to 0 if null
      store_logo: vendorMap["store_logo"],
      store_description: vendorMap["store_description"],
      store_type: vendorMap["store_type"] != null 
          ? int.parse(vendorMap["store_type"].toString()) 
          : 0, // Default to 0 if null
      store_type_name:vendorMap["store_type_name"],    
      closing_time: vendorMap["closing_time"],
      opening_time: vendorMap["opening_time"],
      fssai_no: vendorMap["fssai_no"] != null 
          ? int.parse(vendorMap["fssai_no"].toString()) 
          : 0, // Default to 0 if null
      fssai_certicate: vendorMap["fssai_certicate"] ?? "",
      bussiness_location: vendorMap["bussiness_location"] ?? "location",
      business_landmark: vendorMap["business_landmark"],
      display_image: vendorMap["display_image"] ?? "",
      is_active: vendorMap["is_active"] ?? false, // Handle null
      is_approved: vendorMap["is_approved"] ?? false, // Handle null
    );
  }
}
