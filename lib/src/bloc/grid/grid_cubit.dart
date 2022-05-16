

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/api_response.dart';
import 'grid_repository.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit() : super(GridInitial());

  GridRepository repository = GridRepository();

  fetchGrid() async {
    try {
      emit(GridLoading());
      final response = await repository.fetchGrid();
      List<Articles> data = response.articles!;
      var randomData = data..shuffle();
      data.length = 4;
      emit(GridLoaded(randomData));
    } catch (ex) {
      emit(GridError());
    }
  }
}
