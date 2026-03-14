import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel_event.dart';
import 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(const HotelState()) {
    on<ToggleCardExpanded>(_onToggleCardExpanded);
    on<SwitchTab>(_onSwitchTab);
    on<UpdatePrice>(_onUpdatePrice);
    on<TriggerBookingAnimation>(_onTriggerBookingAnimation);
  }

  Future<void> _onToggleCardExpanded(
    ToggleCardExpanded event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(isCardExpanded: !state.isCardExpanded));
  }

  Future<void> _onSwitchTab(
    SwitchTab event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(activeTab: event.tab));
  }

  Future<void> _onUpdatePrice(
    UpdatePrice event,
    Emitter<HotelState> emit,
  ) async {
    final price = event.price.clamp(1, 10000);
    emit(state.copyWith(priceValue: price));
  }

  Future<void> _onTriggerBookingAnimation(
    TriggerBookingAnimation event,
    Emitter<HotelState> emit,
  ) async {
    emit(state.copyWith(isBookingAnimating: true));
    await Future.delayed(const Duration(milliseconds: 600));
    emit(state.copyWith(isBookingAnimating: false));
  }
}
