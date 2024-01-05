import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:dto/articles.dart';
import 'package:dto/user.dart';
import 'package:dymatestflutter/material/gradientbtn.dart';
import 'package:dymatestflutter/services/articlesservices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class addorderview extends StatefulWidget {
  static const routeName = "addorderview";
  const addorderview({super.key});

  @override
  State<addorderview> createState() => _addorderviewState();
}

class _addorderviewState extends State<addorderview> {
  File? _image;

  final articleName = TextEditingController();
  final descriptionName = TextEditingController();
  final prix = TextEditingController();
  String selectedValue = "Cooking";

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text("Nouvelle objet"),
      ),
      body: Container(
        color: Colors.lightGreen[100],
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                    child: Card(
                  child: SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: _image == null
                          ? const Column(
                              children: [
                                SizedBox(
                                  height: 25.0,
                                ),
                                Icon(
                                  Icons.image,
                                  size: 75.0,
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Text("No image as \n selected yet")
                              ],
                            )
                          : Image.file(_image!),
                    ),
                  ),
                )),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: articleName,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: "Nom de votre article",
                        prefixIcon: Icon(Icons.article)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter an email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white),
                    child: DropdownButton<String>(
                      underline: Container(),
                      isExpanded: true,
                      value: selectedValue,
                      items: <String>["Cooking", "Garden", "Hobbies", "House"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: DateTimeField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Date d'expiration",
                        ),
                        selectedDate: selectedDate,
                        onDateSelected: (DateTime value) {
                          setState(() {
                            selectedDate = value;
                          });
                          // La date sélectionnée est mise à jour ici
                          print('Selected Date: $value');
                        },
                        dateFormat: DateFormat("dd/MM/yyyy"),
                        mode: DateTimeFieldPickerMode.date,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: descriptionName,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: "Entrez une description",
                            prefixIcon: Icon(Icons.description)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter an email";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: prix,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                            hintText: "Prix", prefixIcon: Icon(Icons.euro)),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    gradientBtn(
                        onPressed: () {
                          articlesServices accesDb =
                              articlesServices(Uid: user.uid!);
                          accesDb.saveArticle(
                              Article(
                                name: articleName.text,
                                image: _image!.path,
                                description: descriptionName.text,
                                activity: selectedValue == 'Cooking'
                                    ? Activity.cooking
                                    : selectedValue == 'Garden'
                                        ? Activity.garden
                                        : selectedValue == 'Hobbies'
                                            ? Activity.hobby
                                            : selectedValue == 'House'
                                                ? Activity.house
                                                : Activity.cooking,
                                Uid: user.uid!,
                              ),
                              _image!);
                        },
                        borderRadius: BorderRadius.circular(100.0),
                        height: 60.0,
                        width: 200.0,
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                        ),
                        child: const Text(
                          "Publier",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
