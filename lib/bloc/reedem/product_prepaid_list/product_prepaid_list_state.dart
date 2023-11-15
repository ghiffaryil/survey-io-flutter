part of 'product_prepaid_list_bloc.dart';

@freezed
class ProductPrepaidListState with _$ProductPrepaidListState {
  const factory ProductPrepaidListState.initial() = _Initial;
  const factory ProductPrepaidListState.loading() = _Loading;
  const factory ProductPrepaidListState.loaded(List<ProductPrepaidList> data) = _Loaded;
  const factory ProductPrepaidListState.error(String message) = _Error;
}
