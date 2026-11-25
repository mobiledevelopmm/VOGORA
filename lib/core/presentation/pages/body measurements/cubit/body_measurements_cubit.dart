import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/style_profile_service.dart';
import 'body_measurements_state.dart';

class BodyMeasurementsCubit extends Cubit<BodyMeasurementsState> {
  final StyleProfileService _styleProfileService;

  BodyMeasurementsCubit(this._styleProfileService)
    : super(const BodyMeasurementsState());

  Future<bool> calculateAndSave({
    required double height,
    required double weight,
    required double shoulder,
    required double bust,
    required double waist,
    required double hip,
    required String unit,
  }) async {
    if (bust <= 0 || waist <= 0 || hip <= 0) {
      emit(
        state.copyWith(
          status: BodyMeasurementsStatus.failure,
          errorMessage: 'Please enter valid body measurements.',
        ),
      );
      return false;
    }

    emit(
      state.copyWith(status: BodyMeasurementsStatus.saving, errorMessage: null),
    );

    try {
      // Convert to cm only for body shape calculation.
      final bustCm = unit == 'in' ? bust * 2.54 : bust;
      final waistCm = unit == 'in' ? waist * 2.54 : waist;
      final hipCm = unit == 'in' ? hip * 2.54 : hip;

      final bodyShape = _calculateBodyShape(
        bust: bustCm,
        waist: waistCm,
        hip: hipCm,
      );

      // Save original measurement values and selected unit.
      await _styleProfileService.saveBodyMeasurements(
        height: height,
        weight: weight,
        shoulder: shoulder,
        bust: bust,
        waist: waist,
        hip: hip,
        unit: unit,
        bodyShape: bodyShape,
      );

      emit(
        state.copyWith(
          status: BodyMeasurementsStatus.success,
          bodyShape: bodyShape,
          errorMessage: null,
        ),
      );

      return true;
    } catch (error) {
      emit(
        state.copyWith(
          status: BodyMeasurementsStatus.failure,
          errorMessage: 'Unable to save your measurements. Please try again.',
        ),
      );

      return false;
    }
  }

  String _calculateBodyShape({
    required double bust,
    required double waist,
    required double hip,
  }) {
    final upperLowerDifference = (bust - hip).abs() / ((bust + hip) / 2);

    final upperLowerBalanced = upperLowerDifference <= 0.05;

    final definedWaist = waist <= bust * 0.75 && waist <= hip * 0.75;

    final prominentWaist = waist >= bust * 0.90 && waist >= hip * 0.90;

    if (prominentWaist) {
      return 'Apple';
    }

    if (upperLowerBalanced && definedWaist) {
      return 'Hourglass';
    }

    if (upperLowerBalanced) {
      return 'Rectangle';
    }

    if (hip > bust * 1.05) {
      return 'Pear';
    }

    if (bust > hip * 1.05) {
      return 'Inverted Triangle';
    }

    return 'Rectangle';
  }
}
