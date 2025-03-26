import 'package:adel_tarek/data/model/meal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';

import 'package:flutter/material.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';

class MyMealsScreen extends StatefulWidget {
  const MyMealsScreen({super.key});

  @override
  State<MyMealsScreen> createState() => _MyMealsScreenState();
}

class _MyMealsScreenState extends State<MyMealsScreen> {
  final DateFormat timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<MealBloc, MealState>(
            builder: (context, state) {
              int totalCalories =
                  state.meals.fold(0, (sum, meal) => sum + meal.calories);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Today\'s Summary',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(formattedDate(DateTime.now()),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: NumberFormat("###,###,###")
                                  .format(totalCalories),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                            ),
                            const TextSpan(
                                text: ' kcal',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ]),
                        ),
                        const Text('Daily Total',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Sort by:',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButton<SortOption>(
                          value: state.sortOption,
                          onChanged: (SortOption? option) {
                            if (option != null) {
                              context.read<MealBloc>().add(SortMeals(option));
                            }
                          },
                          hint: const Text('Time'),
                          style: const TextStyle(color: Colors.black),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(8),
                          items: const [
                            DropdownMenuItem(
                              value: SortOption.time,
                              child: Text('Time'),
                            ),
                            DropdownMenuItem(
                              value: SortOption.name,
                              child: Text('Name'),
                            ),
                            DropdownMenuItem(
                              value: SortOption.calories,
                              child: Text('Calories'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              meal.photo != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(meal.photo!,
                                          width: 75,
                                          height: 75,
                                          fit: BoxFit.cover),
                                    )
                                  : const Icon(Icons.fastfood, size: 75),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              meal.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: AppColors.textColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(children: [
                                                TextSpan(
                                                  text: NumberFormat(
                                                          "###,###,###")
                                                      .format(meal.calories),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green),
                                                ),
                                                const TextSpan(
                                                    text: ' kcal - ',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey)),
                                              ]),
                                            ),
                                            Text(
                                              timeFormat.format(meal.time),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: AppColors.textColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      onPressed: () => context
                                          .read<MealBloc>()
                                          .add(DeleteMeal(meal)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String formattedDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime).toString();
  }
}
