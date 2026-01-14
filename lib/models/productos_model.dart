class ProductosModel {
  final int codigo;
  final int id;
  final String nombre;
  final int cantidad;

  ProductosModel({
    required this.codigo,
    required this.id,
    required this.nombre,
    required this.cantidad,
  });

  Map<String,dynamic> toMap(){
    return {
        'codigo' : codigo,
        'id' : id,
        'nombre' : nombre,
        'cantidad': cantidad    
    };
  }
}