import 'dart:io';

class ProfileShopModel {
  int? id;
  String? storeId;
  String? ownerName;
  String? email;
  String? businessName;
  String? businessLocation;
  String? businessLandmark;
  String? contactNumber;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? fssaiNo;
  String? fssaiCertificate;
  String? storeLogo;
  String? displayImage;
  String? storeDescription;
  int? storeType;
  String? storeTypeName;
  String? openingTime;
  String? closingTime;
  String? license;
  bool? isApproved;
  bool? isActive;
  String? createdAt;
  bool? isRestaurent;
  bool? isGrocery;
  Null? alternateEmail;
  String? since;

  ProfileShopModel(
      {this.id,
        this.storeId,
        this.ownerName,
        this.email,
        this.businessName,
        this.businessLocation,
        this.businessLandmark,
        this.contactNumber,
        this.address,
        this.city,
        this.state,
        this.pincode,
        this.fssaiNo,
        this.fssaiCertificate,
        this.storeLogo,
        this.displayImage,
        this.storeDescription,
        this.storeType,
        this.storeTypeName,
        this.openingTime,
        this.closingTime,
        this.license,
        this.isApproved,
        this.isActive,
        this.createdAt,
        this.isRestaurent,
        this.isGrocery,
        this.alternateEmail,
        this.since});

  ProfileShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    ownerName = json['owner_name'];
    email = json['email'];
    businessName = json['business_name'];
    businessLocation = json['business_location'];
    businessLandmark = json['business_landmark'];
    contactNumber = json['contact_number'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    fssaiNo = json['fssai_no'];
    fssaiCertificate = json['fssai_certificate'];
    storeLogo = json['store_logo'];
    displayImage = json['display_image'];
    storeDescription = json['store_description'];
    storeType = json['store_type'];
    storeTypeName = json['store_type_name'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    license = json['license'];
    isApproved = json['is_approved'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    isRestaurent = json['is_restaurent'];
    isGrocery = json['is_Grocery'];
    alternateEmail = json['alternate_email'];
    since = json['since'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['owner_name'] = this.ownerName;
    data['email'] = this.email;
    data['business_name'] = this.businessName;
    data['business_location'] = this.businessLocation;
    data['business_landmark'] = this.businessLandmark;
    data['contact_number'] = this.contactNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['fssai_no'] = this.fssaiNo;
    data['fssai_certificate'] = this.fssaiCertificate;
    data['store_logo'] = this.storeLogo;
    data['display_image'] = this.displayImage;
    data['store_description'] = this.storeDescription;
    data['store_type'] = this.storeType;
    data['store_type_name'] = this.storeTypeName;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['license'] = this.license;
    data['is_approved'] = this.isApproved;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['is_restaurent'] = this.isRestaurent;
    data['is_Grocery'] = this.isGrocery;
    data['alternate_email'] = this.alternateEmail;
    data['since'] = this.since;
    return data;
  }
}
