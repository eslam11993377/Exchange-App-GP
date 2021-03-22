import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropListCategories extends StatefulWidget {
  @override
  _DropListCategoriesState createState() => _DropListCategoriesState();
}

class _DropListCategoriesState extends State<DropListCategories> {
  String category = 'كتب';
  List<String> servicesProperties = ["نوع الخدمة"];
  List<String> carsProperties = [
    "الناقل الحركى",
    "السنة",
    "كيلومترات",
    "هيكل ",
    "اللون",
    "المحرك",
    "الحالة",
    "الموديل",
    "النوع"
  ];
  List<String> mobileProperties = ["الماركة"];
  List<String> bookProperties = ["نوع الكتاب"];
  List<String> gamesProperties = ["النوع"];
  List<String> electricDevicesProperties = ["الماركة"];
  List<String> animalsProperties = ["نوع الحيوان", "السن"];
  List<String> homeProperties = ["نوع الاثاث"];
  List<String> clothesProperties = ["نوع الملبس"];
  List<String> othersProperties = ["النوع"];

  List<Widget> _buildproperties(List<String> properties) {
    List<Widget> textForFields = [];
    for (String property in properties) {
      textForFields.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              maxLength: 30,
              decoration: InputDecoration(
                labelText: property,
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]),
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'مطلوب';
                }
                return null;
              },
              onSaved: (String value) {
                property = value;
              },
            ),
          ),
        ),
      );
    }
    return textForFields;
  }

  List<String> getProperties(String category) {
    List<String> listOfAddedProperties = [];
    if (category == "خدمات") {
      listOfAddedProperties = servicesProperties;
    } else if (category == "عربيات") {
      listOfAddedProperties = carsProperties;
    } else if (category == "موبايلات") {
      listOfAddedProperties = mobileProperties;
    } else if (category == "كتب") {
      listOfAddedProperties = bookProperties;
    } else if (category == "ألعاب إلكترونية") {
      listOfAddedProperties = gamesProperties;
    } else if (category == "أجهزة كهربائية") {
      listOfAddedProperties = electricDevicesProperties;
    } else if (category == "حيوانات") {
      listOfAddedProperties = animalsProperties;
    } else if (category == "أثاث منزل") {
      listOfAddedProperties = homeProperties;
    } else if (category == "ملابس") {
      listOfAddedProperties = clothesProperties;
    } else {
      listOfAddedProperties = othersProperties;
    }
    return listOfAddedProperties;
  }

  @override
  Widget build(BuildContext context) {
    List<String> listOfAddedProperties = getProperties(category);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButton<String>(
              isExpanded: true,
              value: category,
              style: GoogleFonts.cairo(color: Colors.black54),
              underline: Container(
                height: 1,
                color: Colors.blue[400],
              ),
              onChanged: (String newValue) {
                setState(() {
                  category = newValue;
                  listOfAddedProperties = getProperties(category);
                });
              },
              items: <String>[
                "اخري",
                "خدمات",
                "عربيات",
                "موبايلات",
                "كتب",
                "ألعاب إلكترونية",
                "أجهزة كهربائية",
                "حيوانات",
                "أثاث منزل",
                "ملابس",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                      alignment: Alignment.centerRight, child: Text(value)),
                );
              }).toList(),
            ),
          ),
        ),
        Column(
          children: _buildproperties(listOfAddedProperties),
        ),
      ],
    );
  }
}
