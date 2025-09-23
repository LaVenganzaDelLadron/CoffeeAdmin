import 'dart:io';
import 'package:admincoffee/controller/add_product_controller.dart';
import 'package:admincoffee/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _status = "active";
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

Future<void> _pickImage() async {
  final picked = await _picker.pickImage(source: ImageSource.gallery);
  if (picked != null) {
    print("[DEBUG] Image Picked: ${picked.path}");
    setState(() {
      _imageFile = File(picked.path);
    });
  } else {
    print("[DEBUG] No image selected");
  }
}

Future<void> _submit() async {
  if (_formKey.currentState!.validate()) {
    if (_imageFile == null) {
      print("[DEBUG] Form submit blocked → No image uploaded");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload an image")),
      );
      return;
    }

    final adminId =
        AuthController.instance.currentAdmin.value?.id.toString() ?? "0";

    print("[DEBUG] Submitting product form → adminId=$adminId");

    await AddProductController.instance.addProduct(
      _nameController.text,
      _descController.text,
      _categoryController.text,
      double.tryParse(_priceController.text) ?? 0,
      adminId,
      _imageFile!,
    );

    _formKey.currentState!.reset();
    setState(() {
      _imageFile = null;
      _status = "active";
    });
    print("[DEBUG] Form reset after submission");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Coffee Product"),
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Product Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter product name" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter description" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter category" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    prefixText: "₱ ",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter price" : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _status,
                  items: const [
                    DropdownMenuItem(value: "active", child: Text("Active")),
                    DropdownMenuItem(value: "inactive", child: Text("Inactive")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                _imageFile == null
                    ? TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Upload Image"),
                      )
                    : Column(
                        children: [
                          Image.file(_imageFile!,
                              height: 150, fit: BoxFit.cover),
                          TextButton(
                            onPressed: _pickImage,
                            child: const Text("Change Image"),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
