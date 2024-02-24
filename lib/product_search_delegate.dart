import 'package:flutter/material.dart';
import 'backdrop.dart';
import 'model/product.dart'; // Pastikan untuk mengimpor model produk atau sesuaikan dengan struktur Anda
import 'supplemental/product_card.dart';

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
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context); // Gunakan hasil pencarian yang sama untuk saran
  }

  Widget _buildSearchResults(BuildContext context) {
    // Gantilah dengan logika pencarian sesungguhnya atau hasil dari backend aplikasi Anda
    List<Product> searchResults = backdrop.searchProducts(query);

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        Product product = searchResults[index];

        return ProductCard(
          imageAspectRatio: 33 / 49, // Sesuaikan sesuai kebutuhan Anda
          product: product,
        );
      },
    );
  }
}
