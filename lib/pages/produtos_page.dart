import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os produtos'),
      ),
      body: Center(
        child: Column(children: [
          CardProduto(
              product: Product(
                  id: 1,
                  idCategoria: 1,
                  preco: 10.1,
                  nome: 'Produto 1',
                  descricao: 'Descrição do produto 1',
                  picture: 'assets/images/image1.png')),
        ]),
      ),
    );
  }
}
