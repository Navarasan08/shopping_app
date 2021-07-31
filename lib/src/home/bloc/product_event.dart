part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {}

class RemoveProduct extends ProductEvent {
  final Product product;

  RemoveProduct(this.product);
}
