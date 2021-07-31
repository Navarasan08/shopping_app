import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/auth/bloc/auth_bloc.dart';
import 'package:shopping_app/src/auth/ui/login_screen.dart';
import 'package:shopping_app/src/home/bloc/product_bloc.dart';
import 'package:shopping_app/src/home/ui/poduct_page.dart';
import 'package:shopping_app/src/utils/loading_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _img =
      "https://img.etimg.com/thumb/width-1200,height-900,imgsize-187943,resizemode-1,msid-73295900/news/sports/ms-dhoni-dropped-from-bccis-central-contracts-list.jpg";

  int _currentIndex = 0;

  List<Map> _tabs = [
    {
      "title": "Mobile",
      "icon": Icons.phone_android,
    },
    {
      "title": "TV",
      "icon": Icons.tv,
    },
    {"title": "Clothings", "icon": Icons.person},
    {
      "title": "Gaming",
      "icon": Icons.gamepad,
    },
  ];

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = (context.read<AuthBloc>().state as LoggedIn).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 2.0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(_img),
          ),
          title: Text(
            "Shopping Cart",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showLogoutDialog(context);
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductFetchingError) {
            return Center(child: Text(state.error));
          }

          if (state is ProductLoaded) {
            return IndexedStack(
              index: _currentIndex,
              children: _tabs
                  .map(
                    (e) => ProductPage(
                      products: state.products
                          .where((prod) =>
                              int.parse(prod.categoryId) ==
                              _tabs.indexOf(e) + 1)
                          .toList(),
                    ),
                  )
                  .toList(),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int tab) {
          setState(() {
            _currentIndex = tab;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        items: _tabs
            .map((e) => BottomNavigationBarItem(
                icon: Icon(e['icon']), label: e['title']))
            .toList(),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Signout"),
              content: Text("are you sure to signout?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel")),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(LogOut());
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    child: Text("ok")),
              ],
            ));
  }
}
