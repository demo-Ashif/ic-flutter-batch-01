import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_shop/features/products/domain/product_category.dart';

import '../../../../core/utils/enums/gender_age_category_enum.dart';
import '../../../shared/widgets/app_bar_bottom.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static const path = '/search';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final categoryFamilyKey = GlobalKey();
  final genderAgeCategoryFamilyKey = GlobalKey();
  final productAdapterFamilyKey = GlobalKey();
  final searchController = TextEditingController();

  int page = 1;

  final typingNotifier = ValueNotifier(false);

  // void search({
  //   required ProductCategoryModel category,
  //   required GenderAgeCategory genderAgeCategory,
  // }) {
  //   typingNotifier.value = false;
  //   final productAdapter =
  //       //ref.read(productAdapterProvider(productAdapterFamilyKey).notifier);
  //       context.read<ProductPopularCubit>();
  //   if (category.name!.toLowerCase() != 'all') {
  //     // means that the genderAgeCategory is considered
  //     if (genderAgeCategory.title.toLowerCase() != 'all') {
  //       // means we have a specification and they are
  //       // both not [all]
  //       productAdapter.searchByCategoryAndGenderAgeCategory(
  //         query: searchController.text.trim(),
  //         categoryId: category.id,
  //         genderAgeCategory: genderAgeCategory.title.toLowerCase(),
  //         page: page,
  //       );
  //     } else {
  //       // means we have only category specified
  //       productAdapter.searchByCategory(
  //         query: searchController.text.trim(),
  //         categoryId: category.id,
  //         page: page,
  //       );
  //     }
  //   } else {
  //     productAdapter.searchAllProducts(
  //       query: searchController.text.trim(),
  //       page: page,
  //     );
  //   }
  // }
  //
  // Widget body({
  //   required ProductPopularState productAdapter,
  // }) {
  //   if (productAdapter is Searching) {
  //     return Center(child: Lottie.asset(Media.searching));
  //   } else if (productAdapter is ProductsFetched) {
  //     var products = productAdapter.products;
  //     if (products.isEmpty) {
  //       return const Center(child: EmptyData('No Products Found'));
  //     }
  //
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 20),
  //       child: SingleChildScrollView(
  //         child: Center(
  //           child: Wrap(
  //             runSpacing: 10,
  //             runAlignment: WrapAlignment.center,
  //             spacing: 10,
  //             children: products
  //                 .map((product) => ClassicProductTile(product))
  //                 .toList(),
  //           ),
  //         ),
  //       ),
  //     );
  //   } else if (productAdapter is ProductError) {
  //     return const EmptyData('No Products Found');
  //   }
  //   return Center(
  //     child: Lottie.asset(
  //       context.isDarkMode ? Media.search : Media.searchLight,
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => typingNotifier.value = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: const AppBarBottom(),
      ),
      body: Container(),

      // SafeArea(
      //   child: BlocConsumer<CategoryNotifier, ProductCategory>(
      //     builder: (context, state) {
      //       return Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.symmetric(
      //               horizontal: 20,
      //             ).copyWith(top: 30),
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 SearchSection(
      //                   controller: searchController,
      //                   suffixIcon: IconButton(
      //                     onPressed: () {
      //                       search(
      //                         category: context.read<CategoryNotifier>().state,
      //                         genderAgeCategory: context
      //                             .read<GenderAgeCategoryNotifier>()
      //                             .state,
      //                       );
      //                     },
      //                     icon: const Iconify(
      //                       Majesticons.send,
      //                       color: Colours.lightThemePrimaryColour,
      //                     ),
      //                   ),
      //                 ),
      //                 const Gap(20),
      //                 BlocBuilder<CategoryNotifier, ProductCategory>(
      //                   builder: (context, state) {
      //                     return CategorySelector(
      //                       selectedCategory: state,
      //                       onSelected: (category) {
      //                         context
      //                             .read<CategoryNotifier>()
      //                             .changeCategory(category);
      //                       },
      //                     );
      //                   },
      //                 ),
      //                 const Gap(10),
      //                 //  Text(context.read<CategoryNotifier>().state.name!.toLowerCase()),
      //                 if (state.name!.toLowerCase() != 'all') ...[
      //                   BlocBuilder<GenderAgeCategoryNotifier,
      //                       GenderAgeCategory>(
      //                     builder: (context, state) {
      //                       return GenderAgeCategorySelector(
      //                         selectedGenderAgeCategory: state,
      //                         onSelected: (category) {
      //                           context
      //                               .read<GenderAgeCategoryNotifier>()
      //                               .changeCategory(category);
      //                         },
      //                       );
      //                     },
      //                   ),
      //                   const Gap(10),
      //                 ]
      //               ],
      //             ),
      //           ),
      //           //lottie animation
      //           BlocBuilder<ProductPopularCubit, ProductPopularState>(builder:(context, state){
      //             return Expanded(
      //               child: ValueListenableBuilder(
      //                   valueListenable: typingNotifier,
      //                   builder: (_, typing, __) {
      //                     if (typing) {
      //                       return Center(child: Lottie.asset(Media.searching));
      //                     }
      //                     return body(
      //                       productAdapter:state,
      //                     );
      //                   }),
      //             );
      //           }),
      //         ],
      //       );
      //     },
      //     listener: (context, state) {},
      //   ),
      // ),
    );
  }
}
