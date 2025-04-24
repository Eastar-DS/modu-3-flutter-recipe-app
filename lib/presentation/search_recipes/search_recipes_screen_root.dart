import 'package:flutter/material.dart';
import 'package:recipe_app/core/di/di_setup.dart';
import 'package:recipe_app/domain/model/filter.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_bottom_sheet.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_bottom_sheet_root.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_state.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_view_model.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_action.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_screen.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_view_model.dart';

class SearchRecipesScreenRoot extends StatefulWidget {
  final SearchRecipesViewModel viewModel;
  const SearchRecipesScreenRoot({super.key, required this.viewModel});

  @override
  State<SearchRecipesScreenRoot> createState() =>
      _SearchRecipesScreenRootState();
}

class _SearchRecipesScreenRootState extends State<SearchRecipesScreenRoot> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        widget.viewModel.fetchAllRecipes();
        widget.viewModel.whenOpenScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return SearchRecipesScreen(
          state: widget.viewModel.state,
          onAction: (action) async {
            switch (action) {
              case OnFilterTap():
                final filter = await showModalBottomSheet<Filter>(
                  context: context,
                  builder: (context) {
                    final FilterSearchViewModel viewModel = getIt();
                    viewModel.loadState(widget.viewModel.state.filter);
                    return FilterSearchBottomSheetRoot(viewModel: viewModel);
                  },
                );
                print("filter : $filter");
                if (filter != null) {
                  widget.viewModel.setFilter(filter);
                }
                widget.viewModel.onAction(
                  SearchRecipesAction.onFilterTap(action.value, action.filter),
                );
              case OnValueChange():
                widget.viewModel.getSearchedRecipes(action.value, action.filter);
            }
          },
        );
      },
    );
  }
}
