import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/router.dart';
import 'package:shopping_app/src/auth/bloc/auth_bloc.dart';

class CustomSplash extends StatefulWidget {
  @override
  _CustomSplashState createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(CheckAuthenticated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {

        if (state is UnAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
        }

        if (state is LoggedIn) {
          Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
