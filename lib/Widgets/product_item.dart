
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/auth.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/product.dart';

import '../Screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
 // final String id;
 // final String title;
 // final String imageUrl;
 //
 // ProductItem(this.id,this.title,this.imageUrl,);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    final authData = Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            //عشان اغير الFavorite
            builder:(ctx,product,child)=> IconButton(
              icon: Icon(
                  product.isFavorite? Icons.favorite:Icons.favorite_border,
              ),
              onPressed: (){
                product.toggleFavoriteStatus(authData.token,authData.userId);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            //عشان اغير ف الCart
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added Item To Cart!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',onPressed: (){
                      cart.removeSingleItem(product.id);
                    },),
                  ),
              );
            },
            color: Theme.of(context).accentColor,
          ),

        ),
      ),
    );
  }
}
