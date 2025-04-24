import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/di/di_setup.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_action.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_bottom_sheet.dart';
import 'package:recipe_app/presentation/search_recipes/filter_search_view_model.dart';

class FilterSearchBottomSheetRoot extends StatefulWidget {
  final FilterSearchViewModel viewModel;
  const FilterSearchBottomSheetRoot({super.key, required this.viewModel});

  @override
  State<FilterSearchBottomSheetRoot> createState() =>
      _FilterSearchBottomSheetRootState();
}

class _FilterSearchBottomSheetRootState
    extends State<FilterSearchBottomSheetRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return FilterSearchBottomSheet(
          state: widget.viewModel.state,
          onAction: (action) {
            switch (action) {
              case OnFilterTap():
                widget.viewModel.onTapFilterButton(action.filter);
                // throw UnimplementedError();
              case OnButtonTap():
                context.pop(action.filter);
            }
          },
        );
      },
    );
  }
}
