part of 'articles_cubit.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();
}

class ArticlesInitial extends ArticlesState {
  @override
  List<Object> get props => [];
}

class ArticlesLoading extends ArticlesState {
  @override
  List<Object> get props => [];
}

class ArticlesLoaded extends ArticlesState {
  const ArticlesLoaded(this.data);

  final List<Articles> data;

  @override
  List<Object> get props => [data];
}

class ArticlesError extends ArticlesState {
  @override
  List<Object> get props => [];
}

class ArticlesEmpty extends ArticlesState {
  @override
  List<Object> get props => [];
}