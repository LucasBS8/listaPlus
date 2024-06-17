import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';

class ListaDesejoPage extends StatefulWidget {
  const ListaDesejoPage({super.key});

  @override
  State<ListaDesejoPage> createState() => _ListaDesejoPageState();
}

class _ListaDesejoPageState extends State<ListaDesejoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de desejos',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            CardListaDesejo(product: Product(descricao: "Nestle Nido Full Cream Milk Powder Instant", id: 1,idCategoria: 1,nome: "wswdf", picture: "assets/images/image1.png",preco: 10.0),)
          ]
        ),
      ),
    );
  }
}