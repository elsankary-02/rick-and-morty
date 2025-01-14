import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/models/results_model.dart';
import 'package:rick_and_morty/data/web_services/character_api.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final ApiService apiService;
  CharacterCubit(this.apiService) : super(CharacterInitial());






  
  Future<void> fetchAllCharacter() async {
    emit(CharactersLoading());
    try {
      var response = await apiService.getApi();
      List<Results> allCharacter = [];
      var data = response['results'] as List;
      for (var details in data) {
        allCharacter.add(
          Results.fromJson(details),
        );
      }
      emit(
        CharactersSuccess(allCharacter),
      );
    } on Exception catch (e) {
      emit(
        CharactersFailuer(
          errorMassage: e.toString(),
        ),
      );
    }
  }
}
