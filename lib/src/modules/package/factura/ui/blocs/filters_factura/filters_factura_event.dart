part of 'filters_factura_bloc.dart';

sealed class FiltersFacturaEvent extends Equatable {
  const FiltersFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFiltersFacturaEvent extends FiltersFacturaEvent {
  const GetFiltersFacturaEvent();
}

class ActiveteFiltersFacturaEvent extends FiltersFacturaEvent {
  const ActiveteFiltersFacturaEvent();
}
