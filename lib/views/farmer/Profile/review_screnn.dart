import 'package:agrolyn/api/review_service.dart';
import 'package:agrolyn/providers/profile_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/rating_star.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNotifier(context: context),
      child: Consumer<ProfileNotifier>(builder: (context, value, child) {
        Future<void> _submitForm(BuildContext context) async {
          if (value.keyfrom.currentState!.validate()) {
            value.setLoading(true);
            value.setReviewUser(value.reviewController.text);

            final rating = value.ratingUser; // Get rating from ProfileNotifier
            if (rating == 0) {
              value.setLoading(false);
              showCustomSnackbar(context, "Error",
                  "Pilih rating terlebih dahulu", ContentType.failure);
              return;
            }

            final data = {
              "rating": rating, // rating is now an int
              "review": value.reviewUser,
            };

            // Debugging: Cetak data yang dikirim ke server
            print(
                'Data yang dikirim ke server: $data'); // Cetak data yang akan dikirim

            try {
              final result = await ReviewService().fetchNewReview(data);
              value.setLoading(false);

              if (result == "Ulasan berhasil ditambahkan") {
                showCustomSnackbar(context, "Berhasil Ditambahkan",
                    "Ulasan Berhasil Ditambahkan", ContentType.success);
                value.setReviewSubmitted(); // Mark review as submitted
                await Future.delayed(const Duration(seconds: 1));
                Navigator.pop(context);
              } else {
                showCustomSnackbar(context, "Gagal Ditambahkan",
                    result ?? "Ulasan Gagal Ditambahkan", ContentType.failure);
              }
            } catch (error) {
              value.setLoading(false);
              showCustomSnackbar(context, "Error", "Terjadi kesalahan: $error",
                  ContentType.failure);
            }
          }
        }

        return Scaffold(
          body: Stack(
            children: [
              Lottie.asset(
                ImageAssets.backgorundAnimation, // Path animasi Anda
                width: double.infinity, // Lebar penuh
                height: double.infinity, // Tinggi penuh
                fit: BoxFit.cover, // Menyesuaikan animasi agar memenuhi area
              ),
              Form(
                key: value.keyfrom,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 32),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageAssets.logo,
                                  height: 192,
                                  width: 192,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Agrolyn',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primaryColor),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Apps',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Silahkan Beri Rating dan Ulasan kamu Disini',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Section: Rating Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              RatingStars(
                                initialRating: value
                                    .ratingUser, // Initial value from ProfileNotifier
                                onRatingChanged: (newRating) {
                                  value.setRatingUser(
                                      newRating); // Update rating in ProfileNotifier
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Section: Review Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.reviewController,
                                decoration: InputDecoration(
                                  labelText: 'Ulasan',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Ulasan Tidak Boleh Kosong";
                                  }
                                  return null; // Mengembalikan null jika valid
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Section: Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () => _submitForm(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: value.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Beri Ulasan',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
