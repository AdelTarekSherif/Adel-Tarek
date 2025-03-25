part of 'meal_bloc.dart';

abstract class MealEvent {}

class AddMeal extends MealEvent {
  final Meal meal;
  AddMeal(this.meal);
}

class DeleteMeal extends MealEvent {
  final Meal meal;
  DeleteMeal(this.meal);
}

class SortMeals extends MealEvent {
  final SortOption option;
  SortMeals(this.option);
}

class SearchMeals extends MealEvent {
  final String query;
  SearchMeals(this.query);
}

class FilterMealsByCategory extends MealEvent {
  final String category;
  FilterMealsByCategory(this.category);
}
