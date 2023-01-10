class Article_Model {

  String name;
  num price;
  String category;
  String description;
  String image;
  int stock;
  int id;

  Article_Model({required this.name, required this.price, required this.stock, required this.category, required this.description, required this.image,  required this.id});

  factory Article_Model.fromJson(Map<String, dynamic> json) {
    return Article_Model(
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      category: json['category'],
      image: json['image'],
      description: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'stock': stock,
    'category': category,
    'image': image,
    'description': description,
    'id': id,
  };

}