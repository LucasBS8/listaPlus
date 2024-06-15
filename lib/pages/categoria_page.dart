import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoriaPage extends StatefulWidget {
  const AddCategoriaPage({super.key});

  @override
  State<AddCategoriaPage> createState() => _AddCategoriaPageState();
}

class _AddCategoriaPageState extends State<AddCategoriaPage> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Categoria'),
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.shopping_basket_outlined),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Nome da categoria',
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius:     BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.label_outline),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: 'Nome da categoria',
                  ),
                ),
              ),
              InkWell(
                hoverColor: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: [10, 10, 10, 10],
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined, size: 63),
                          Text("Upload images here")
                        ],
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
              textStyle: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
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
