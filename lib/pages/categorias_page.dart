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
  List<IconData> iconList = [
    Icons.home_outlined,
    Icons.dashboard_outlined,
    Icons.shopping_bag_outlined,
    Icons.menu,
  ];
  int bottomNavIndex = 0;
Future<List<Category>> categorias = PreferencesService.getCategoria();
  @override
  void initState() {
    futureCategory = PreferencesService.getCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Todas as categorias',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: futureCategory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Category category = snapshot.data![index];
                  return CardCategoria(
                    category: category,
                  );
                },
              );
            } else {
              return const Text("No categories found");
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 15,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadow: BoxShadow(
          blurRadius: 4,
          color: Theme.of(context).shadowColor.withOpacity(0.05),
        ),
        icons: iconList,
        activeColor:
            Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaDesejoPage()),
              );
              break;
            default:
          }
        },
      ),
    );
  }
}
