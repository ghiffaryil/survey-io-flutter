part of 'product_prepaid_list_bloc.dart';

@freezed
class ProductPrepaidListEvent with _$ProductPrepaidListEvent {
  const factory ProductPrepaidListEvent.started() = _Started;
  const factory ProductPrepaidListEvent.getProductPrepaidList() = _GetProductPrepaidList;
}