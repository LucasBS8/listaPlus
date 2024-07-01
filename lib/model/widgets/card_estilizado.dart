import 'dart:io';
import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/pages/produtos_page.dart';
import 'package:listaplus/services/preferences_service.dart';

class CardProduto extends StatelessWidget {
  const CardProduto({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

class CardCategoria extends StatelessWidget {
  const CardCategoria(
      {super.key,
      required this.category,
      required this.products,
      required this.onPressed});
  final VoidCallback onPressed;
  final Category category;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Theme.of(context).hoverColor,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProdutosPage(
              products: products,
              selectedCategoryId: category.id,
              onSave: onPressed,
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
    );
  }
}

class CardListaDesejo extends StatelessWidget {
  CardListaDesejo({super.key, required this.product});
  final Product product;

  final PreferencesService prefsService = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
