import 'dart:io';

class Meal {
  String name;
  int calories;
  DateTime time;
  File? photo;
  String? thumbnail;

  Meal({required this.name, required this.calories, required this.time, this.photo, this.thumbnail});
}

enum SortOption { name, calories, time }
