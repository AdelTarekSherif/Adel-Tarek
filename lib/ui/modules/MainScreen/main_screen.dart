import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';
import 'package:adel_tarek/data/model/meal_model.dart';
import 'package:adel_tarek/ui/modules/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:adel_tarek/ui/modules/Home/search_screen.dart';
import 'package:adel_tarek/ui/style/app.colors.dart';

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
          title: const Text('Meal Tracker'),
          bottom: TabBar(
            controller: _controller,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return states.contains(WidgetState.focused)
                    ? null
                    : Colors.transparent;
              },
            ),
            indicatorColor: AppColors.primaryColor,
            labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9F9F9F)),
            tabs: const [
              Tab(text: 'My Meals'),
              Tab(text: 'Search Meals'),
            ],
          ),
          actions: [
            _controller.index == 0
                ? PopupMenuButton<SortOption>(
                    onSelected: (option) =>
                        context.read<MealBloc>().add(SortMeals(option)),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: SortOption.name, child: Text('Sort by Name')),
                      const PopupMenuItem(
                          value: SortOption.calories,
                          child: Text('Sort by Calories')),
                      const PopupMenuItem(
                          value: SortOption.time, child: Text('Sort by Time')),
                    ],
                  )
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
          ],
        ),
      ),
    );
  }
}
