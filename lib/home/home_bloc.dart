import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

// Événements
abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

// États
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    // Simuler un chargement
    await Future.delayed(Duration(milliseconds: 500));

    try {
      final products = [
        Product(id: '1', name: 'Chaussures', emoji: '👟', price: 59.99),
        Product(id: '2', name: 'Ballon', emoji: '⚽', price: 29.99),
        Product(id: '3', name: 'Basketball', emoji: '🏀', price: 39.99),
        Product(id: '4', name: 'Camera', emoji: '📷', price: 199.99),
        Product(id: '5', name: 'Shopping', emoji: '🛍️', price: 15.99),
        Product(id: '6', name: 'Cadeau', emoji: '🎁', price: 25.99),
        Product(id: '7', name: 'Roulette', emoji: '🎯', price: 9.99),
      ];

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Erreur de chargement...'));
    }
  }
}
