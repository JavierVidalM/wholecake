// To parse this JSON data, do
//
//     final supplies = suppliesFromMap(jsonString);

import 'dart:convert';

class Supplies {
  List<ListSupplies> listSupplies;
  Supplies({
    required this.listSupplies,
  });

  factory Supplies.fromJson(String str) => Supplies.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Supplies.fromMap(Map<String, dynamic> json) => Supplies(
        listSupplies: List<ListSupplies>.from(
            json["ListSupplies"].map((x) => ListSupplies.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ListSupplies": List<dynamic>.from(listSupplies.map((x) => x.toMap())),
      };
}

class ListSupplies {
  int suppliesId;
  String nombreinsumoSupplies;
  String fechallegadaSupplies;
  String fechavencimientoSupplies;
  String preciounidadSupplies;
  String proveedorSupplies;
  String estadoSupplies;
  String tipoinsumoSupplies;
  int numeroloteSupplies;
  String marcaproductoSupplies;
  int cantidadSupplies;
  String imagen_supplies;

  ListSupplies({
    required this.suppliesId,
    required this.nombreinsumoSupplies,
    required this.fechallegadaSupplies,
    required this.fechavencimientoSupplies,
    required this.preciounidadSupplies,
    required this.proveedorSupplies,
    required this.estadoSupplies,
    required this.tipoinsumoSupplies,
    required this.numeroloteSupplies,
    required this.marcaproductoSupplies,
    required this.cantidadSupplies,
    required this.imagen_supplies,
  });

  factory ListSupplies.fromJson(String str) =>
      ListSupplies.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListSupplies.fromMap(Map<String, dynamic> json) => ListSupplies(
        suppliesId: json["id"],
        nombreinsumoSupplies: json["nombre_insumo"],
        fechallegadaSupplies: json["fecha_llegada"],
        fechavencimientoSupplies: json["fecha_vencimiento"],
        preciounidadSupplies: json["precio_unidad"],
        proveedorSupplies: json["proveedor_insumo"],
        estadoSupplies: json["estado"],
        tipoinsumoSupplies: json["tipo_insumo"],
        numeroloteSupplies: json["numero_lote"],
        marcaproductoSupplies: json["marca_producto"],
        cantidadSupplies: json["cantidad_insumo"],
        imagen_supplies: json["imagen_insumo"],
      );

  Map<String, dynamic> toMap() => {
        "suppliesId": suppliesId,
        "nombre_insumo": nombreinsumoSupplies,
        "fecha_llegada": fechallegadaSupplies,
        "fecha_vencimiento": fechavencimientoSupplies,
        "precio_unidad": preciounidadSupplies,
        "proveedor_insumo": proveedorSupplies,
        "estado": estadoSupplies,
        "tipo_insumo": tipoinsumoSupplies,
        "numero_lote": numeroloteSupplies,
        "marca_producto": marcaproductoSupplies,
        "cantidad_insumo": cantidadSupplies,
        "imagen_insumo": imagen_supplies,
      };
  ListSupplies copy() => ListSupplies(
        suppliesId: suppliesId,
        nombreinsumoSupplies: nombreinsumoSupplies,
        fechallegadaSupplies: fechallegadaSupplies,
        fechavencimientoSupplies: fechavencimientoSupplies,
        preciounidadSupplies: preciounidadSupplies,
        proveedorSupplies: proveedorSupplies,
        estadoSupplies: estadoSupplies,
        tipoinsumoSupplies: tipoinsumoSupplies,
        numeroloteSupplies: numeroloteSupplies,
        marcaproductoSupplies: marcaproductoSupplies,
        cantidadSupplies: cantidadSupplies,
        imagen_supplies: imagen_supplies,
      );
}
