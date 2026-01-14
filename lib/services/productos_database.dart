import 'package:bd_ejemplo/models/card_item_model.dart';
import 'package:bd_ejemplo/models/productos_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductosDatabase{
    //generamos la instancia y la iniciamos
    static final ProductosDatabase instance = ProductosDatabase._init();

    static Database? _database;
    //iniciamos la base de datos
    ProductosDatabase._init();
    //tenemos que hacer un llamado a la base de datos para saber si existe o no 
    Future<Database> get database async{
        if(_database != null) return _database!;  

        // si no existe la base de datos entonces nosotros iniciamos la base de datos con el nombre pepito.db para este ejemplo
        _database = await _initDB('pepito.db');
        return _database!;
    }
    //para este metodo necesitamos el file path que es en donde estara la base de datos 
    Future<Database> _initDB(String filePath) async{
        //getDatabasesPath es un metodo que nos traera donde esta el path de la base de datos
        //aca obtenemos el path de pepito.db que nosotros le colocamos en el anterior metodo pero esto es en caso de que no se tenga la base de datos
        final dbPath = await getDatabasesPath();
        //este path lo uniremos con la base de datos esto es para diferenciarlas de las otras bases de datos
        final path = join(dbPath,filePath);
        return await openDatabase(
            path,
            version: 1,// si se llega a modificar la base de datos como agregar alguna columna o tabla se debe cambiar la version
            onCreate: _onCreateDB
        );
    }
    Future _onCreateDB(Database db, int version) async{
        db.execute('''
        CREATE TABLE producto(
            codigo INTEGER PRIMARY KEY AUTOINCREMENT,
            id  INTEGER,
            nombre TEXT,
            cantidad INTEGER
        );
        '''
        );
        db.execute('''
        CREATE TABLE cardItem(
            codigo INTEGER,
            nombre TEXT,
            cantidad INTEGER,
            precio INTEGER,
        );
        ''');    
    }
    //metodo para listar los datos de nuestra tabla cardItem
    Future<List<CardItemModel>> getAllItem () async{
        final db = await instance.database;
        final List<Map<String,dynamic>> maps = await db.query('cardItem');
        return List.generate(maps.length, (i){
            return CardItemModel(
                codigo: maps[i]['codigo'], 
                nombre: maps[i]['nombre'], 
                cantidad: maps[i]['cantidad'], 
                precio: maps[i]['precio']
            );
        });
    }
    //metodo para listar los datos de nuestra tabla productos
    Future<List<ProductosModel>> getAllProductos () async{
        final db = await instance.database;
        final List<Map<String,dynamic>> maps = await db.query('producto');
        return List.generate(
            maps.length, 
            (i) => ProductosModel(
                codigo: maps[i]['codigo'], 
                id: maps[i]['id'], 
                nombre: maps[i]['nombre'], 
                cantidad: maps[i]['cantidad']
            )
        );
    }
}