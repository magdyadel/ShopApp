import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/badge.dart';
import 'package:shop_app/Widgets/products_grid.dart';
import '../Widgets/badge.dart';
import '../Providers/cart.dart';

enum FilterOptions{Favorites,All,}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites=false;
  var _isInit=true;
  var _isLoading=false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_){
        setState(() {
          _isLoading=false;
        });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer=Provider.of<Products>(context,listen: false,);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("MyShop"),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue==FilterOptions.Favorites){
                  _showOnlyFavorites=true;
                  // productsContainer.showFavoritesOnly();
                }
                else{
                  _showOnlyFavorites=false;
                  // productsContainer.showAll();
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_,cart,ch)=> Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon:Icon(Icons.shopping_cart,),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),

      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ): new ProductsGrid(_showOnlyFavorites),
    );
  }
}
