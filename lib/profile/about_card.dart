import 'package:flutter/material.dart';
import 'package:youapp/module/profile/profile_module.dart';
import 'package:youapp/routes/profile/profile_routes.dart';
import 'package:youapp/util/app_router.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E191F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  AppRouter.changeRoute<ProfileModule>(
                      ProfileRoutes.editProfile);
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          buildInfoRow('Birthday:', '28 / 08 / 1995 (Age 28)'),
          buildInfoRow('Horoscope:', 'Virgo'),
          buildInfoRow('Zodiac:', 'Pig'),
          buildInfoRow('Height:', '175 cm'),
          buildInfoRow('Weight:', '69 kg'),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade400,
              ),
            ),
            TextSpan(
              text: ' $value',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
