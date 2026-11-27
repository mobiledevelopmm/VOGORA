
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/outfit_item_model.dart';

part 'home_state.freezed.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
@Freezed(makeCollectionsUnmodifiable: false)
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial)
    HomeStatus status,

    @Default([])
    List<OutfitItem> styledOutfits,

    // Will be populated from local assets later.
    @Default([])
    List<OutfitItem> trendingOutfits,

    @Default('Casual')
    String selectedCategory,

    String? errorMessage,
  }) = _HomeState;
}