import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class ToggleCardExpanded extends HotelEvent {
  const ToggleCardExpanded();
}

class SwitchTab extends HotelEvent {
  final String tab;
  const SwitchTab(this.tab);

  @override
  List<Object> get props => [tab];
}

class UpdatePrice extends HotelEvent {
  final int price;
  const UpdatePrice(this.price);

  @override
  List<Object> get props => [price];
}

class TriggerBookingAnimation extends HotelEvent {
  const TriggerBookingAnimation();
}
