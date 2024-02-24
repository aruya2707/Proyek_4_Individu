import 'package:flutter/material.dart';
import 'backdrop.dart';
import 'model/product.dart'; // Pastikan untuk mengimpor model produk atau sesuaikan dengan struktur Anda
import 'supplemental/product_card.dart';
import 'model/products_repository.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final Backdrop backdrop;

  ProductSearchDelegate({required this.backdrop});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  @override
Widget buildSuggestions(BuildContext context) {
  // Dapatkan semua produk untuk kategori saat ini
  List<Product> allProducts = ProductsRepository.loadProducts(backdrop.currentCategory);

  // Filter produk berdasarkan query
  List<Product> suggestions = allProducts
      .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      Product product = suggestions[index];

      return ListTile(
        title: Text(product.name),
        onTap: () {
          // Setelah item dipilih, isi kotak pencarian dengan nama produk
          query = product.name;
          // Tampilkan hasil pencarian sesuai dengan produk yang dipilih
          showResults(context);
        },
      );
    },
  );
}


  Widget _buildSearchResults(BuildContext context) {
  // Buat instance repository produk yang sesuai
  ProductsRepository productsRepository = ProductsRepository();

  // Dapatkan semua produk untuk kategori saat ini
  List<Product> allProducts = ProductsRepository.loadProducts(backdrop.currentCategory);

  // Filter produk berdasarkan query
  List<Product> searchResults = allProducts
      .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return ListView.builder(
    itemCount: searchResults.length,
    itemBuilder: (context, index) {
      Product product = searchResults[index];

      return ProductCard(
        imageAspectRatio: 55 / 49,
        product: product,
      );
    },
  );
}
}

