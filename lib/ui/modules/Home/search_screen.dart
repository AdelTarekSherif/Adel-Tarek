import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';

import 'package:flutter/material.dart';
import 'package:adel_tarek/ui/common/widgets/custom_text_field.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';
import 'package:adel_tarek/ui/style/app.dimens.dart';
import 'package:adel_tarek/utils/core.util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

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
                  title: 'What are you looking for?',
                  onChanged: (value) {
                    context
                        .read<MealBloc>()
                        .add(SearchMeals(searchController.text));
                  },
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
                                Center(
                                  child: GestureDetector(
                                    onVerticalDragDown: (details) =>
                                        Navigator.pop(context),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/Divider.svg'),
                                        SizedBox(
                                            height:
                                                screenAwareHeight(24, context)),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: state.categories.map((category) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = category;
                                          });
                                          context.read<MealBloc>().add(
                                              FilterMealsByCategory(category));
                                          Navigator.pop(context);
                                        },
                                        child: Chip(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          side: const BorderSide(
                                              color: Colors.grey, width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          label: Text(
                                            category,
                                            style: TextStyle(
                                                color:
                                                    selectedCategory == category
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                          backgroundColor:
                                              selectedCategory == category
                                                  ? AppColors.primaryColor
                                                      .withOpacity(0.75)
                                                  : Colors.grey.shade200,
                                        ),
                                      );
                                    }).toList()),
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
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenAwareHeight(16, context)),
          Expanded(
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final meal = state.searchResults[index];
                    return InkWell(
                      onTap: () => showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return BlocBuilder<MealBloc, MealState>(
                            builder: (context, state) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                height: screenAwareHeight(85.h, context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onVerticalDragDown: (details) =>
                                            Navigator.pop(context),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/Divider.svg'),
                                            SizedBox(
                                                height: screenAwareHeight(
                                                    24, context)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                height: 30.h,
                                                width: double.infinity,
                                                meal['strMealThumb'],
                                                fit: BoxFit.cover,
                                              )),
                                          const SizedBox(height: 14),
                                          Text(
                                            meal['strMeal'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor),
                                          ),
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
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(meal['strMealThumb'],
                                  width: 100, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal['strMeal'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: AppColors.textColor),
                                  ),
                                  Chip(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    side: const BorderSide(
                                        color: Colors.grey, width: 0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: Text(
                                      "${meal?['strCategory'] ?? selectedCategory}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textColor),
                                    ),
                                  ),
                                ],
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
