import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/pages/edit_categoria_page.dart';
import 'package:listaplus/services/preferences_service.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';

class ProdutosPage extends StatelessWidget {
  final List<Product> products;
  final int? selectedCategoryId;
  final VoidCallback onSave;

  const ProdutosPage({
    Key? key,
    required this.products,
    this.selectedCategoryId,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferencesService prefsService = PreferencesService();

    final filteredProducts = selectedCategoryId == null
        ? products
        : products
            .where((product) => product.idCategoria == selectedCategoryId)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) async {
              if (result == 'edit' && selectedCategoryId != null) {
                final category =
                    await prefsService.getCategoriaById(selectedCategoryId!);
                if (category != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditCategoriaPage(
                        category: category,
                        onSave: () {
                          onSave();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                }
              } else if (result == 'delete' && selectedCategoryId != null) {
                await prefsService.deleteCategoria(selectedCategoryId!);
                onSave();
                Navigator.of(context).pop();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Editar'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Excluir'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return CardProduto(product: filteredProducts[index]);
          },
        ),
      ),
    );
  }
}
