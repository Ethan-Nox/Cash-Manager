class Cart {
   int id;
  int quantity;

  Cart({required this.id, required this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'quantity': quantity,
  };

  
}