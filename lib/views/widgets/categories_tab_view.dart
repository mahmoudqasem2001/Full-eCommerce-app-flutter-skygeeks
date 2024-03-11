
import 'package:ecommerce_app/views/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_models/home_cubit/home_cubit.dart';

class CategoriesTabView extends StatelessWidget {
  const CategoriesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          buildWhen: (previous, current) =>
              current is HomeLoaded ||
              current is HomeError ||
              current is HomeLoading,
          builder: (context, state) {

            if (state is HomeError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is HomeLoaded) {
              final categories = state.categories;
              return Column(
                children: categories.indexed
                    .map(
                      (e) => CategoryItem(index: e.$1, category: e.$2),
                    )
                    .toList(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}