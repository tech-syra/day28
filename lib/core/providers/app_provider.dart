import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_provider.g.dart';

@riverpod
String appName(AppNameRef ref) {
  return "Expense Tracker";
}