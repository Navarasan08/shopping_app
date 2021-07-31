import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/router.dart';
import 'package:shopping_app/services/firebase_authentication.dart';
import 'package:shopping_app/services/firestore_service.dart';
import 'package:shopping_app/src/auth/bloc/auth_bloc.dart';
import 'package:shopping_app/src/home/bloc/product_bloc.dart';
import 'package:shopping_app/src/utils/loading_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  LoadingUtils.configLoading();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthService authService = FirebaseAuthService();
    FirestoreService firestoreService = FirestoreService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authService: authService,
            firestoreService: firestoreService,
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            authService: authService,
            firestoreService: firestoreService,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          primaryTextTheme: GoogleFonts.openSansTextTheme(),
        ),
        onGenerateRoute: AppRouter.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
