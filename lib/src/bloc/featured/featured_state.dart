part of 'featured_cubit.dart';

abstract class FeaturedState extends Equatable {
  const FeaturedState();
}

class FeaturedInitial extends FeaturedState {
  @override
  List<Object> get props => [];
}

class FeaturedLoading extends FeaturedState {
  @override
  List<Object> get props => [];
}

class FeaturedLoaded extends FeaturedState {
  FeaturedLoaded(this.data);

  List<Articles>data;

  @override
  List<Object> get props => [data];
}

class FeaturedError extends FeaturedState {
  @override
  List<Object> get props => [];
}

class FeaturedEmpty extends FeaturedState {
  @override
  List<Object> get props => [];
}