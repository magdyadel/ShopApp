import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Screens/auth_screen.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Screens/user_products_screen.dart';
//import 'HomePage/homePage.dart';
import './Screens/products_overview_screen.dart';
import './Screens/product_detail_screen.dart';
import './Providers/products.dart';
import 'Providers/auth.dart';
import 'Providers/cart.dart';
import 'Screens/splash_screen.dart';
//HomePage
//import 'package:english_words/english_words.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (ctx)=>Auth(),
      ),
      ChangeNotifierProxyProvider <Auth,Products>(
        update: (ctx ,auth ,previousProducts) => Products(
          auth.token,
          auth.userId,
          previousProducts==null?[]: previousProducts.items,
        ),
      ),
      ChangeNotifierProvider(
        create: (ctx)=>Cart(),
      ),
      ChangeNotifierProxyProvider <Auth,Orders>(
        update: (ctx ,auth ,previousOrders) => Orders(
          auth.token,
          auth.userId,
          previousOrders==null?[]: previousOrders.orders,
        ),
      ),
    ],
    child: Consumer<Auth>(
      builder:(ctx,auth,_)=>MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        home: auth.isAuth
          ?ProductsOverviewScreen()
          :FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx,authResultSnapshot)=>
                authResultSnapshot.connectionState==ConnectionState.waiting
                    ?SplashScreen():AuthScreen(),
        ),
        routes: {
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
          CartScreen.routeName:(ctx)=>CartScreen(),
          OrdersScreen.routeName:(ctx)=>OrdersScreen(),
          UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
          EditProductScreen.routeName:(ctx)=>EditProductScreen(),
        },
      ),
    ),
  ));
}
