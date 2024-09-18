import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_current_location.dart';
import 'package:food_delivery_app/components/my_description_box.dart';
import 'package:food_delivery_app/components/my_drawer.dart';
import 'package:food_delivery_app/components/my_food_tile.dart';
import 'package:food_delivery_app/components/my_sliver_appbar.dart';
import 'package:food_delivery_app/components/my_tab_bar.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/resturant.dart';
import 'package:food_delivery_app/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // tab controller
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return a list of food item that belongs to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //return list of foods in the given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      //get category menu
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
          itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, index) {
            //get indivisual food
            final food = categoryMenu[index];
            //return food tile UI
            return FoodTile(
              food: food,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => FoodPage(food: food),
                  ),
                );
              },
            );
            //  ListTile(
            //   title: Text(categoryMenu[index].name),
            // );
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // my current Location
                MyCurrentLocation(),
                // description box
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Resturant>(
          builder: (context, resturant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(resturant.menu),
            //[
            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Text('First tab item'),
            // ),
            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Text('Second tab item'),
            // ),
            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Text('Third tab item'),
            // ),
            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Text('Fourth tab item'),
            // ),
            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) => Text('Fifth tab item'),
            // ),          ],
          ),
        ),
      ),
    );
  }
}
