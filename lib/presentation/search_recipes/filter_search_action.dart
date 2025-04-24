import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/domain/model/filter.dart';

part 'filter_search_action.freezed.dart';

@freezed
sealed class FilterSearchAction with _$FilterSearchAction{
  const factory FilterSearchAction.onFilterTap(Filter filter) = OnFilterTap;
  const factory FilterSearchAction.onButtonTap(Filter filter) = OnButtonTap;
}