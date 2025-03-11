import 'package:fastbag_vendor_flutter/Commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Commons/localvariables.dart';

class AddGroceryProduct extends StatefulWidget {
  const AddGroceryProduct({super.key});

  @override
  State<AddGroceryProduct> createState() => _AddGroceryProductState();
}

class _AddGroceryProductState extends State<AddGroceryProduct> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedColor;

  List<String> categories = ["Electronics", "Clothing", "Groceries"];
  List<String> subCategories = ["Phones", "Laptops", "Accessories"];
  List<String> colors = ["Red", "yellow", "green"];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OrderColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: OrderColor.backGroundColor,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
        centerTitle: true,
        title: Text('Add product',style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'ProductName',
                    hintStyle: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: OrderColor.textColor
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor.withOpacity(0.17)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    )),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'DescribeTheProduct',
                    hintStyle: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: OrderColor.textColor
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor.withOpacity(0.17)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    )),
              ),
              Container(
                height: height*0.3,
                width: width*1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width*0.02),
                  border: Border.all(
                    color: OrderColor.borderColor.withOpacity(0.17)
                  ),
                ),
                child: Center(
                  child: Text('Uoload Image'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        hintText: "Category",
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: OrderColor.textColor
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.015),
                          borderSide: BorderSide(
                            color: OrderColor.borderColor.withOpacity(0.17)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.015),
                            borderSide: BorderSide(
                                color: OrderColor.borderColor.withOpacity(0.17)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.015),
                            borderSide: BorderSide(
                                color: OrderColor.borderColor.withOpacity(0.17)
                            )
                        ),
                      ),
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: width*0.03),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedSubCategory,
                      decoration: InputDecoration(
                        hintText: "Sub Category",
                        hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          color: OrderColor.textColor
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.015),
                            borderSide: BorderSide(
                                color: OrderColor.borderColor.withOpacity(0.17)
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.015),
                            borderSide: BorderSide(
                                color: OrderColor.borderColor.withOpacity(0.17)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.015),
                            borderSide: BorderSide(
                                color: OrderColor.borderColor.withOpacity(0.17)
                            )
                        ),
                      ),
                      items: subCategories.map((String subcategory) {
                        return DropdownMenuItem<String>(
                          value: subcategory,
                          child: Text(subcategory),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubCategory = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'Stock Unit',
                    hintStyle: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: OrderColor.textColor
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor.withOpacity(0.17)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    )),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'Product Price(IN)',
                    hintStyle: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: OrderColor.textColor
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor.withOpacity(0.17)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    )),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'DiscountPrice(Optional)',
                    hintStyle: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: OrderColor.textColor
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor.withOpacity(0.17)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.015),
                      borderSide:
                      BorderSide(color: OrderColor.borderColor),
                    )),
              ),
              Padding(
                padding:  EdgeInsets.only(
                  left: width*0.02,
                  right: width*0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Variant',style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: OrderColor.black
                    ),),
                    Row(
                      children: [
                        Icon(Icons.add,color: OrderColor.black,size: width*0.05,),
                        Text('New Rule',style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: OrderColor.black
                        ))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                  right: width*0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedColor,
                        decoration: InputDecoration(
                          hintText: "color Name",
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OrderColor.textColor
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                        ),
                        items: colors.map((String color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedColor = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: width*0.03),
                    Container(
                      height: height*0.076,
                      width: width*0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width*0.015),
                        border: Border.all(
                          color: OrderColor.borderColor.withOpacity(0.17)
                        )
                      ),
                      child: Center(
                        child: Text('$selectedColor'),
                      ),
                    ),
                    SizedBox(width: width*0.03),
                    Icon(Icons.cancel_outlined,color: OrderColor.borderColor.withOpacity(0.3),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: height*0.3,
                      width: width*1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width*0.02),
                        border: Border.all(
                            color: OrderColor.borderColor.withOpacity(0.17)
                        ),
                      ),
                      child: Center(
                        child: Text('Uoload Image'),
                      ),
                    ),
                  ),
                  SizedBox(width: width*0.03,),
                  Icon(Icons.cancel_outlined,color: OrderColor.borderColor.withOpacity(0.3),)
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(
                  left: width*0.02,
                  right: width*0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Size',style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: OrderColor.black
                    ),),
                    Row(
                      children: [
                        Icon(Icons.add,color: OrderColor.black,size: width*0.05,),
                        Text('New Rule',style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: OrderColor.black
                        ))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                  right: width*0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedColor,
                        decoration: InputDecoration(
                          hintText: "Size Name",
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OrderColor.textColor
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                        ),
                        items: colors.map((String color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedColor = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: width*0.02),
                    Container(
                      height: height*0.076,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.015),
                          border: Border.all(
                              color: OrderColor.borderColor.withOpacity(0.17)
                          )
                      ),
                      child: Center(
                        child: Text('$selectedColor'),
                      ),
                    ),
                    SizedBox(width: width*0.02),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedColor,
                        decoration: InputDecoration(
                          hintText: "Size Name",
                          hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OrderColor.textColor
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width*0.015),
                              borderSide: BorderSide(
                                  color: OrderColor.borderColor.withOpacity(0.17)
                              )
                          ),
                        ),
                        items: colors.map((String color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedColor = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: width*0.02),
                    Container(
                      height: height*0.076,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.015),
                          border: Border.all(
                              color: OrderColor.borderColor.withOpacity(0.17)
                          )
                      ),
                      child: Center(
                        child: Text('$selectedColor'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: height*0.076,
                      width: width*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.015),
                          border: Border.all(
                              color: OrderColor.borderColor.withOpacity(0.17)
                          )
                      ),
                      child: Center(
                        child: Text('$selectedColor'),
                      ),
                    ),
                  ),
                  SizedBox(width: width*0.03,),
                  Expanded(
                    child: Container(
                      height: height*0.076,
                      width: width*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.015),
                          border: Border.all(
                              color: OrderColor.borderColor.withOpacity(0.17)
                          )
                      ),
                      child: Center(
                        child: Text('$selectedColor'),
                      ),
                    ),
                  ),
                  SizedBox(width: width*0.03,),
                  Icon(Icons.cancel_outlined,color: OrderColor.borderColor.withOpacity(0.3),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
