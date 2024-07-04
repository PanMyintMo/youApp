import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/profile/about_card.dart';
import 'package:youapp/profile/user_profile.dart';
import 'package:youapp/routes/profile/profile_routes.dart';
import 'package:youapp/widgets/interest.dart';

class ProfileModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(ProfileRoutes.profile,
            child: (context, args) => const UserProfile()),
        ChildRoute(ProfileRoutes.about,
            child: (context, args) => const AboutCard()),
        ChildRoute(ProfileRoutes.interest,
            child: (context, args) => InterestWidget(
                  profileResponse: args.data,
                )),
      ];
}
