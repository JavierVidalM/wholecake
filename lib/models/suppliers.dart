// To parse this JSON data, do
//
//     final suppliers = suppliersFromMap(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Suppliers {
  List<ListSup> listSup;
  Suppliers({
    required this.listSup,
  });

  factory Suppliers.fromJson(String str) => Suppliers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Suppliers.fromMap(Map<String, dynamic> json) => Suppliers(
        listSup:
            List<ListSup>.from(json["ListSup"].map((x) => ListSup.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ListSup": List<dynamic>.from(listSup.map((x) => x.toMap())),
      };
}

class ListSup {
  int supplierId;
  String nombreProveedor;
  String rut;
  String tipoInsumo;
  String correoProveedor;
  String telefonoProveedor;
  String imagen_insumo;

  ListSup({
    required this.supplierId,
    required this.nombreProveedor,
    required this.rut,
    required this.tipoInsumo,
    required this.correoProveedor,
    required this.telefonoProveedor,
    required this.imagen_insumo,
  });

  factory ListSup.fromJson(String str) => ListSup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListSup.fromMap(Map<String, dynamic> json) => ListSup(
      supplierId: json["id"],
      nombreProveedor: json["nombre_proveedor"],
      rut: json["rut"],
      tipoInsumo: json["tipo_insumo"],
      correoProveedor: json["correo_proveedor"],
      telefonoProveedor: json["telefono_proveedor"],
      imagen_insumo: json["imagen_insumo"]);

  Map<String, dynamic> toMap() => {
        "supplierId": supplierId,
        "nombre_proveedor": nombreProveedor,
        "rut": rut,
        "tipo_insumo": tipoInsumo,
        "correo_proveedor": correoProveedor,
        "telefono_proveedor": telefonoProveedor,
        "imagen_insumo": imagen_insumo,
      };
  ListSup copy() => ListSup(
        supplierId: supplierId,
        nombreProveedor: nombreProveedor,
        rut: rut,
        tipoInsumo: tipoInsumo,
        correoProveedor: correoProveedor,
        telefonoProveedor: telefonoProveedor,
        imagen_insumo: imagen_insumo,
      );
}
