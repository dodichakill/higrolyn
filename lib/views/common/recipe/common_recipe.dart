import 'package:agrolyn/providers/common_recipe_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/common/recipe/detail_common_recipe.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class CommonRecipe extends StatelessWidget {
  const CommonRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommonRecipeNotifier(context: context),
      child: Consumer<CommonRecipeNotifier>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Teks Header
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(text: "Mau Masak Apa Hari Ini "),
                                      TextSpan(
                                        text: "Chef?",
                                        style: TextStyle(
                                          color: Colors.green,
                                          decorationColor: Colors.green,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // Sub Header
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Agrolyn ",
                                        style: TextStyle(
                                          color: Colors.green,
                                          decorationThickness: 2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text: "Resep Siap Membantu Kamu!"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 192,
                        width: 334,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.primaryColorDark,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 256,
                              width: 256,
                              child: Lottie.asset(ImageAssets.chef),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "Aneka Masakan"),
                            TextSpan(
                              text: " Nusantara ",
                              style: TextStyle(
                                color: Colors.green,
                                decorationThickness: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "Terpopuler"),
                          ],
                        ),
                      ),
                    ),
                    value.recipes.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.recipes.length,
                            itemBuilder: (context, index) {
                              var recipe = value.recipes[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColorDark,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        recipe['img_recipe'] != null &&
                                                recipe['img_recipe'].isNotEmpty
                                            ? ClipOval(
                                                child: Image.network(
                                                  recipe['img_recipe'],
                                                  fit: BoxFit.cover,
                                                  width: 128,
                                                  height: 128,
                                                ),
                                              )
                                            : const Text(
                                                "img recipe not available"),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${recipe['title']}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                "${recipe['ingredients']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              InkWell(
                                                onTap: () {
                                                  pushWithoutNavBar(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailCommonRecipe(
                                                                  recipe:
                                                                      recipe)));
                                                },
                                                child: Container(
                                                  height: 32,
                                                  width: 160,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Lihat Selengkapnya",
                                                      style: TextStyle(
                                                        color: MyColors
                                                            .primaryColorDark,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text("No Recipes available"),
                          ),
                  ],
                ),
                Positioned(
                    top: 76,
                    right: -10,
                    child: Image.asset(
                      ImageAssets.piring1,
                      width: 250,
                      height: 250,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
