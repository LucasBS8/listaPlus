import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:listaplus/model/objetos/category.dart';
import 'package:listaplus/model/widgets/card_estilizado.dart';
import 'package:listaplus/pages/add_categoria_page.dart';
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

  Future<void> _loadCategorys() async {
    List<Category> categorys = await _preferencesService.getCategoria();
    setState(() {
      _category = categorys;
    });
  }

  @override
  void initState() {
    _loadCategorys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.maxFinite,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 18,
            spacing: 14,
            children: _category
                .map((category) => CardCategoria(category: category))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCategory = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoriaPage()),
          );

          if (newCategory != null) {
            setState(() {
              _category.add(newCategory);
            });
          }
        },
        child: const Icon(Icons.add),
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
      Icons.dashboard_outlined,
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
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCategoriaPage()),
            );
            break;
          case 2:
            MenuBar(
              children: [
                MenuItemButton(
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'MenuBar Sample',
                        applicationVersion: '1.0.0',
                      );
                    },
                    child: null),
              ],
            );
            break;
          default:
        }
      },
    );
  }
}
