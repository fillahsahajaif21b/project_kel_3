class Api {
  static const _host = "http://192.168.185.227/api_kel_3";

  static String _user = "$_host/user";
  static String _kegiatan = "$_host/kegiatan";
  static String _panitia = "$_host/panitia";
  static String _event = "$_host/event";

  static String login = "$_host/login.php";

  // user
  static String addUser = "$_user/add_user.php";
  static String deleteUser = "$_user/delete_user.php";
  static String getUser = "$_user/get_user.php";
  static String updateUser = "$_user/update_user.php";

  // kegiatan
  static String addKegiatan = "$_kegiatan/add_kegiatan.php";
  static String deleteKegiatan = "$_kegiatan/delete_kegiatan.php";
  static String getKegiatan = "$_kegiatan/get_kegiatan.php";
  static String updateKegiatan = "$_kegiatan/update_kegiatan.php";

  // panitia
  static String addPanitia = "$_panitia/add_panitia.php";
  static String deletePanitia = "$_panitia/delete_panitia.php";
  static String getPanitia = "$_panitia/get_panitia.php";
  static String updatePanitia = "$_panitia/update_panitia.php";

  // event
  static String addEvent = "$_event/add_event.php";
  static String deleteEvent = "$_event/delete_event.php";
  static String getEvent = "$_event/get_event.php";
  static String updateEvent = "$_event/update_event.php";
}
