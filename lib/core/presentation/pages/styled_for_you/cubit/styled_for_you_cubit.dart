import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'styled_for_you_state.dart';
part 'styled_for_you_cubit.freezed.dart';

class StyledForYouCubit extends Cubit<StyledForYouState> {
  StyledForYouCubit() : super(const StyledForYouState.initial());
}
