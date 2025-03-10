// ignore_for_file: non_constant_identifier_names
import 'dart:io';

class UpdateShopModel {
  final String business_name;
  final int contact_number;
  final String address;
  final String city;
  final String state;
  final int pincode;
  final int fssai_no;
  final File? fssai_certicate;
  final String bussiness_location;
  final String business_landmark;
  final String store_id;
 final int store_type;
 final File? license;

  UpdateShopModel( {
     required this.license,
     required this.store_id,
     required this.business_name,
     required this.contact_number,
     required this.address,
     required this.city,
     required this.state,
     required this.pincode,
     required this.store_type,
     required this.fssai_no,
     required this.fssai_certicate,
     required this.bussiness_location,
     required this.business_landmark,
  });

  // Map<String,dynamic> toMap(UpdateShopModel model){
  //   return {
  //     "business_name":model.business_name,
  //     "business_location":model.bussiness_location,
  //     "business_landmark":model.business_landmark,
  //     "address":model.address,
  //     "city":model.city,
  //     "state":model.state,
  //     "pincode":model.pincode,
  //     "fssai_no":model.fssai_no,
  //     "license":model.license,
  //     "store_type":model.store_type,
  //     "fssai_certificate":model.fssai_certicate
  //   };
  // }
}
