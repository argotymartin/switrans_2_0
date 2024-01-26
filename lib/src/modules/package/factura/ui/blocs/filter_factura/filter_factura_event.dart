part of 'filter_factura_bloc.dart';

sealed class FilterFacturaEvent extends Equatable {
  const FilterFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFilterFacturaEvent extends FilterFacturaEvent {
  const GetFilterFacturaEvent();
}

class ActiveteFilterFacturaEvent extends FilterFacturaEvent {
  const ActiveteFilterFacturaEvent();
}

class PanelFilterFacturaEvent extends FilterFacturaEvent {
  const PanelFilterFacturaEvent();
}
