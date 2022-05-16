import 'package:bloc/bloc.dart';
import 'package:citizens/src/model/api_response.dart';
import 'package:equatable/equatable.dart';

import 'featured_repository.dart';

part 'featured_state.dart';

class FeaturedCubit extends Cubit<FeaturedState> {
  FeaturedCubit() : super(FeaturedInitial());

  FeaturedRepository repository = FeaturedRepository();

  fetchFeatured() async {
    try {
      emit(FeaturedLoading());
      final response = await repository.fetchFeatured();
      List<Articles> data = response.articles!;
      emit(FeaturedLoaded(data));
    } catch (ex) {
      emit(FeaturedError());
    }
  }
}
