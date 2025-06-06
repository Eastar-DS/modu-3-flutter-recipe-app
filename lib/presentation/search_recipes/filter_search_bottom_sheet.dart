import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/data/util/category_enum.dart';
import 'package:recipe_app/data/util/rate_enum.dart';
import 'package:recipe_app/data/util/time_enum.dart';
import 'package:recipe_app/domain/model/filter.dart';
import 'package:recipe_app/presentation/components/filter_button.dart';
import 'package:recipe_app/presentation/components/rating_button.dart';
import 'package:recipe_app/presentation/components/small_button.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_action.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_state.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_view_model.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_view_model.dart';
import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_style.dart';

class FilterSearchBottomSheet extends StatelessWidget {
  final FilterSearchState state;
  final void Function(FilterSearchAction action) onAction;
  const FilterSearchBottomSheet({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Filter Search", style: TextStyles.smallTextBold),
                ),
                SizedBox(height: 20),
                Text("Time", style: TextStyles.smallTextBold),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (final time in Time.values) ...[
                      FilterButton(
                        value: time,
                        color: ColorStyles.primary100,
                        ontap: () {
                          List<Time> times = state.filter.times.toList();
                          if (times.contains(time)) {
                            times =
                                times
                                    .where((element) => element != time)
                                    .toList();
                          } else {
                            times.add(time);
                          }
                          onAction(
                            FilterSearchAction.onFilterTap(
                              state.filter.copyWith(times: times),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),
                    ],
                  ],
                ),
                SizedBox(height: 20),
                Text("Rate", style: TextStyles.smallTextBold),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int index = 0; index < 5; index++) ...[
                      RatingButton(
                        rate: '${index + 1}',
                        color: ColorStyles.primary100,
                        ontap: () {
                          final rateValues = [
                            Rate.star1,
                            Rate.star2,
                            Rate.star3,
                            Rate.star4,
                            Rate.star5,
                          ];
                          List<Rate?> rates = state.filter.rates.toList();
                          final rate = rateValues[index];
                          if (rates.contains(rate)) {
                            rates =
                                rates
                                    .where((element) => element != rate)
                                    .toList();
                          } else {
                            rates.add(rate);
                          }
                          onAction(
                            FilterSearchAction.onFilterTap(
                              state.filter.copyWith(rates: rates),
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 20),
                Text("Category", style: TextStyles.smallTextBold),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      Categories.values
                          .map(
                            (e) => FilterButton(
                              value: e,
                              color: ColorStyles.primary100,
                              ontap: () {
                                // viewModel.onTapButton(e);
                                List<Categories> categories =
                                    state.filter.categories.toList();
                                if (categories.contains(e)) {
                                  categories =
                                      categories
                                          .where((element) => element != e)
                                          .toList();
                                } else {
                                  categories.add(e);
                                }
                                onAction(
                                  FilterSearchAction.onFilterTap(
                                    state.filter.copyWith(
                                      categories: categories,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: SmallButton(
                    name: "Filter",
                    onClick: () async {
                      // await searchViewModel.fetchFilterdRecipes(
                      //   viewModel.state.filter,
                      // );
          
                      onAction(FilterSearchAction.onButtonTap(state.filter));
                    },
                    color: ColorStyles.primary100,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
