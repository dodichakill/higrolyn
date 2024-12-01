import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/detection/detection_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CardHistory extends StatelessWidget {
  const CardHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushWithoutNavBar(
        context,
        MaterialPageRoute(builder: (context) => DetectionResultScreen()),
      ),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.petaniComunity),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Hawar Daun Bakteri",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "(Bacterial Leaf Blight)",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined,
                      size: 11, color: Colors.grey),
                  const SizedBox(width: 4),
                  FutureBuilder(
                    future: formatRelativeTime("Wed, 13 Nov 2024 21:53:54 GMT"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(color: Colors.grey),
                        );
                      } else {
                        return const CircularProgressIndicator(); // or some other loading indicator
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
