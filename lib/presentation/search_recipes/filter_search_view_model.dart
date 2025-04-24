import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/domain/model/filter.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_state.dart';

class FilterSearchViewModel with ChangeNotifier {
  FilterSearchState _state = FilterSearchState();

  FilterSearchState get state => _state;

  void loadState(Filter filter) {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    _state = _state.copyWith(isLoading: false, filter: filter);
    notifyListeners();
  }

  void onTapFilterButton(Filter filter) {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    _state = _state.copyWith(isLoading: false, filter: filter);
    notifyListeners();
  }
}
