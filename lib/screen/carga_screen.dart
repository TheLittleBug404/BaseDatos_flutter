import 'package:bd_ejemplo/services/productos_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CargaScreen extends StatefulWidget {
  const CargaScreen({super.key});

  @override
  State<CargaScreen> createState() => _CargaScreenState();
}

class _CargaScreenState extends State<CargaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Bar')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              const Text('Carga Screen'),
              MaterialButton(
                onPressed: () async {
                  await crearDB(context);
                },
                color: Colors.cyanAccent.shade100,
                child: const Text('Crear BD'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> crearDB(BuildContext context) async {
    Database db = await ProductosDatabase.instance.database;
    String sql = '''
                    INSERT INTO producto(id,nombre,cantidad)
                    VALUES(?,?,?);
                  ''';
    /*List<Map> data = [
      {'codigo': 111, 'id': 1, 'nombre': 'Detergente0', 'cantidad': 12},
      {'codigo': 112, 'id': 2, 'nombre': 'DetergenteA', 'cantidad': 2},
      {'codigo': 113, 'id': 3, 'nombre': 'DetergenteB', 'cantidad': 22},
      {'codigo': 114, 'id': 4, 'nombre': 'DetergenteC', 'cantidad': 112},
      {'codigo': 115, 'id': 5, 'nombre': 'DetergenteD', 'cantidad': 122},
    ];*/
    List<Map> data = [
      {'id': 1, 'nombre': 'Detergente0', 'cantidad': 12},
      {'id': 2, 'nombre': 'DetergenteA', 'cantidad': 2},
      {'id': 3, 'nombre': 'DetergenteB', 'cantidad': 22},
      {'id': 4, 'nombre': 'DetergenteC', 'cantidad': 112},
      {'id': 5, 'nombre': 'DetergenteD', 'cantidad': 122},
    ];
    //si le colocamos un forEach a nuestro data le hara un insert a cada elemento que tenemos en nuestro data
    //data.forEach((element) async{
    //await db.delete('producto');
    for (var element in data) {
      // en el insert le colocamos la consulta que sera el sql
      await db.rawInsert(sql, [
        //element['codigo'],
        element['id'],
        element['nombre'],
        element['cantidad'],
      ]);
    }
    if (mounted) {
      Navigator.popAndPushNamed(context, 'dashboard');
    }
  }
}
