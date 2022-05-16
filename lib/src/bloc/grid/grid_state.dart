part of 'grid_cubit.dart';

abstract class GridState extends Equatable {
  const GridState();
}

class GridInitial extends GridState {
  @override
  List<Object> get props => [];
}

class GridLoading extends GridState {
  @override
  List<Object> get props => [];
}

class GridLoaded extends GridState {
  GridLoaded(this.data);

  List<Articles>data;

  @override
  List<Object> get props => [data];
}

class GridError extends GridState {
  @override
  List<Object> get props => [];
}

class GridEmpty extends GridState {
  @override
  List<Object> get props => [];
}
