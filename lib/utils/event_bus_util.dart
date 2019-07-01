import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class CommonEvent {
  bool isUpdateKeys;
  bool isUpdateFavorite;
  CommonEvent({this.isUpdateFavorite,this.isUpdateKeys});
}