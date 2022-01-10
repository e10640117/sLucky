
class ConfigModel{
  String? title;
  String? subTitle;
  String? bgPath;
  String? defaultImgPath;
  bool? useDefaultBg;
  String? leftContent;
  String? rightContent;

  ConfigModel(this.title,this.subTitle,this.bgPath,this.defaultImgPath,this.useDefaultBg,this.leftContent,this.rightContent);

  factory ConfigModel.fromJson(Map<String,dynamic> json){
    String title = json['title'];
    String subTitle  = json['subTitle'];
    String bgPath = json['bgPath'];
    String defaultImgPath = json['defaultImgPath'];
    String leftContent = json['leftContent']??'' ;
    String rightContent = json['rightContent']??'';
    bool useDefaultBg = json['useDefaultBg']?? true;
    return ConfigModel(title, subTitle, bgPath, defaultImgPath,useDefaultBg,leftContent,rightContent);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['bgPath'] = this.bgPath;
    data['defaultImgPath'] = this.defaultImgPath;
    data['useDefaultBg'] = this.useDefaultBg;
    data['leftContent'] = this.leftContent;
    data['rightContent'] = this.rightContent;
    return data;
  }
}