import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:listaplus/services/preferences_service.dart';

class EditCategoriaPage extends StatefulWidget {
  final Category category;
  final VoidCallback onSave;
  const EditCategoriaPage(
      {super.key, required this.category, required this.onSave});

  @override
  State<EditCategoriaPage> createState() => _EditCategoriaPageState();
}

class _EditCategoriaPageState extends State<EditCategoriaPage> {
  final TextEditingController _nomeCategoriaController =
      TextEditingController();
  final TextEditingController _descricaoCategoriaController =
      TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final PreferencesService _preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _nomeCategoriaController.text = widget.category.titulo;
    _descricaoCategoriaController.text = widget.category.descricao;
    _selectedImage = File(widget.category.picture);
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }

  Future<File?> _saveImageLocally(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final savedImage = await image.copy('${directory.path}/$fileName');
      print('Imagem salva em: ${savedImage.path}');
      return savedImage;
    } catch (e) {
      print('Erro ao salvar imagem: $e');
      return null;
    }
  }

  Future<void> _editCategory() async {
    if (_nomeCategoriaController.text.isNotEmpty &&
        _descricaoCategoriaController.text.isNotEmpty &&
        _selectedImage != null) {
      File? savedImage = await _saveImageLocally(_selectedImage!);
      if (savedImage != null) {
        final updatedCategory = Category(
          id: widget.category.id,
          titulo: _nomeCategoriaController.text,
          descricao: _descricaoCategoriaController.text,
          picture: savedImage.path,
        );

        List<Category> categories = await _preferencesService.getCategoria();
        final index =
            categories.indexWhere((cat) => cat.id == widget.category.id);
        if (index != -1) {
          categories[index] = updatedCategory;
          await _preferencesService.setCategoria(categories);
        }

        widget.onSave();
        Navigator.of(context).pop();
      }
    } else {
      print("Todos os campos são obrigatórios.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Categoria',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                            : Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                                height: double.maxFinite,
                              ),
                      ),
                    ),
                  ),
                ),
              ]
                  .map((e) =>
                      Padding(padding: const EdgeInsets.all(15), child: e))
                  .toList(),
            ),
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
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor:
                  Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: _editCategory,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Salvar Categoria"),
                Icon(Icons.save_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
