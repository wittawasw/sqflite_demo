class SampleItem {
  final int id;
  final String name;
  final String description;
  final int price;

  const SampleItem(this.id, this.name, this.description, this.price);

  SampleItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        description = json['description'] as String,
        price = json['price'] as int;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      };
}
