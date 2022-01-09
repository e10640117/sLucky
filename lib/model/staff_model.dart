// ignore: empty_constructor_bodies
class StaffModel{
  String? name;
  String? imagePath;

  StaffModel(this.name,this.imagePath,{String? id}){
    // if(id == null){
    //   this.id = DateTime.now().microsecondsSinceEpoch.toString();
    // }
  }

  factory StaffModel.fromJson(Map<String,dynamic> json){
    String name = json['name'];
    String imagePath = json['imagePath'];
    return StaffModel(name, imagePath);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    return data;
  }
}