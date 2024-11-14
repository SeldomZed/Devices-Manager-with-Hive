import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../base/res/media.dart';
import '../base/res/styles/app_styles.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => DevicesScreenState();
}

class DevicesScreenState extends State<DevicesScreen> {
  final myBox = Hive.box('Devices_Manager');
  List<String> deviceTypes = ['Pc', 'Téléphone', 'Tablette', 'Imprimante', 'Ecran', 'Playstation', 'Nintendo', 'Xbox'];
  String? typeEdit;
  void _deleteDevice(int index) {
    if (index >= 0 && index < myBox.length) {
      setState(() {
        myBox.deleteAt(index);
      });
    }
  }

  void _editDevice(int index) {
    final device = myBox.getAt(index) as Map;
    final TextEditingController editNameController = TextEditingController(text: device['name'] ?? '');
    final TextEditingController editPriceController = TextEditingController(text: device['price']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'appareil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editNameController,
                decoration: const InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z' éà]{1,17}")),
                ],
              ),
              DropdownButtonFormField<String>(
                value: typeEdit,
                decoration: const InputDecoration(labelText: 'Type'),
                items: deviceTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    typeEdit = value!;
                  });
                },
              ),
              TextField(
                controller: editPriceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{1,6}\.?\d{0,2}')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final updatedName = editNameController.text;
                final updatedPrice = double.tryParse(editPriceController.text);
                final updatedType = typeEdit ?? '';

                if (updatedName.isNotEmpty && updatedType.isNotEmpty && updatedPrice != null) {
                  // Update the device in the Hive box
                  myBox.putAt(index, {
                    'name': updatedName,
                    'type': updatedType,
                    'price': updatedPrice,
                  });

                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var bar = screenHeight * 0.055;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(bar),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: bar * 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradientText(
                  "My devices",
                  gradient: LinearGradient(colors: [
                    AppStyles.secondaryColor,
                    AppStyles.primaryColor,
                  ]),
                  style: TextStyle(
                    letterSpacing: 0.6,
                    fontSize: screenWidth * 0.075,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: screenWidth * 0.08),
                Container(
                  width: screenWidth * 0.14,
                  height: screenWidth * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppMedia.logo),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: myBox.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              itemCount: myBox.length,
              itemBuilder: (context, index) {
                final device = myBox.getAt(index) as Map;
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    title: Text(
                      device['name'] ?? '',
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        children: [
                          const TextSpan(text: 'type : ', style: TextStyle(color: Colors.blue)),
                          TextSpan(text: '${device['type'] ?? ''}', style: const TextStyle(color: Colors.black)),
                          const TextSpan(text: '   price : ', style: TextStyle(color: Colors.blue)),
                          TextSpan(text: '${device['price'] ?? ''}\$', style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.lightBlueAccent,
                            size: 26,
                          ),
                          onPressed: () {
                            _editDevice(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 26,
                          ),
                          onPressed: () => _deleteDevice(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No added device.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
