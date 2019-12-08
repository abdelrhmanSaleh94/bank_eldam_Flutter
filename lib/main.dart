import './screen/donationDetials_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/auth_provider.dart';
// import './screen/login_screen.dart';
import './screen/auth_screen.dart';
import './provider/country_provider.dart';
import './provider/blood_provider.dart';
import './screen/home_screen.dart';
import './provider/post_provider.dart';
import './screen/articalDetils_screen.dart';
import './provider/bloodDonation_provider.dart';
import './screen/articalDetils_screen.dart';
import './screen/add_donation.dart';
import './screen/contact_screen.dart';
import './screen/notificationSetting_screen.dart';
import './screen/information_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(value: CountryProvider()),
          ChangeNotifierProvider.value(value: BloodProvider()),
          ChangeNotifierProvider.value(
            value: PostsProvider(),
          ),
          ChangeNotifierProvider.value(
            value: BloodDonationProvider(),
          ),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: AuthScreen2(),
                  routes: {
                    HomeScreen.routename: (ctx) => HomeScreen(),
                    ArticalDetils.routeName: (ctx) => ArticalDetils(),
                    DonationaDetails.routeName: (ctx) => DonationaDetails(),
                    AddDonationScreen.routeName: (ctx) => AddDonationScreen(),
                    ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
                    InformationScreen.routeName: (ctx) => InformationScreen(),
                    NetficationSettingScreen.routeName:(ctx)=>NetficationSettingScreen(),
                  },
                )));
  }
}
