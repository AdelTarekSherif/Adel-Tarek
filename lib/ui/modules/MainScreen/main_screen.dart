import 'dart:io';

import 'package:adel_tarek/ui/common/widgets/custom_button.dart';
import 'package:adel_tarek/ui/common/widgets/custom_text_field.dart';
import 'package:adel_tarek/utils/core.util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';
import 'package:adel_tarek/data/model/meal_model.dart';
import 'package:adel_tarek/ui/modules/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:adel_tarek/ui/modules/Home/search_screen.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  final myMealsKey = GlobalKey();

  final searchMealsKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Meal Tracker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: false,
          actions: [
            _controller.index == 0
                ? IconButton(
                    onPressed: () async {
                      TextEditingController nameController =
                          TextEditingController();
                      TextEditingController calorieController =
                          TextEditingController();
                      File? image;
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return BlocBuilder<MealBloc, MealState>(
                            builder: (context, state) {
                              return Container(
                                height: screenAwareHeight(85.h, context),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onVerticalDragDown: (details) =>
                                            Navigator.pop(context),
                                        child: SvgPicture.asset(
                                            'assets/icons/Divider.svg'),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          SizedBox(
                                              height: screenAwareHeight(
                                                  24, context)),
                                          const Text(
                                            "Add Meal",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(height: 16),
                                          FormInputField(
                                              textEditingController:
                                                  nameController,
                                              title: 'Meal Name'),
                                          FormInputField(
                                              textEditingController:
                                                  calorieController,
                                              title: 'Calories',
                                              textInputType:
                                                  TextInputType.number),
                                          const SizedBox(height: 16),
                                          CustomButton(
                                            isLoading: false,
                                            label: 'Pick an Image',
                                            buttonColor: Colors.white,
                                            textColor: AppColors.primaryColor,
                                            borderColor:
                                                Colors.grey.withOpacity(0.5),
                                            onPressed: () async {
                                              final pickedFile =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedFile != null) {
                                                image = File(pickedFile.path);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomButton(
                                      isLoading: false,
                                      label: 'Add',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                      onPressed: () {
                                        final name = nameController.text;
                                        final calories = int.tryParse(
                                                calorieController.text) ??
                                            0;

                                        if (name.isNotEmpty && calories > 0) {
                                          context.read<MealBloc>().add(AddMeal(
                                              Meal(
                                                  name: name,
                                                  calories: calories,
                                                  time: DateTime.now(),
                                                  photo: image)));
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add))
                : Container(),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: const [
                  MyMealsScreen(),
                  SearchMealsScreen(),
                ],
              ),
            ),
            TabBar(
              controller: _controller,
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  return states.contains(WidgetState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
              indicatorColor: Colors.transparent,
              labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9F9F9F)),
              tabs: [
                Tab(
                    icon: Icon(
                      Icons.fastfood_outlined,
                      color: _controller.index == 0
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    text: 'My Meals'),
                Tab(
                    icon: Icon(
                      Icons.search,
                      color: _controller.index == 1
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    text: 'Search'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
