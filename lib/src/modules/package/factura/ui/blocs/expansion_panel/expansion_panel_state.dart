part of 'expansion_panel_cubit.dart';

abstract class ExpansionPanelState extends Equatable {
  final bool expanded;
  const ExpansionPanelState({this.expanded = false});

  @override
  List<Object> get props => [];
}

class ExpansionPanelInitial extends ExpansionPanelState {}
