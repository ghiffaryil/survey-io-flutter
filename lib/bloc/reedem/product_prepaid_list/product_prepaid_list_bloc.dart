import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/reedem/reedem_product_prepaid_list_datasource.dart';
import 'package:survey_io/models/reedem/product_prepaid_response_model.dart';

part 'product_prepaid_list_event.dart';
part 'product_prepaid_list_state.dart';
part 'product_prepaid_list_bloc.freezed.dart';

class ProductPrepaidListBloc
    extends Bloc<ProductPrepaidListEvent, ProductPrepaidListState> {
  ProductPrepaidListBloc() : super(const _Initial()) {
    on<_GetProductPrepaidList>((event, emit) async {
      emit(const _Loading());
      final response =
          await ProductPrepaidListDatasource().getListProductPrepaid();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
