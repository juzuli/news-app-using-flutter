import 'package:bloc/bloc.dart';
import 'package:citizens/src/bloc/articles/articles_repository.dart';
import 'package:citizens/src/model/api_response.dart';
import 'package:equatable/equatable.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  ArticlesRepository repository= ArticlesRepository();

  fetchArticles()async{
    try{
      emit(ArticlesLoading());
      final response= await repository.fetchArticles();
      List<Articles>data=response.articles!;
      emit(ArticlesLoaded(data));
    }catch(ex){
      emit(ArticlesError());
    }
  }
}
