import 'package:flutter/material.dart';
import 'package:recipe_app/data/model/recipe.dart';
import 'package:recipe_app/presentation/component/filter_list.dart';
import 'package:recipe_app/presentation/component/input_field.dart';
import 'package:recipe_app/presentation/component/recipe_card.dart';
import 'package:recipe_app/presentation/search_recipes.dart/filter_search_bottom_sheet.dart';
import 'package:recipe_app/presentation/search_recipes.dart/filter_search_view_model.dart';
import 'package:recipe_app/presentation/search_recipes.dart/search_recipes_view_model.dart';
import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_style.dart';

class SearchRecipesScreen extends StatelessWidget {
  final SearchRecipesViewModel viewModel;
  const SearchRecipesScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search recipes", style: TextStyles.mediumTextBold),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          child: InputField(
                            label: '',
                            placeHolder: 'Search recipe',
                            controller: TextEditingController(text: ''),
                            onValueChange: (String value) async {
                              await viewModel.fetchSearchedRecipes(value);
                            },
                          ),
                        ),
                        FilterList(
                          ontap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FilterSearchBottomSheet(
                                  viewModel: FilterSearchViewModel(),
                                  searchViewModel: viewModel,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          viewModel.state.isSearched
                              ? "Search Result"
                              : "Recent Search",
                          style: TextStyles.normalTextBold,
                        ),
                        Text(
                          viewModel.state.isSearched ? "255 results" : "",
                          style: TextStyles.smallTextRegular.copyWith(
                            color: ColorStyles.gray3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: viewModel.state.recipeList.length,
                      itemBuilder: (context, index) {
                        List<Recipe> recipes = viewModel.state.recipeList;
                        if (recipes.isEmpty) {
                          return null;
                        }
                        return RecipeCard(recipe: recipes[index], isBig: false);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
