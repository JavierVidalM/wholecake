// To parse this JSON data, do
//
//     final ordenDeCompa = ordenDeCompaFromMap(jsonString);

import 'dart:convert';

class OrdenDeCompa {
    List<ListOdc> listOdc;

    OrdenDeCompa({
        required this.listOdc,
    });

    factory OrdenDeCompa.fromJson(String str) => OrdenDeCompa.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrdenDeCompa.fromMap(Map<String, dynamic> json) => OrdenDeCompa(
        listOdc: List<ListOdc>.from(json["ListOdc"].map((x) => ListOdc.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ListOdc": List<dynamic>.from(listOdc.map((x) => x.toMap())),
    };
}

class ListOdc {
    int ordenId;
    String fecha;
    int cantidad;
    int costotal;
    int proveedor;

    ListOdc({
        required this.ordenId,
        required this.fecha,
        required this.cantidad,
        required this.costotal,
        required this.proveedor,
    });

    factory ListOdc.fromJson(String str) => ListOdc.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListOdc.fromMap(Map<String, dynamic> json) => ListOdc(
        ordenId: json["id"],
        fecha: json["fecha"],
        cantidad: json["cantidad"],
        costotal: json["costotal"],
        proveedor: json["proveedor"],
    );

    Map<String, dynamic> toMap() => {
        "ordenId": ordenId,
        "fecha": fecha,
        "cantidad": cantidad,
        "costotal": costotal,
        "proveedor": proveedor,
    };
    ListOdc copy() => ListOdc(
      ordenId: ordenId,
      fecha: fecha,
      cantidad:cantidad,
      costotal:costotal,
      proveedor:proveedor
    );
}
