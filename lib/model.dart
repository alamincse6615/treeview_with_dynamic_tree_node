class Model {
  String? code;
  String? name;
  String? parentCode;

  List<Model> children = [];

  Model({this.code, this.name, this.parentCode,});

  Model.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    parentCode = json['ParentCode'].toString() == "CL-01"?null: json['ParentCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Code'] = code;
    data['Name'] = name;
    data['ParentCode'] = parentCode;
    return data;
  }
}