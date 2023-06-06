// To parse this JSON data, do
//
//     final supplies = suppliesFromMap(jsonString);

import 'dart:convert';

class Supplies {
  List<SuppliesList> suppliesList;
  Supplies({
    required this.suppliesList,
  });

  factory Supplies.fromJson(String str) => Supplies.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Supplies.fromMap(Map<String, dynamic> json) => Supplies(
        suppliesList: List<SuppliesList>.from(
            json["List"].map((x) => SuppliesList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "List": List<dynamic>.from(suppliesList.map((x) => x.toMap())),
      };
}

class SuppliesList {
  int suppliesId;
  String nombreInsumo;
  String fechaLlegada;
  String fechaVencimiento;
  int preciounidad;
  String proveedor;
  String estado;
  String tipoInsumo;
  String numeroLote;
  String marcaProducto;
  int cantidad;
  String imagen_supplies;

  SuppliesList({
    required this.suppliesId,
    required this.nombreInsumo,
    required this.fechaLlegada,
    required this.fechaVencimiento,
    required this.preciounidad,
    required this.proveedor,
    required this.estado,
    required this.tipoInsumo,
    required this.numeroLote,
    required this.marcaProducto,
    required this.cantidad,
    required this.imagen_supplies,
  });

  factory SuppliesList.fromJson(String str) =>
      SuppliesList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuppliesList.fromMap(Map<String, dynamic> json) => SuppliesList(
        suppliesId: json["id"],
        nombreInsumo: json["nombre_insumo"],
        fechaLlegada: json["fecha_llegada"],
        fechaVencimiento: json["fecha_vencimiento"],
        preciounidad: json["preciounidad"],
        proveedor: json["proveedor"],
        estado: json["estado"],
        tipoInsumo: json["tipo_insumo"],
        numeroLote: json["numero_lote"],
        marcaProducto: json["marca_producto"],
        cantidad: json["cantidad"],
        imagen_supplies: json["imagen_supplies"],
      );

  Map<String, dynamic> toMap() => {
        "id": suppliesId,
        "nombre_insumo": nombreInsumo,
        "fecha_llegada": fechaLlegada,
        "fecha_vencimiento": fechaVencimiento,
        "preciounidad": preciounidad,
        "proveedor": proveedor,
        "estado": estado,
        "tipo_insumo": tipoInsumo,
        "numero_lote": numeroLote,
        "marca_producto": marcaProducto,
        "cantidad": cantidad,
        "imagen_supplies": imagen_supplies,
      };
  SuppliesList copy() => SuppliesList(
        suppliesId: suppliesId,
        nombreInsumo: nombreInsumo,
        fechaLlegada: fechaLlegada,
        fechaVencimiento: fechaVencimiento,
        preciounidad: preciounidad,
        proveedor: proveedor,
        estado: estado,
        tipoInsumo: tipoInsumo,
        numeroLote: numeroLote,
        marcaProducto: marcaProducto,
        cantidad: cantidad,
        imagen_supplies: imagen_supplies,
      );
}
