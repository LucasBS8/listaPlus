import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';
import 'package:listaplus/pages/categoria_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;

  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.dashboard_outlined,
    Icons.shopping_bag_outlined,
    Icons.menu
  ];
  int _bottomNavIndex = 0;
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt('counter', counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('counter') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Todos os produtos'),
      ),
      body: Center(
        child: Column(
          children: [
            CardProduto(
                product: Product(
                    id: 1,
                    nome: 'Produto 1',
                    preco: 10.0,
                    descricao: 'Descrição do produto 1',
                    picture: 'assets/images/image1.png')),
            CardCategoria(
                category: Category(
                    id: 1,
                    titulo: "dfdww",
                    descricao: "svdefbebeffeb",
                    picture: "assets/images/image1.png"))
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          elevation: 15,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shadow: const BoxShadow(blurRadius: 5, offset: Offset(5, 5)),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          leftCornerRadius: 15,
          rightCornerRadius: 15,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoriaPage()),
                );
                break;

              default:
            }
          }),
    );
  }
}
