import 'package:get/get.dart';
import 'package:project_kel_3/model/kegiatan.dart';

class CKegiatan extends GetxController {
  Rx<Kegiatan> _kegiatan = Kegiatan().obs;

  Kegiatan get kegiatan => _kegiatan.value;

  void setKegiatan(Kegiatan dataKegiatan) => _kegiatan.value = dataKegiatan;
}
