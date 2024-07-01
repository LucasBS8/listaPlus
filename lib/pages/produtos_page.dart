import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';

class ProdutosPage extends StatelessWidget {
  final List<Product> products;
  final int? selectedCategoryId;

  const ProdutosPage({
    Key? key,
    required this.products,
    this.selectedCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filtrar produtos se uma categoria foi selecionada
    final filteredProducts = selectedCategoryId == null
        ? products
        : products
            .where((product) => product.idCategoria == selectedCategoryId)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
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
