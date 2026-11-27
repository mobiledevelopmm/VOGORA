import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wardrobe_state.dart';
part 'wardrobe_cubit.freezed.dart';

class WardrobeCubit extends Cubit<WardrobeState> {
  WardrobeCubit() : super(const WardrobeState.initial());
}
