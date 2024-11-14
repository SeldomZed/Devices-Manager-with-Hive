import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class AddDevicesScreen extends StatefulWidget {
  const AddDevicesScreen({super.key});

  @override
  State<AddDevicesScreen> createState() => AddDevicesScreenState();
}

class AddDevicesScreenState extends State<AddDevicesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final myBox = Hive.box('Devices_Manager');
  List<String> deviceTypes = ['Pc', 'Téléphone', 'Tablette', 'Imprimante', 'Ecran', 'Playstation', 'Nintendo', 'Xbox'];
  String? selectedType;

  void _addDevice() {
    final String name = nameController.text;
    final String type = selectedType ?? '';
    final String priceText = priceController.text;
    final double? price = double.tryParse(priceText);

    if (name.isNotEmpty && type.isNotEmpty && price != null) {
      myBox.add({
        'name': name,
        'type': type,
        'price': price,
      });

      nameController.clear();
      priceController.clear();
      setState(() {
        selectedType = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Device added successfully!',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.lightBlueAccent,
          duration: Duration(milliseconds: 850),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez remplir tous les champs avec des valeurs valides',
            style: TextStyle(fontSize: 20),
          ),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un appareil',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z' éà]{1,17}")),
              ],
            ),
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: deviceTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{1,6}\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDevice,
              child: const Text(
                'Ajouter',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
