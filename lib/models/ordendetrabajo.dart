// To parse this JSON data, do
//
//     final ordenTrabajo = ordenTrabajoFromMap(jsonString);

import 'dart:convert';

class OrdenTrabajo {
    List<ListTrabajo> listTrabajos;

    OrdenTrabajo({
        required this.listTrabajos,
    });

    factory OrdenTrabajo.fromJson(String str) => OrdenTrabajo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrdenTrabajo.fromMap(Map<String, dynamic> json) => OrdenTrabajo(
        listTrabajos: List<ListTrabajo>.from(json["ListTrabajos"].map((x) => ListTrabajo.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ListTrabajos": List<dynamic>.from(listTrabajos.map((x) => x.toMap())),
    };
}

class ListTrabajo {
    int id;
    String nombreProducto;
    int precioProducto;
    String estadoProducto;
    int cantidadProducto;
    String lote;
    DateTime? fechaElaboracion;
    DateTime? fechaVencimiento;
    int categoria;
    String imagen;
    List<InsumosUtilizado> insumosUtilizados;

    ListTrabajo({
        required this.id,
        required this.nombreProducto,
        required this.precioProducto,
        required this.estadoProducto,
        required this.cantidadProducto,
        required this.lote,
        this.fechaElaboracion,
        this.fechaVencimiento,
        required this.categoria,
        required this.imagen,
        required this.insumosUtilizados,
    });

    factory ListTrabajo.fromJson(String str) => ListTrabajo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListTrabajo.fromMap(Map<String, dynamic> json) => ListTrabajo(
        id: json["id"],
        nombreProducto: json["nombre_producto"],
        precioProducto: json["precio_producto"],
        estadoProducto: json["estado_producto"],
        cantidadProducto: json["cantidad_producto"],
        lote: json["lote"],
        fechaElaboracion: json["fecha_elaboracion"] == null ? null : DateTime.parse(json["fecha_elaboracion"]),
        fechaVencimiento: json["fecha_vencimiento"] == null ? null : DateTime.parse(json["fecha_vencimiento"]),
        categoria: json["categoria"],
        imagen: json["imagen"],
        insumosUtilizados: List<InsumosUtilizado>.from(json["insumos_utilizados"].map((x) => InsumosUtilizado.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre_producto": nombreProducto,
        "precio_producto": precioProducto,
        "estado_producto": estadoProducto,
        "cantidad_producto": cantidadProducto,
        "lote": lote,
        "fecha_elaboracion": "${fechaElaboracion!.year.toString().padLeft(4, '0')}-${fechaElaboracion!.month.toString().padLeft(2, '0')}-${fechaElaboracion!.day.toString().padLeft(2, '0')}",
        "fecha_vencimiento": "${fechaVencimiento!.year.toString().padLeft(4, '0')}-${fechaVencimiento!.month.toString().padLeft(2, '0')}-${fechaVencimiento!.day.toString().padLeft(2, '0')}",
        "categoria": categoria,
        "imagen": imagen,
        "insumos_utilizados": List<dynamic>.from(insumosUtilizados.map((x) => x.toMap())),
    };
}

class InsumosUtilizado {
    int id;
    String nombre;
    int cantidadUtilizada;

    InsumosUtilizado({
        required this.id,
        required this.nombre,
        required this.cantidadUtilizada,
    });

    factory InsumosUtilizado.fromJson(String str) => InsumosUtilizado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InsumosUtilizado.fromMap(Map<String, dynamic> json) => InsumosUtilizado(
        id: json["id"],
        nombre: json["nombre"],
        cantidadUtilizada: json["cantidad_utilizada"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "cantidad_utilizada": cantidadUtilizada,
    };
}
