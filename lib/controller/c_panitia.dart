import 'package:get/get.dart';
import 'package:project_kel_3/model/panitia.dart';

class CPanitia extends GetxController {
  Rx<Panitia> _panitia = Panitia().obs;

  Panitia get panitia => _panitia.value;

  void setPanitia(Panitia dataPanitia) => _panitia.value = dataPanitia;
}
