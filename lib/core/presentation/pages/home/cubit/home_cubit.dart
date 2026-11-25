
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/services/outfit_service.dart';
import '../../../../data/models/outfit_item_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final OutfitService _outfitService;

  StreamSubscription<List<OutfitItem>>? _styledSubscription;

  HomeCubit(this._outfitService) : super(const HomeState());

  Future<void> loadOutfits(String gender) async {
    await _cancelSubscription();

    if (isClosed) return;

    emit(state.copyWith(
      status: HomeStatus.loading,
      errorMessage: null,
    ));

    _styledSubscription = _outfitService
        .getOutfits(
      gender: gender,
      type: 'styled_for_you',
    )
        .listen(
          (outfits) {
        if (isClosed) return;

        emit(state.copyWith(
          status: HomeStatus.success,
          styledOutfits: outfits,
          errorMessage: null,
        ));
      },
      onError: (Object error, StackTrace stackTrace) {
        if (isClosed) return;

        emit(state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Unable to load outfits. Please try again.',
        ));

        unawaited(_cancelSubscription());
      },
    );
  }

  void selectCategory(String category) {
    if (isClosed) return;

    emit(state.copyWith(
      selectedCategory: category,
    ));
  }

  Future<void> retry(String gender) {
    return loadOutfits(gender);
  }

  Future<void> _cancelSubscription() async {
    await _styledSubscription?.cancel();
    _styledSubscription = null;
  }

  @override
  Future<void> close() async {
    await _cancelSubscription();
    return super.close();
  }
}