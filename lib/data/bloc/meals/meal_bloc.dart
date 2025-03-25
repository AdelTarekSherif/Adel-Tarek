import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/model/meal_model.dart';
import 'package:http/http.dart' as http;
part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealState(meals: [])) {
    on<AddMeal>((event, emit) {
      emit(MealState(
          meals: [...state.meals, event.meal],
          sortOption: state.sortOption,
          searchResults: state.searchResults,
          categories: state.categories));
    });

    on<DeleteMeal>((event, emit) {
      emit(MealState(
          meals: state.meals.where((m) => m != event.meal).toList(),
          sortOption: state.sortOption,
          searchResults: state.searchResults,
          categories: state.categories));
    });

    on<SortMeals>((event, emit) {
      List<Meal> sortedMeals = List.from(state.meals);
      switch (event.option) {
        case SortOption.name:
          sortedMeals.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortOption.calories:
          sortedMeals.sort((a, b) => a.calories.compareTo(b.calories));
          break;
        case SortOption.time:
          sortedMeals.sort((a, b) => a.time.compareTo(b.time));
          break;
      }
      emit(MealState(
          meals: sortedMeals,
          sortOption: event.option,
          searchResults: state.searchResults,
          categories: state.categories));
    });

    on<SearchMeals>((event, emit) async {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=${event.query}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] ?? [];

        // Extract unique categories from the search results
        final categories = meals
            .map<String?>((meal) => meal['strCategory'] as String?)
            .where((category) => category != null)
            .toSet()
            .toList();

        emit(MealState(
          meals: state.meals,
          sortOption: state.sortOption,
          searchResults: meals,
          categories: categories,
        ));
      }
    });

    on<FilterMealsByCategory>((event, emit) async {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=${event.category}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        emit(MealState(
            meals: state.meals,
            sortOption: state.sortOption,
            searchResults: data['meals'] ?? [],
            categories: state.categories));
      }
    });
  }
}
