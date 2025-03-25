import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';

import 'package:flutter/material.dart';
import 'package:adel_tarek/data/model/meal_model.dart';
import 'package:adel_tarek/ui/common/widgets/custom_button.dart';
import 'package:adel_tarek/ui/common/widgets/custom_text_field.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';

class MyMealsScreen extends StatefulWidget {
  const MyMealsScreen({super.key});

  @override
  State<MyMealsScreen> createState() => _MyMealsScreenState();
}

class _MyMealsScreenState extends State<MyMealsScreen> {
  final DateFormat timeFormat = DateFormat('hh:mm a');
  final ImagePicker _picker = ImagePicker();

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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text('Total Calories Today: $totalCalories',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
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
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${meal.calories} kcal ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textColor),
                                    ),
                                    Text(
                                      meal.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: AppColors.textColor),
                                    ),
                                    Text(
                                      timeFormat.format(meal.time),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColors.textColor),
                                    ),
                                  ]),
                              const Spacer(),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context
                                    .read<MealBloc>()
                                    .add(DeleteMeal(meal)),
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
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFFD4FA93),
            onPressed: () async {
              TextEditingController nameController = TextEditingController();
              TextEditingController calorieController = TextEditingController();
              File? image;
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text(
                      'Add Meal',
                      style:
                          TextStyle(fontSize: 18, color: AppColors.textColor),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormInputField(
                              textEditingController: nameController,
                              title: 'Meal Name'),
                          FormInputField(
                              textEditingController: calorieController,
                              title: 'Calories',
                              textInputType: TextInputType.number),
                          CustomButton(
                            isLoading: false,
                            label: 'Pick Image',
                            buttonColor: Colors.white,
                            textColor: AppColors.primaryColor,
                            onPressed: () async {
                              final pickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                image = File(pickedFile.path);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              isLoading: false,
                              label: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                              buttonColor: Colors.white,
                              textColor: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomButton(
                              isLoading: false,
                              label: 'Add',
                              onPressed: () {
                                final name = nameController.text;
                                final calories =
                                    int.tryParse(calorieController.text) ?? 0;

                                if (name.isNotEmpty && calories > 0) {
                                  context.read<MealBloc>().add(AddMeal(Meal(
                                      name: name,
                                      calories: calories,
                                      time: DateTime.now(),
                                      photo: image)));
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Color(0xFF959595),
            ),
          ),
        ),
      ],
    );
  }
}
