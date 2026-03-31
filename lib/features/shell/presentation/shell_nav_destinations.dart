import 'package:flutter/material.dart';

class ShellNavDestination {
  const ShellNavDestination({
    required this.title,
    required this.icon,
    required this.key,
  });

  final String title;
  final IconData icon;
  final Key key;
}

const List<ShellNavDestination> shellNavDestinations = <ShellNavDestination>[
  ShellNavDestination(
    title: 'Home',
    icon: Icons.home_outlined,
    key: Key('bottom_nav_0'),
  ),
  ShellNavDestination(
    title: 'Wishlist',
    icon: Icons.favorite_border,
    key: Key('bottom_nav_1'),
  ),
  ShellNavDestination(
    title: 'Orders',
    icon: Icons.receipt_long_outlined,
    key: Key('bottom_nav_2'),
  ),
  ShellNavDestination(
    title: 'Cart',
    icon: Icons.shopping_bag_outlined,
    key: Key('bottom_nav_3'),
  ),
  ShellNavDestination(
    title: 'Profile',
    icon: Icons.person_outline,
    key: Key('bottom_nav_4'),
  ),
];
