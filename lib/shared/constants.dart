import 'package:ecommerce_app/shared/components.dart';
import 'package:flutter/material.dart';

const Color myOrange = Color(0xffe74e3a);

enum CategoryType {
  allProducts,
  electronics,
  books,
  homeAppliances,
  healthAndPersonalCare,
  sportEquipment,
}

List<Widget> categoryItems = [
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.allProducts);
    },
    iconData: Icons.search,
    text: "All Products",
    color: Colors.yellow.shade800,
  ),
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.electronics);
    },
    iconData: Icons.phone_iphone,
    text: "Electronics",
    color: Colors.blue,
  ),
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.books);
    },
    iconData: Icons.menu_book,
    text: "Books",
    color: Colors.brown,
  ),
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.homeAppliances);
    },
    iconData: Icons.local_laundry_service,
    text: "Home Appliances",
    color: Colors.grey,
  ),
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.healthAndPersonalCare);
    },
    iconData: Icons.health_and_safety,
    text: "Health & Personal Care",
    color: Colors.red,
  ),
  CategoryItem(
    onPressed: () {
      categoryItemOnPressed(CategoryType.sportEquipment);
    },
    iconData: Icons.sports_football,
    text: "Sport Equipment",
    color: Colors.green,
  ),
];