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
  String? selectWight;
  String? selectKg;
  String? selectPrice;
  String? selectQuantity;
  bool OfferProduct = false;
  bool PopularProduct = false;
  bool markProduct = false;

  List<String> categories = ["Electronics", "Clothing", "Groceries"];
  List<String> subCategories = ["Phones", "Laptops", "Accessories"];
  List<String> colors = ["Red", "yellow", "green"];
  List<String> weight = ["67", "43", "88"];
  List<String> kg = ["g", "kg", "mm"];
  List<String> price = ["500", "100", "10000"];
  List<String> Quantity = ["500", "100", "10000"];
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
              SizedBox(height: height*0.013),
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
              SizedBox(height: height*0.013),
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
              SizedBox(height: height*0.013),
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
              SizedBox(height: height*0.013),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: 'WholesalePrice',
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
              SizedBox(height: height*0.013),
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
              SizedBox(height: height*0.013),
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
              SizedBox(height: height*0.013),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  hintText: "Weight Measurement",
                  hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: OrderColor.black
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
              SizedBox(height: height*0.013),
              Row(
               children: [
                 Container(
                   height: height*0.076,
                   width: width*0.94,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(width*0.015),
                       border: Border.all(
                           color: OrderColor.borderColor.withOpacity(0.17)
                       )
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('OfferProduct'),
                         Switch(
                           activeColor: OrderColor.white, // Thumb color when ON
                           activeTrackColor: OrderColor.blue, // Track color when ON
                           inactiveThumbColor: OrderColor.white, // Thumb color when OFF
                           inactiveTrackColor: OrderColor.borderColor.withOpacity(0.3),
                           trackOutlineColor: WidgetStateColor.transparent ,
                           value: OfferProduct,
                           onChanged: (value) {
                             setState(() {
                               OfferProduct = value;
                             });
                           },
                         ),
                       ],
                     ),
                   )
                 ),
               ],
              ),
              SizedBox(height: height*0.013),
              Row(
               children: [
                 Container(
                   height: height*0.076,
                   width: width*0.94,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(width*0.015),
                       border: Border.all(
                           color: OrderColor.borderColor.withOpacity(0.17)
                       )
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('Popular Product'),
                         Switch(
                           activeColor: OrderColor.white, // Thumb color when ON
                           activeTrackColor: OrderColor.blue, // Track color when ON
                           inactiveThumbColor: OrderColor.white, // Thumb color when OFF
                           inactiveTrackColor: OrderColor.borderColor.withOpacity(0.3),
                           trackOutlineColor: WidgetStateColor.transparent ,
                           value: PopularProduct,
                           onChanged: (value) {
                             setState(() {
                               PopularProduct = value;
                             });
                           },
                         ),
                       ],
                     ),
                   )
                 ),
               ],
              ),
              SizedBox(height: height*0.015),
              Padding(
                padding:  EdgeInsets.only(
                  left: width*0.02,
                  right: width*0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select weight Variant',style: GoogleFonts.nunito(
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
              SizedBox(height: height*0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectWight,
                      decoration: InputDecoration(
                        hintText: "Weight",
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
                      items: weight.map((String weight) {
                        return DropdownMenuItem<String>(
                          value: weight,
                          child: Text(weight),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectWight = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: width*0.02),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectKg,
                      decoration: InputDecoration(
                        hintText: "Kg",
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
                      items: kg.map((String kg) {
                        return DropdownMenuItem<String>(
                          value: kg,
                          child: Text(kg),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectKg = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: width*0.02),
                  Container(
                    height: height*0.076,
                    width: width*0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width*0.015),
                        border: Border.all(
                            color: OrderColor.borderColor.withOpacity(0.17)
                        )
                    ),
                    child: Center(
                      child: Text('${selectWight}\n${selectKg}'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.013),
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
                          hintText: "Price",
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
                        items: price.map((String price) {
                          return DropdownMenuItem<String>(
                            value: price,
                            child: Text(price),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectPrice = newValue;
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
                        child: Text('$selectPrice'),
                      ),
                    ),
                    SizedBox(width: width*0.03),
                    Icon(Icons.cancel_outlined,color: OrderColor.borderColor.withOpacity(0.3),)
                  ],
                ),
              ),
              SizedBox(height: height*0.013),
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
                          hintText: "Quantity",
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
                        items: Quantity.map((String quantity) {
                          return DropdownMenuItem<String>(
                            value: quantity,
                            child: Text(quantity),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectQuantity = newValue;
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
                        child: Text('$selectQuantity'),
                      ),
                    ),
                    SizedBox(width: width*0.03),
                    Icon(Icons.cancel_outlined,color: OrderColor.borderColor.withOpacity(0.3),)
                  ],
                ),
              ),
              SizedBox(height: height*0.013),
              Row(
                children: [
                  Container(
                      height: height*0.076,
                      width: width*0.94,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.015),
                          border: Border.all(
                              color: OrderColor.borderColor.withOpacity(0.17)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mark Product in stock'),
                            Switch(
                              activeColor: OrderColor.white, // Thumb color when ON
                              activeTrackColor: OrderColor.blue, // Track color when ON
                              inactiveThumbColor: OrderColor.white, // Thumb color when OFF
                              inactiveTrackColor: OrderColor.borderColor.withOpacity(0.3),
                              trackOutlineColor: WidgetStateColor.transparent ,
                              value: markProduct,
                              onChanged: (value) {
                                setState(() {
                                  markProduct = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: height*0.03),
              Container(
                height: height*0.076,
                width: width*0.94,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width*0.017),
                  color: OrderColor.green
                ),
                child: Center(
                  child: Text('Add to Product',style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: OrderColor.white
                  ),),
                ),
              ),
              SizedBox(height: height*0.015),
            ],
          ),
        ),
      ),
    );
  }
}
