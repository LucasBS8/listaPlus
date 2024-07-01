import 'dart:io';
import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/pages/produtos_page.dart';
import 'package:listaplus/services/preferences_service.dart';

class CardProduto extends StatelessWidget {
  const CardProduto({super.key, required this.product});
  final Product product;

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Produto'),
          content: Text('Você tem certeza que deseja excluir este produto?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                // Adicione aqui a lógica para excluir o produto
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(context);
      },
      child: Card(
        elevation: 0,
        child: SizedBox(
          width: 170,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 160,
                height: 140,
                child: Container(
                  padding: const EdgeInsetsDirectional.all(10),
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hoverColor,
                    image: DecorationImage(
                      image: FileImage(File(product.picture)),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Text(product.nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: double.maxFinite,
                child: Text('R\$${product.preco}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: double.maxFinite,
                  child: FilledButton.icon(
                    label: const Text('Add to bag',
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.solid)),
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Defina o raio aqui
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardCategoria extends StatelessWidget {
  const CardCategoria({super.key, required this.category, required this.products});
  final Category category;
  final List<Product> products;
  void _showDeleteDialog(BuildContext context) {
    final PreferencesService prefsService = PreferencesService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Categoria'),
          content: Text('Você tem certeza que deseja excluir esta categoria?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () async {
                                await prefsService.deleteCategoria(category.id);
                // Adicione aqui a lógica para excluir a categoria
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(context);
      },
      child: InkWell(
        hoverColor: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {

          Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProdutosPage(
              products: products,
              selectedCategoryId: category.id,
            ),
          ),
        );
        },
        child: Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Theme.of(context).shadowColor.withOpacity(0.05),
                blurRadius: 88,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 140,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(category.picture)),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 40,
                child: Text(
                  category.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardListaDesejo extends StatelessWidget {
  CardListaDesejo({super.key, required this.product});
  final Product product;

  final PreferencesService prefsService = PreferencesService();
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Produto da Lista de Desejos'),
          content: Text(
              'Você tem certeza que deseja excluir este produto da lista de desejos?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {

                //TODO: Adicione aqui a lógica para excluir o produto da lista de desejos
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(context);
      },
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(10)),
              height: 160,
              width: double.maxFinite,
              child: InkWell(
                hoverColor: Theme.of(context).hoverColor,
                onTap: () {},
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(product.picture)),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product.nome,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('R\$${product.preco}',
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          const Divider()
        ],
      ),
    );
  }
}
