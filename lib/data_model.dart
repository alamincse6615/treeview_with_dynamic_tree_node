class Model {
  String? code;
  String? name;
  String? parentCode;
  int? mHLevel;
  List<Model> children = [];

  Model({this.code, this.name, this.parentCode, this.mHLevel});

  Model.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    parentCode = json['ParentCode'].toString() == "CL-01"?null: json['ParentCode'];
    mHLevel = json['MHLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Code'] = code;
    data['Name'] = name;
    data['ParentCode'] = parentCode;
    data['MHLevel'] = mHLevel;
    return data;
  }
}