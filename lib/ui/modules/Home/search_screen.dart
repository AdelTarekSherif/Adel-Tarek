import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';

import 'package:flutter/material.dart';
import 'package:adel_tarek/ui/common/widgets/custom_text_field.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';
import 'package:adel_tarek/ui/style/app.dimens.dart';
import 'package:adel_tarek/utils/core.util.dart';

class SearchMealsScreen extends StatefulWidget {
  const SearchMealsScreen({super.key});

  @override
  State<SearchMealsScreen> createState() => _SearchMealsScreenState();
}

class _SearchMealsScreenState extends State<SearchMealsScreen> {
  final TextEditingController searchController = TextEditingController();
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    context.read<MealBloc>().add(SearchMeals(""));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormInputField(
                  textEditingController: searchController,
                  title: 'Search Meals',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Utils.dismissKeyboard(context);
                      context
                          .read<MealBloc>()
                          .add(SearchMeals(searchController.text));
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return BlocBuilder<MealBloc, MealState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "categories",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: state.categories.length,
                                      itemBuilder: (context, index) {
                                        final category =
                                            state.categories[index];
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedCategory = category;
                                            });
                                            context.read<MealBloc>().add(
                                                FilterMealsByCategory(
                                                    category));
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              category,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppDimens.marginDefault8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.filter_list,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final meal = state.searchResults[index];
                    return InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          scrollable: true,
                          title: Text(
                            meal['strMeal'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                          content: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child:
                                          Image.network(meal['strMealThumb'])),
                                  const SizedBox(height: 14),
                                  Text(
                                    meal['strInstructions'] ??
                                        'No instructions available.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: AppColors.textColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(meal['strMealThumb'],
                                  width: 75, height: 75, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                meal['strMeal'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
