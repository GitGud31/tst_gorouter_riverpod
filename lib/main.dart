import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/root_screen.dart';

void main() {
  runApp(const ProviderScope(child: RootScreen()));
}
