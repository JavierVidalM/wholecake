// To parse this JSON data, do
//
//     final ventas = ventasFromMap(jsonString);

import 'dart:convert';

class Ventas {
    List<Listventa> listventas;

    Ventas({
        required this.listventas,
    });

    factory Ventas.fromJson(String str) => Ventas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ventas.fromMap(Map<String, dynamic> json) => Ventas(
        listventas: List<Listventa>.from(json["listventas"].map((x) => Listventa.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "listventas": List<dynamic>.from(listventas.map((x) => x.toMap())),
    };
}

class Listventa {
    int idVenta;
    DateTime fecha;
    int total;
    List<Producto> productos;

    Listventa({
        required this.idVenta,
        required this.fecha,
        required this.total,
        required this.productos,
    });

    factory Listventa.fromJson(String str) => Listventa.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Listventa.fromMap(Map<String, dynamic> json) => Listventa(
        idVenta: json["id_venta"],
        fecha: DateTime.parse(json["fecha"]),
        total: json["total"],
        productos: List<Producto>.from(json["productos"].map((x) => Producto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id_venta": idVenta,
        "fecha": fecha.toIso8601String(),
        "total": total,
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
    };
}

class Producto {
    int id;
    String nombre;
    int cantidad;
    int precioUnitario;
    int precioTotal;

    Producto({
        required this.id,
        required this.nombre,
        required this.cantidad,
        required this.precioUnitario,
        required this.precioTotal,
    });

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        precioUnitario: json["precio_unitario"],
        precioTotal: json["precio_total"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "cantidad": cantidad,
        "precio_unitario": precioUnitario,
        "precio_total": precioTotal,
    };
}
