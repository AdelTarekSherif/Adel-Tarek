part of 'meal_bloc.dart';

class MealState {
  final List<Meal> meals;
  final SortOption? sortOption;
  final List<dynamic> searchResults;
  final List<dynamic> categories;

  MealState(
      {required this.meals,
      this.sortOption,
      this.searchResults = const [],
      this.categories = const []});
}
