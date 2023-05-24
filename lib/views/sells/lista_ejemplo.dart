class ProductoEjemplo {
  final int id;
  final String name;
  final String category;
  final int price;
  int quantity;
  final String image;

  ProductoEjemplo(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.quantity,
      required this.image});
}

List<ProductoEjemplo> pastryProducts = [
  ProductoEjemplo(
    id: 1,
    name: "Torta de chocolate",
    category: "Tortas",
    price: 8000,
    quantity: 5,
    image: "assets/images/ejemplo/imagen1.jpg",
  ),
  ProductoEjemplo(
    id: 2,
    name: "Croissant de almendra",
    category: "Croissants",
    price: 1500,
    quantity: 10,
    image: "assets/images/ejemplo/imagen2.jpg",
  ),
  ProductoEjemplo(
    id: 3,
    name: "Cupcake de vainilla",
    category: "Cupcakes",
    price: 2000,
    quantity: 8,
    image: "assets/images/ejemplo/imagen3.jpg",
  ),
  ProductoEjemplo(
    id: 4,
    name: "Éclair de café",
    category: "Éclairs",
    price: 2500,
    quantity: 6,
    image: "assets/images/ejemplo/imagen4.jpg",
  ),
  ProductoEjemplo(
    id: 5,
    name: "Galleta de avena y pasas",
    category: "Galletas",
    price: 500,
    quantity: 15,
    image: "assets/images/ejemplo/imagen5.jpg",
  ),
  ProductoEjemplo(
    id: 6,
    name: "Tartaleta de frutos rojos",
    category: "Tartaletas",
    price: 1800,
    quantity: 7,
    image: "assets/images/ejemplo/imagen6.jpg",
  ),
  ProductoEjemplo(
    id: 7,
    name: "Brownie de nueces",
    category: "Brownies",
    price: 2500,
    quantity: 6,
    image: "assets/images/ejemplo/imagen7.jpg",
  ),
  ProductoEjemplo(
    id: 8,
    name: "Macarons de pistacho",
    category: "Macarons",
    price: 3000,
    quantity: 12,
    image: "assets/images/ejemplo/imagen8.jpg",
  ),
  ProductoEjemplo(
    id: 9,
    name: "Cannoli de crema",
    category: "Otros",
    price: 2000,
    quantity: 9,
    image: "assets/images/ejemplo/imagen9.jpg",
  ),
  ProductoEjemplo(
    id: 10,
    name: "Torta de limón",
    category: "Tortas",
    price: 7500,
    quantity: 4,
    image: "assets/images/ejemplo/imagen10.jpg",
  ),
  ProductoEjemplo(
    id: 11,
    name: "Berlines rellenos de dulce de leche",
    category: "Berlines",
    price: 1200,
    quantity: 10,
    image: "assets/images/ejemplo/imagen11.jpg",
  ),
  ProductoEjemplo(
    id: 12,
    name: "Tarta de manzana",
    category: "Tartas",
    price: 6000,
    quantity: 6,
    image: "assets/images/ejemplo/imagen12.jpg",
  ),
  ProductoEjemplo(
    id: 13,
    name: "Galletas de chispas de chocolate",
    category: "Galletas",
    price: 400,
    quantity: 20,
    image: "assets/images/ejemplo/imagen13.jpg",
  ),
  ProductoEjemplo(
    id: 14,
    name: "Profiteroles de crema",
    category: "Otros",
    price: 2500,
    quantity: 8,
    image: "assets/images/ejemplo/imagen14.jpg",
  ),
];
