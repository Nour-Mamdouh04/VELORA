class ProductResponse {
  final List<Product> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  ProductResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      items: (json['items'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }
}

class Product {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String coverPictureUrl;
  final List<String>? productPictures;
  final num price;
  final int stock;
  final num weight;
  final String color;
  final double rating;
  final int reviewsCount;
  final num discountPercentage;
  final String sellerId;
  final List<String> categories;

  Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.coverPictureUrl,
    this.productPictures,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.sellerId,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productCode: json['productCode'],
      name: json['name'],
      description: json['description'],
      arabicName: json['arabicName'],
      arabicDescription: json['arabicDescription'],
      coverPictureUrl: json['coverPictureUrl'],
      productPictures: json['productPictures'] == null
          ? null
          : List<String>.from(json['productPictures']),
      price: json['price'],
      stock: json['stock'],
      weight: json['weight'],
      color: json['color'],
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      discountPercentage: json['discountPercentage'],
      sellerId: json['sellerId'],
      categories: List<String>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'name': name,
      'description': description,
      'arabicName': arabicName,
      'arabicDescription': arabicDescription,
      'coverPictureUrl': coverPictureUrl,
      'productPictures': productPictures,
      'price': price,
      'stock': stock,
      'weight': weight,
      'color': color,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'discountPercentage': discountPercentage,
      'sellerId': sellerId,
      'categories': categories,
    };
  }
}