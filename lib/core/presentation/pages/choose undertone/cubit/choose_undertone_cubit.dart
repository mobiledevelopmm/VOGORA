
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/style_profile_service.dart';
import 'choose_undertone_state.dart';

class ChooseUndertoneCubit extends Cubit<ChooseUndertoneState> {
  final StyleProfileService _styleProfileService;

  ChooseUndertoneCubit(this._styleProfileService)
      : super(const ChooseUndertoneState());

  void selectUndertone(String undertone) {
    if (!['Cool', 'Warm', 'Neutral'].contains(undertone)) {
      return;
    }

    emit(
      state.copyWith(
        selectedUndertone: undertone,
        status: ChooseUndertoneStatus.initial,
        errorMessage: null,
      ),
    );
  }

  Future<bool> saveUndertone() async {
    final undertone = state.selectedUndertone;

    if (undertone == null) {
      emit(
        state.copyWith(
          status: ChooseUndertoneStatus.failure,
          errorMessage: 'Please choose your undertone first.',
        ),
      );
      return false;
    }

    emit(
      state.copyWith(
        status: ChooseUndertoneStatus.saving,
        errorMessage: null,
      ),
    );

    try {
      await _styleProfileService.saveUndertone(undertone);

      emit(
        state.copyWith(
          status: ChooseUndertoneStatus.success,
          errorMessage: null,
        ),
      );

      return true;
    } catch (error) {
      emit(
        state.copyWith(
          status: ChooseUndertoneStatus.failure,
          errorMessage: 'Unable to save your undertone. Please try again.',
        ),
      );

      return false;
    }
  }
}