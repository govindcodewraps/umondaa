import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:umonda/other_config.dart';
import 'package:umonda/presenter/cart_counter.dart';
import 'package:umonda/presenter/currency_presenter.dart';
import 'package:umonda/presenter/home_presenter.dart';
import 'package:umonda/screens/New_Home_Screen/new_home_presenter.dart';
import 'package:umonda/screens/address.dart';
import 'package:umonda/screens/cart.dart';
import 'package:umonda/screens/category_list.dart';
import 'package:umonda/screens/digital_product/digital_products.dart';
import 'package:umonda/screens/login.dart';
import 'package:umonda/screens/main.dart';
import 'package:umonda/screens/map_location.dart';
import 'package:umonda/screens/messenger_list.dart';
import 'package:umonda/screens/order_details.dart';
import 'package:umonda/screens/order_list.dart';
import 'package:umonda/screens/product_reviews.dart';
import 'package:umonda/screens/profile.dart';
import 'package:umonda/screens/refund_request.dart';
import 'package:umonda/screens/splash_screen.dart';
import 'package:umonda/screens/todays_deal_products.dart';
import 'package:umonda/screens/top_selling_products.dart';
import 'package:umonda/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/screens/splash.dart';
import 'package:shared_value/shared_value.dart';
import 'package:umonda/helpers/shared_value_helper.dart';
import 'dart:async';
import 'app_config.dart';
import 'package:umonda/services/push_notification_service.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:umonda/providers/locale_provider.dart';
import 'firebase_options.dart';
import 'lang_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auction_products.dart';
import 'screens/auction_products_details.dart';
import 'screens/brand_products.dart';
import 'screens/category_products.dart';
import 'screens/chat.dart';
import 'screens/checkout.dart';
import 'screens/classified_ads/classified_ads.dart';
import 'screens/classified_ads/classified_product_details.dart';
import 'screens/classified_ads/my_classified_ads.dart';
import 'screens/club_point.dart';
import 'screens/digital_product/digital_product_details.dart';
import 'screens/digital_product/purchased_digital_produts.dart';
import 'screens/flash_deal_list.dart';
import 'screens/flash_deal_products.dart';
import 'screens/home.dart';
import 'screens/package/packages.dart';
import 'screens/product_details.dart';
import 'screens/seller_details.dart';
import 'screens/seller_products.dart';


main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  FlutterDownloader.initialize(
      debug: true,
      // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true //
    // : set to false to disable working with http links (default: false)
      );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // AddonsHelper().setAddonsData();
  // BusinessSettingHelper().setBusinessSettingData();
  // app_language.load();
  // app_mobile_language.load();
  // app_language_rtl.load();
  //
  // access_token.load().whenComplete(() {
  //   AuthHelper().fetch_and_set();
  // });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));



  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for receiving push notifications (if not already granted)
  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    // Permission granted, fetch FCM token
    String fcmToken = await messaging.getToken();
    print("FCM Tokennnn: $fcmToken");
  } else {
    print("Permission denied for push notifications");
  }



  runApp(
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   Future.delayed(Duration.zero).then(
  //     (value) async {
  //       Firebase.initializeApp().then((value) {
  //         if (OtherConfig.USE_PUSH_NOTIFICATION) {
  //           Future.delayed(Duration(milliseconds: 10), () async {
  //             PushNotificationService().initialise();
  //           });
  //         }
  //       });
  //     },
  //   );
  // }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then(
          (value) async {
        Firebase.initializeApp().then((value) {
          if (OtherConfig.USE_PUSH_NOTIFICATION) {
            Future.delayed(Duration(milliseconds: 10), () async {
              PushNotificationService().initialise();
            });
          }
        });
      },
    );

    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String token) {
      print("Device Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message opened: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (context) => CartCounter()),
          ChangeNotifierProvider(create: (context) => CurrencyPresenter()),
          ChangeNotifierProvider(create: (context) => HomePresenter()),
          ChangeNotifierProvider(create: (context) => AllHomePresenter())
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
            initialRoute: "/",
            routes:
              {
                "/":(context)=>SplashScreen(),
                "/classified_ads":(context)=>ClassifiedAds(),
                "/classified_ads_details":(context)=>ClassifiedAdsDetails(id:0),
                "/my_classified_ads":(context)=>MyClassifiedAds(),
                "/digital_product_details":(context)=>DigitalProductDetails(id: 0,),
                "/digital_products":(context)=>DigitalProducts(),
                "/purchased_digital_products":(context)=>PurchasedDigitalProducts(),
                "/update_package":(context)=>UpdatePackage(),
                "/address":(context)=>Address(),
                "/auction_products":(context)=>AuctionProducts(),
                "/auction_products_details":(context)=>AuctionProductsDetails(id: 0),
                "/brand_products":(context)=>BrandProducts(id: 0,brand_name: ""),
                "/cart":(context)=>Cart(),
                "/category_list":(context)=>CategoryList(parent_category_id: 0,is_base_category: true,parent_category_name: "",is_top_category: false),
                "/category_products":(context)=>CategoryProducts(category_id: 0,category_name: ""),
                "/chat":(context)=>Chat(),
                "/checkout":(context)=>Checkout(),
                "/clubpoint":(context)=>Clubpoint(),
                "/flash_deal_list":(context)=>FlashDealList(),
                "/flash_deal_products":(context)=>FlashDealProducts(),
                "/home":(context)=>Home(),
                "/login":(context)=>Login(),
                "/main":(context)=>Main(),
                "/map_location":(context)=>MapLocation(),
                "/messenger_list":(context)=>MessengerList(),
                "/order_details":(context)=>OrderDetails(),
                "/order_list":(context)=>OrderList(),
                "/product_details":(context)=>ProductDetails(id: 0,),
                "/product_reviews":(context)=>ProductReviews(id: 0,),
                "/profile":(context)=>Profile(),
                "/refund_request":(context)=>RefundRequest(),
                "/seller_details":(context)=>SellerDetails(id: 0,),
                "/seller_products":(context)=>SellerProducts(),
                "/todays_deal_products":(context)=>TodaysDealProducts(),
                "/top_selling_products":(context)=>TopSellingProducts(),
                "/wallet":(context)=>Wallet(),

              },
            builder: OneContext().builder,
            navigatorKey: OneContext().navigator.key,
            title: AppConfig.app_name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyTheme.white,
              scaffoldBackgroundColor: MyTheme.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: MyTheme.accent_color,
              /*textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(fontSize: 12.0),
            )*/
              //
              // the below code is getting fonts from http
              textTheme: GoogleFonts.publicSansTextTheme(textTheme).copyWith(
                bodyText1:
                    GoogleFonts.publicSans(textStyle: textTheme.bodyText1),
                bodyText2: GoogleFonts.publicSans(
                    textStyle: textTheme.bodyText2, fontSize: 12),
              ),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: LangConfig().supportedLocales(),
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if (AppLocalizations.delegate.isSupported(deviceLocale)) {
                return deviceLocale;
              }
              return const Locale('en');
            },
            //home: SplashScreen(),
            // home: Splash(),
          );
        }));
  }
}
