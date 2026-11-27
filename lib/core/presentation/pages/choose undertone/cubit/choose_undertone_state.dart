
import 'package:freezed_annotation/freezed_annotation.dart';

part 'choose_undertone_state.freezed.dart';

enum ChooseUndertoneStatus {
  initial,
  saving,
  success,
  failure,
}

@freezed
abstract class ChooseUndertoneState with _$ChooseUndertoneState {
  const factory ChooseUndertoneState({
    @Default(ChooseUndertoneStatus.initial)
    ChooseUndertoneStatus status,

    String? selectedUndertone,

    String? errorMessage,
  }) = _ChooseUndertoneState;
}