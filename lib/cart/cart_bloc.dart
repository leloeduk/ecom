import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

// Événements
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class ClearCart extends CartEvent {}

// États
abstract class CartState {}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> items; // Produit -> Quantité

  CartLoaded(this.items);

  double get total {
    return items.entries.fold(0.0, (total, entry) {
      return total + (entry.key.price * entry.value);
    });
  }

  int get itemCount {
    return items.values.fold(0, (sum, quantity) => sum + quantity);
  }
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final newItems = Map<Product, int>.from(currentState.items);

      newItems[event.product] = (newItems[event.product] ?? 0) + 1;
      emit(CartLoaded(newItems));
    } else {
      emit(CartLoaded({event.product: 1}));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final newItems = Map<Product, int>.from(currentState.items);

      newItems.remove(event.product);

      if (newItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(newItems));
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartEmpty());
  }
}
