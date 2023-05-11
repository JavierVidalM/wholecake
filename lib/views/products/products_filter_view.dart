import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';

import '../../services/productos_services.dart';

class ProductSearch extends SearchDelegate<Listado> {
  final listadoView = Provider.of<ProductService>;

  List<Listado> _filter = [];

  late final List<Listado> prod;

  ProductSearch(this.prod);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          // close(
          // context,
          // Listado(
          //     productoId: 48,
          //     nombre: '',
          //     fechaElaboracion: '',
          //     fechaVencimiento: '',
          //     precio: '',
          //     categoria: '',
          //     imagen: ''));
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // _filter = prod.where((element) {}.toList());
    return Center();
  }
}

// class ProductFilter extends StatelessWidget {
//   const ProductFilter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Filtro"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height * 0.02,
//             left: MediaQuery.of(context).size.width * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Text("Categoría"), Text("Fecha de elaboración")],
//         ),
//       ),
//     );
//   }
// }
