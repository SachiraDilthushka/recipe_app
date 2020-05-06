import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/filter_screen.dart';
import 'package:recipeapp/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import './screens/meal_details_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten':false,
    'lactose': false,
    'vegan': false,
    'vegetarian':false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];
  void _setFilters (Map<String, bool> filterData){
setState(() {
  _filters = filterData;
  _availableMeals = DUMMY_MEALS.where((meal){
    if(_filters['gluten'] && !meal.isGlutenFree){
      return false;
    }
    if(_filters['lactose'] && !meal.isLactoseFree){
      return false;
    }
    if(_filters['vegan'] && !meal.isVegan){
      return false;
    }
    if(_filters['vegetarian'] && !meal.isVegetarian){
      return false;
    }

    return true;
  }).toList();
});
  }
  void _toggleFavorite(String mealId){
   final exisingIndex =  _favoriteMeal.indexWhere((meal)=>meal.id==mealId);
   if(exisingIndex>=0){
     setState(() {
       _favoriteMeal.removeAt(exisingIndex);
     });
   }else{
     setState(() {
       _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal)=>meal.id == mealId));
     });
   }
  }
bool _isMealFavorite(String id){
    return _favoriteMeal.any((meal)=> meal.id == id);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromARGB(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromARGB(20, 51, 51, 1)),
              title: TextStyle(
                fontSize: 22,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      //home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        CategoryMealsScreen.routedName: (ctx) => CategoryMealsScreen(_availableMeals),
        '/': (ctx) => TabsScreen(_favoriteMeal),
        MealDetailsScreen.routName: (ctx) => MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routName: (ctx) =>FilterScreen(_filters, _setFilters),
      },
      onUnknownRoute: (setings) {
        return MaterialPageRoute(
          builder: (ctx) => TabsScreen(_favoriteMeal),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DellMeals'),
      ),
      body: Center(
        child: Text('Navigation time'),
      ),
    );
  }
}
