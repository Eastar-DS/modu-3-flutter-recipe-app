import 'package:flutter/material.dart';
import 'package:recipe_app/domain/model/filter.dart';
import 'package:recipe_app/domain/repository/recipe_repository.dart';
import 'package:recipe_app/data/util/rate_enum.dart';
import 'package:recipe_app/data/util/time_enum.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_action.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_state.dart';

class SearchRecipesViewModel with ChangeNotifier {
  final RecipeRepository _recipeRepository;

  SearchRecipesState _state = SearchRecipesState();

  SearchRecipesViewModel({required RecipeRepository recipeRepository})
    : _recipeRepository = recipeRepository;

  SearchRecipesState get state => _state;

  void onAction(SearchRecipesAction action) async {
    switch (action) {
      case OnFilterTap():
        await getSearchedRecipes(action.value, action.filter);
        break;
      case OnValueChange():
        await getSearchedRecipes(action.value, action.filter);
    }
  }

  void setFilter(Filter filter) {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    _state = _state.copyWith(isLoading: false, filter: filter);
    notifyListeners();
  }

  void whenOpenScreen() {
    _state = _state.copyWith(isLoading: false, isSearched: false);
    notifyListeners();
  }

  void fetchAllRecipes() async {
    _state = _state.copyWith(isLoading: true);
    if (_state.recipeList.isNotEmpty) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      return;
    }
    notifyListeners();

    final recipes = await _recipeRepository.getRecipes();
    _state = _state.copyWith(recipeList: recipes, isLoading: false);
    notifyListeners();
  }

  Future<void> getSearchedRecipes(String value, Filter filter) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();
    final recipes = await _recipeRepository.getRecipes();
    final searchedRecipes =
        recipes.where((element) {
          return element.title.toLowerCase().contains(value.toLowerCase());
        }).toList();
    // final filterdRecipes =
    //     searchedRecipes.where((element) {
    //       if (filter.times.contains((element.createdAt ?? Time.all)) ||
    //           (filter.rates.contains(doubleToRate(element.rating))) ||
    //           (filter.categories.contains(element.category))) {
    //         return true;
    //       }
    //       return false;
    //     }).toList();
    print(searchedRecipes);
    final filterdRecipes =
        (filter.categories == [] && filter.rates == [] && filter.times == [])
            ? searchedRecipes.toList()
            : searchedRecipes.where((element) {
              if (filter.times.contains((element.createdAt ?? Time.all)) ||
                  (filter.rates.contains(doubleToRate(element.rating))) ||
                  (filter.categories.contains(element.category))) {
                return true;
              }
              return false;
            }).toList();
    print("filterdRecipes : $filterdRecipes");
    _state = _state.copyWith(
      isSearched: value == '' ? false : true,
      isLoading: false,
      searchText: value,
      recipeList: filterdRecipes,
    );
    print(_state);
    notifyListeners();
  }

  Rate doubleToRate(double num) {
    if (num.ceil() == 2) {
      return Rate.star2;
    } else if (num.ceil() == 3) {
      return Rate.star3;
    } else if (num.ceil() == 4) {
      return Rate.star4;
    } else if (num.ceil() == 5) {
      return Rate.star5;
    } else {
      return Rate.star1;
    }
  }
}
