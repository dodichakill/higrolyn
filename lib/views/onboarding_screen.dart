import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/choice_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Mulai',
      onFinish: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isOnboarded', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChoiceUser(),
          ),
        );
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: MyColors.secondaryColorDark,
      ),
      skipTextButton: const Text(
        'Lewati',
        style: TextStyle(
          fontSize: 16,
          color: MyColors.secondaryColorLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        'Masuk',
        style: TextStyle(
          fontSize: 16,
          color: MyColors.secondaryColorLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isOnboarded', true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChoiceUser(),
          ),
        );
      },
      controllerColor: MyColors.secondaryColorDark,
      totalPage: 6,
      headerBackgroundColor: MyColors.secondaryColor,
      pageBackgroundGradient: const LinearGradient(colors: [
        MyColors.secondaryColor,
        MyColors.primaryColor,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      centerBackground: true,
      imageVerticalOffset: 160,
      background: [
        Image.asset(
          ImageAssets.onboarding1,
          height: 300,
          alignment: Alignment.center,
        ),
        Image.asset(
          ImageAssets.onboarding2,
          height: 300,
          alignment: Alignment.center,
        ),
        Image.asset(
          ImageAssets.onboarding3,
          height: 300,
          alignment: Alignment.center,
        ),
        Image.asset(
          ImageAssets.onboarding4,
          height: 300,
          alignment: Alignment.center,
        ),
        Image.asset(
          ImageAssets.onboarding5,
          height: 300,
          alignment: Alignment.center,
        ),
        Image.asset(
          ImageAssets.logo,
          height: 300,
          alignment: Alignment.center,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 300,
              ),
              Text(
                'Sayur & Buah yang Fresh',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Beli hasil olahan/sayur & buah fresh langsung dari petani',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Atasi Masalah Tanamanmu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Ketahui Penyakitnya dan Temukan Solusi terbaiknya di sini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Komunitas Yang Solid',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Kamu bisa saling berdiskusi dengan para petani lainnya di sini',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Chatbot Interaktif',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Kamu juga bisa berdiskusi dengan chatbot tentang informasi pertanian',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Edukasi Pertanian',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tingkatkan Literasimu melalui artikel dan video edukasi pertanian',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Mulai Aja Dulu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Mulai Eksplorasi sekarang juga di Agrolyn: solusi cerdas pertanian masa depan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
