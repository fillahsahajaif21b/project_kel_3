import 'package:get/get.dart';
import 'package:project_kel_3/model/event.dart';

class CEvent extends GetxController {
  Rx<Event> _event = Event().obs;

  Event get event => _event.value;

  void setEvent(Event dataEvent) => _event.value = dataEvent;
}
