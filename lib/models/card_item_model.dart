class CardItemModel{
    final int codigo;
    final String nombre;
    final int cantidad;
    final int precio;

    CardItemModel({
      required this.codigo,
      required this.nombre,
      required this.cantidad,
      required this.precio,
    });

    Map<String,dynamic> toMap(){
    return {
        'codigo' : codigo,
        'nombre' : nombre,
        'cantidad': cantidad,    
        'precio' : precio,
    };
  }
}