import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/services/preferences_service.dart';

class AddProdutoPage extends StatefulWidget {
  final VoidCallback onSave;
  const AddProdutoPage({super.key, required this.onSave});

  @override
  State<AddProdutoPage> createState() => _AddProdutoPageState();
}

class _AddProdutoPageState extends State<AddProdutoPage> {
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _precoProdutoController = TextEditingController();
  final TextEditingController _descricaoProdutoController =
      TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final PreferencesService _preferencesService = PreferencesService();
  List<Category> _categories = [];
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    List<Category> categories = await _preferencesService.getCategoria();
    setState(() {
      _categories = categories;
      if (categories.isNotEmpty) {
        _selectedCategory = categories.first;
      }
    });
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
      print("Erro ao selecionar imagem: $e");
    }
  }

  Future<File?> _saveImageLocally(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final savedImage = await image.copy('${directory.path}/$fileName');
      return savedImage;
    } catch (e) {
      print('Erro ao salvar imagem: $e');
      return null;
    }
  }

  Future<void> _addProduct() async {
    if (_nomeProdutoController.text.isNotEmpty &&
        _precoProdutoController.text.isNotEmpty &&
        _descricaoProdutoController.text.isNotEmpty &&
        _selectedImage != null &&
        _selectedCategory != null) {
      File? savedImage = await _saveImageLocally(_selectedImage!);
      if (savedImage != null) {
                int newId = await _preferencesService.getNextProductId();
        final newProduct = Product(
          id: newId,
          idCategoria:
              _selectedCategory!.id, // Usar o ID da categoria selecionada
          nome: _nomeProdutoController.text,
          preco: double.parse(_precoProdutoController.text),
          descricao: _descricaoProdutoController.text,
          picture: savedImage.path,
        );

        List<Product> products = await _preferencesService.getProduto();
        products.add(newProduct);
        await _preferencesService.setProduto(products);

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
        title: const Text('Novo Produto',
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
                    controller: _nomeProdutoController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shopping_basket_outlined,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onSurface),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Nome do produto',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _precoProdutoController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_money,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onSurface),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Preço do produto',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _descricaoProdutoController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.label_outline,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onSurface),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      labelText: 'Descrição do produto',
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.maxFinite,
                                    decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<Category>(
                    isExpanded: true,
                    value: _selectedCategory,
                    onChanged: (Category? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    items: _categories
                        .map<DropdownMenuItem<Category>>((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Text(category.titulo),
                        ),
                      );
                    }).toList(),
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
            onPressed: _addProduct,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text("Salvar", style: TextStyle(color: Colors.white)),
                Icon(Icons.save, color: Colors.white, opticalSize: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
