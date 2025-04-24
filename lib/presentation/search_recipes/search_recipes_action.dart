import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/domain/model/filter.dart';

part 'search_recipes_action.freezed.dart';

@freezed
sealed class SearchRecipesAction with _$SearchRecipesAction{
  const factory SearchRecipesAction.onValueChange(String value, Filter filter) = OnValueChange;
  const factory SearchRecipesAction.onFilterTap(String value, Filter filter) = OnFilterTap;
}