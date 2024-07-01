import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/objetos/product.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';
import 'package:listaplus/pages/add_categoria_page.dart';
import 'package:listaplus/pages/add_produto_page.dart';
import 'package:listaplus/pages/lista_desejo_page.dart';
import 'package:listaplus/services/preferences_service.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  CategoriasPageState createState() => CategoriasPageState();
}

class CategoriasPageState extends State<CategoriasPage> {
  late Future<List<Category>> futureCategory;
  final PreferencesService _preferencesService = PreferencesService();
  List<Category> _category = [];
  bool _showActionButtons = false;

  Future<void> _loadCategorys() async {
    final categorys = await _preferencesService.getCategoria();
    setState(() {
      _category = categorys;
    });
  }

  List<Product> _product = [];
  Future<void> _loadProducts() async {
    final products = await _preferencesService.getProduto();
    setState(() {
      _product = products;
    });
  }

  @override
  void initState() {
    _loadCategorys();
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 18,
                spacing: 14,
                children: _category
                    .map(
                        (category) => CardCategoria(category: category, products: _product,onPressed: () {_loadCategorys(); _loadCategorys();},))
                    .toList(),
              ),
            ),
          ),
          if (_showActionButtons)
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.centerRight,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    isExtended: true,
                    tooltip: "nova categoria",
                    heroTag: "nova categoria",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddCategoriaPage(
                            onSave: () {
                              _loadCategorys();
                              setState(() {
                                _showActionButtons = false;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.category),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    isExtended: true,
                    tooltip: "novo produto",
                    heroTag: "novo produto",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProdutoPage(
                            onSave: () {
                              _loadProducts();
                              setState(() {
                                _showActionButtons = false;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.add_shopping_cart),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Todas as categorias',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  AnimatedBottomNavigationBar bottomNavigationBar() {
    List<IconData> iconList = [
      Icons.home_outlined,
      Icons.shopping_bag_outlined,
      Icons.menu,
    ];
    int bottomNavIndex = 0;
    return AnimatedBottomNavigationBar(
      elevation: 15,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadow: BoxShadow(
        blurRadius: 4,
        color: Theme.of(context).shadowColor.withOpacity(0.05),
      ),
      icons: iconList,
      activeColor: Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
      activeIndex: bottomNavIndex,
      leftCornerRadius: 15,
      rightCornerRadius: 15,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.none,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriasPage()),
            );
            _showActionButtons = false;
            break;
          case 1:
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListaDesejoPage()),
            );
            _showActionButtons = false;
            break;
          case 2:
            setState(() {
              _showActionButtons = !_showActionButtons;
            });
            break;
          default:
        }
      },
    );
  }
}
