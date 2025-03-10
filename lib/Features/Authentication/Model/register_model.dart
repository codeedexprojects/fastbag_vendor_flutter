// ignore_for_file: non_constant_identifier_names
import 'dart:io';

class RegisterModel {
  final String owner_name;
  final String email;
  final String business_name;
  final int contact_number;
  final String address;
  final String city;
  final String state;
  final int pincode;
  final File store_logo;
  final String store_description;
  final String store_type;
  final String closing_time;
  final String opening_time;
  final int fssai_no;
  final File fssai_certicate;
  final String bussiness_location;
  final String business_landmark;
  final File display_image;
  final bool is_Grocery;
  final bool is_restaurent;
  final String alternate_email;
  final int since;

  RegisterModel(
      {required this.owner_name,
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
      this.is_Grocery = false,
      this.is_restaurent = false,
      required this.alternate_email,
      required this.since
      });

      
}
