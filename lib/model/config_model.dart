
class ConfigModel{
  String? title;
  String? subTitle;
  String? bgPath;
  String? defaultImgPath;

  ConfigModel(this.title,this.subTitle,this.bgPath,this.defaultImgPath);

  factory ConfigModel.fromJson(Map<String,dynamic> json){
    String title = json['title'];
    String subTitle  = json['subTitle'];
    String bgPath = json['bgPath'];
    String defaultImgPath = json['defaultImgPath'];
    return ConfigModel(title, subTitle, bgPath, defaultImgPath);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['bgPath'] = this.bgPath;
    data['defaultImgPath'] = this.defaultImgPath;
    return data;
  }
}