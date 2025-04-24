import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_action.freezed.dart';

@freezed
sealed class IngredientAction with _$IngredientAction{
  const factory IngredientAction.onMenuTap() = OnMenuTap;
  const factory IngredientAction.onShareTap() = OnShareTap;
  const factory IngredientAction.onRateTap() = OnRateTap;
  const factory IngredientAction.onReviewTap() = OnReviewTap;
  const factory IngredientAction.onUnsaveTap() = OnUnsaveTap;
}