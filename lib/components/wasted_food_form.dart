import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wastegram/models/food_waste_dto.dart';
import 'package:wastegram/screens/waste_list_screen.dart';

class WastedFoodForm extends StatefulWidget {

  final url;

  const WastedFoodForm({Key? key, required this.url}) : super(key: key);

  @override
  State<WastedFoodForm> createState() => _WastedFoodFormState();

}

class _WastedFoodFormState extends State<WastedFoodForm> {
  final formKey = GlobalKey<FormState>();
  final wastedFoodEntryValue = WastedFoodDTO();

  @override
  void initState() {
    super.initState();
    wastedFoodEntryValue.photoURL = widget.url.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child:
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                itemQuantityField(context),
                saveButton(context),
                cancelButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemQuantityField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: 'Number of wasted items'),
        style: Theme.of(context).textTheme.displaySmall,
        validator: validateItemQuantity,
        onSaved: saveItemQuantity,
      ),
    );
  }


  String? validateItemQuantity(String? value) {
    int? validateValue = int.tryParse(value!);
    if(validateValue == null || validateValue < 1){
      return 'Please enter a valid number';
    } else {
      return null;
      }
    }

  void saveItemQuantity(String? value) {
    wastedFoodEntryValue.quantity = int.tryParse(value!)!;
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          WasteListScreenState wasteListScreen = WasteListScreenState();
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            wasteListScreen.addToCollection(
                wastedFoodEntryValue.date,
                wastedFoodEntryValue.photoURL,
                wastedFoodEntryValue.quantity,
                wastedFoodEntryValue.latitude,
                wastedFoodEntryValue.longitude);

            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return WasteListScreen();
                }));
          }
        },
        child: const Text('Save Entry'));
  }


  Widget cancelButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'));
  }



}
