import 'package:bd_ejemplo/models/productos_model.dart';
import 'package:bd_ejemplo/services/productos_database.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: ProductosDatabase.instance.getAllProductos(), 
        builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No hay productos para visualizar')
                ],
              ),
            );
          }else{
            var productos = snapshot.data;
            if(productos!.isEmpty){
              return Center(child: const Text('Tabla productos vacio'));
            }else{
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: size.height * 1,
                    width: size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context,index) => const Divider(),
                          itemCount: productos.length,
                          itemBuilder: (context,index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Row(
                                  children: [
                                    Text(productos[index].codigo.toString()),
                                    Text(" --> "),
                                    Text(productos[index].nombre)
                                  ],
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        }
      ),
    );
  }
}