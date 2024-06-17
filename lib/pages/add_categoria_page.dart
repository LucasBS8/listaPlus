import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/services/preferences_service.dart';

class AddCategoriaPage extends StatefulWidget {
  const AddCategoriaPage({super.key});

  @override
  State<AddCategoriaPage> createState() => _AddCategoriaPageState();
}

class _AddCategoriaPageState extends State<AddCategoriaPage> {
  final TextEditingController _nomeCategoriaController =
      TextEditingController();
  final TextEditingController _descricaoCategoriaController =
      TextEditingController();
  final ImagePicker picker = ImagePicker();
  dynamic _selectedImage;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (kIsWeb) {
            _selectedImage = pickedFile.path;
          } else {
            _selectedImage = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _saveImageLocally(File image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final savedImage = await image.copy('${appDir.path}/$fileName');
      setState(() {
        _selectedImage = savedImage;
      });
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> _addCategory() async {
    if (_nomeCategoriaController.text.isNotEmpty &&
        _descricaoCategoriaController.text.isNotEmpty) {
      if (_selectedImage != null) {
        if (!kIsWeb && _selectedImage is File) {
          await _saveImageLocally(_selectedImage);
        }
        Category category =
          Category(
            titulo: _nomeCategoriaController.text,
            descricao: _descricaoCategoriaController.text,
            picture: kIsWeb ? _selectedImage : (_selectedImage as File).path,
          );
        await PreferencesService.setCategoria(category);
        _descricaoCategoriaController.clear();
        _nomeCategoriaController.clear();
        setState(() {
          _selectedImage = null;
        });
        print(_selectedImage);
      } else {
        print('No image selected');
      }
    } else {
      print('Fields cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Categoria',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _nomeCategoriaController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.shopping_basket_outlined,
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .onSurface),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Nome da categoria',
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _descricaoCategoriaController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.label_outline,
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .onSurface),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Descrição da categoria',
                  ),
                ),
              ),
              InkWell(
                hoverColor: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(8),
                onTap: _pickImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [10, 10, 10, 10],
                  stackFit: StackFit.loose,
                  strokeWidth: 1,
                  radius: const Radius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).hoverColor,
                    ),
                    width: double.maxFinite,
                    height: 200,
                    child: Center(
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo_outlined,
                                    size: 63,
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .onSurface),
                                const Text("Upload images here")
                              ],
                            )
                          : kIsWeb
                              ? Image.network(
                                  _selectedImage,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                )
                              : Image.file(
                                  _selectedImage,
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                ),
                    ),
                  ),
                ),
              )
            ]
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor:
                  Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: _addCategory,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text("Salvar", style: TextStyle(color: Colors.white)),
                Icon(
                  Icons.save,
                  color: Colors.white,
                  opticalSize: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
