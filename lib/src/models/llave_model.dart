// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

LlaveModel llaveModelFromJson(String str) => LlaveModel.fromJson(json.decode(str));

String llaveModelToJson(LlaveModel data) => json.encode(data.toJson());

class LlaveModel {

    String id;
    String colorUno;
    String colorDos;
    String patron;
    String uso;
    bool disponible;
    String fotoUrl;

    LlaveModel({
        this.id,
        this.colorUno = '',
        this.colorDos = '',
        this.patron = '',
        this.uso = '',
        this.disponible = true,
        this.fotoUrl,
    });

    factory LlaveModel.fromJson(Map<String, dynamic> json) => new LlaveModel(
        id         : json["id"],
        colorUno   : json["colorUno"],
        colorDos   : json["colorDos"],
        patron     : json["patron"],
        uso        : json["uso"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id"         : id,
        "colorUno"   : colorUno,
        "colorDos"   : colorDos,
        "patron"     : patron,
        "uso"        : uso,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
    };
}
