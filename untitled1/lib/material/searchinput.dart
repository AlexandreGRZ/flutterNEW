import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          border: InputBorder.none, // Supprime la bordure par défaut
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
