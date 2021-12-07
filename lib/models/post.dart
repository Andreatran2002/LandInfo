

enum Category { all, forSale, forRent,needBuy, needRent }

class Post {
  const Post({
    required this.category,
    required this.id,
    required this.content,
    required this.title,
    required this.price,
    required this.surfaceArea,
  });

  final Category category;
  final int id;
  final String title;
  final double price;
  final double surfaceArea;
  final String content;
  //

  @override
  String toString() => "$title (id=$id)";
}
