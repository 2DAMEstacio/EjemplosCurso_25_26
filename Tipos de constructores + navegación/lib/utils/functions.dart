import 'package:flutter/material.dart';

class Functions {
  static String initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    final first = parts.first.characters.first;
    final last = (parts.length > 1 ? parts.last.characters.first : '');
    return (first + last).toUpperCase();
  }
}
