import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/services/firebase_authentication.dart';
import 'package:shopping_app/services/firestore_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({this.firestoreService, this.authService})
      : super(ProductInitial());
  final FirestoreService firestoreService;
  final FirebaseAuthService authService;

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProduct) {
      try {
        List<Product> products = await firestoreService.getData();

        yield (ProductLoaded(products));
      } catch (e) {
        print(e);
        yield (ProductFetchingError("Something went wrong"));
      }
    }

    if (event is RemoveProduct) {
      List<Product> products = (state as ProductLoaded).products;

      products.remove(event.product);
        yield (ProductInitial());

      emit(ProductLoaded(products));
    }
  }
}
