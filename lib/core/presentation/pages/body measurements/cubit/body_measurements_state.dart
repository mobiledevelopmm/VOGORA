import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_measurements_state.freezed.dart';

enum BodyMeasurementsStatus { initial, saving, success, failure }

@freezed
abstract class BodyMeasurementsState with _$BodyMeasurementsState {
  const factory BodyMeasurementsState({
    @Default(BodyMeasurementsStatus.initial) BodyMeasurementsStatus status,
    String? bodyShape,
    String? errorMessage,
  }) = _BodyMeasurementsState;
}
