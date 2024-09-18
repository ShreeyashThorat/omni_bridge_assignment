class PetsModel {
  String? id;
  String? category;
  String? name;
  String? description;
  String? color;
  String? age;
  String? ownerName;
  String? ownerContact;
  String? ownerId;
  String? image;
  List<String>? likes;

  PetsModel(
      {this.id,
      this.category,
      this.name,
      this.description,
      this.color,
      this.age,
      this.ownerName,
      this.ownerContact,
      this.ownerId,
      this.image,
      this.likes});

  PetsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    category = json['category'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    color = json['color'] ?? "";
    age = json['age'] ?? "";
    ownerName = json['ownerName'] ?? "";
    ownerContact = json['ownerContact'] ?? "";
    ownerId = json['ownerId'] ?? "";
    image = json['image'] ?? "";
    likes = json['likes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? "";
    data['category'] = category ?? "";
    data['name'] = name ?? "";
    data['description'] = description ?? "";
    data['color'] = color ?? "";
    data['age'] = age ?? "";
    data['ownerName'] = ownerName ?? "";
    data['ownerContact'] = ownerContact ?? "";
    data['ownerId'] = ownerId ?? "";
    data['image'] = image ?? "";
    data['likes'] = likes ?? [];
    return data;
  }
}
