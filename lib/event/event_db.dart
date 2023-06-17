import 'dart:convert';
import 'package:get/get.dart';
import 'package:project_kel_3/config/api.dart';
import 'package:project_kel_3/event/event_pref.dart';
import 'package:project_kel_3/model/panitia.dart';
import 'package:project_kel_3/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:project_kel_3/screen/admin/add_update_user.dart';
import 'package:project_kel_3/screen/admin/add_update_panitia.dart';
import 'package:project_kel_3/screen/admin/add_update_event.dart';
import 'package:project_kel_3/screen/login.dart';
import 'package:project_kel_3/widget/info.dart';

import '../model/kegiatan.dart';
import '../model/event.dart';

class EventDb {
  static Future<User?> login(String username, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'username': username,
        'pass': pass,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);

        if (responBody['success']) {
          user = User.fromJson(responBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700), () {
            Get.off(
              Login(),
            );
          });
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<List<User>> getUser() async {
    List<User> listUser = [];

    try {
      var response = await http.get(Uri.parse(Api.getUser));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var users = responBody['user'];

          users.forEach((user) {
            listUser.add(User.fromJson(user));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listUser;
  }

  static Future<String> addUser(
      String name, String username, String pass, String role) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addUser), body: {
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add User Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateUser(
    String id,
    String name,
    String username,
    String pass,
    String role,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updateUser), body: {
        'id': id,
        'name': name,
        'username': username,
        'pass': pass,
        'role': role
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update User');
        } else {
          Info.snackbar('Gagal Update User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteUser(String id) async {
    try {
      var response =
          await http.post(Uri.parse(Api.deleteUser), body: {'id': id});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete User');
        } else {
          Info.snackbar('Gagal Delete User');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //Bagian Panitia
  static Future<List<Panitia>> getPanitia() async {
    List<Panitia> listPanitia = [];

    try {
      var response = await http.get(Uri.parse(Api.getPanitia));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var panitia = responBody['panitia'];

          panitia.forEach((panitia) {
            listPanitia.add(Panitia.fromJson(panitia));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listPanitia;
  }

  static Future<String> addPanitia(String no_iden, String nama_panitia,
      String jenis_kelamin, String role_panitia) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addPanitia), body: {
        'no_iden': no_iden,
        'nama_panitia': nama_panitia,
        'jenis_kelamin': jenis_kelamin,
        'role_panitia': role_panitia
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Panitia Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdatePanitia(
    String id_panitia,
    String no_iden,
    String nama_panitia,
    String jenis_kelamin,
    String role_panitia,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updatePanitia), body: {
        'id_panitia': id_panitia,
        'no_iden': no_iden,
        'nama_panitia': nama_panitia,
        'jenis_kelamin': jenis_kelamin,
        'role_panitia': role_panitia
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Panitia');
        } else {
          Info.snackbar('Gagal Update Panitia');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deletePanitia(String id_panitia) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deletePanitia), body: {'id_panitia': id_panitia});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Panitia');
        } else {
          Info.snackbar('Gagal Delete Panitia');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //bagian kegiatan

  static Future<List<Kegiatan>> getKegiatan() async {
    List<Kegiatan> listKegiatan = [];

    try {
      var response = await http.get(Uri.parse(Api.getKegiatan));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var kegiatan = responBody['kegiatan'];

          kegiatan.forEach((kegiatan) {
            listKegiatan.add(Kegiatan.fromJson(kegiatan));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listKegiatan;
  }

  static Future<String> addKegiatan(
      String kode_kegiatan, String nama_kegiatan, String jenis_kegiatan) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addKegiatan), body: {
        'kode_kegiatan': kode_kegiatan,
        'nama_kegiatan': nama_kegiatan,
        'jenis_kegiatan': jenis_kegiatan
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Kegiatan Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateKegiatan(
    String kode_kegiatan,
    String nama_kegiatan,
    String jenis_kegiatan,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updateKegiatan), body: {
        'id_kegiatan': kode_kegiatan,
        'nama_kegiatan': nama_kegiatan,
        'jenis_kegiatan': jenis_kegiatan,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Kegiatan');
        } else {
          Info.snackbar('Gagal Update Kegiatan');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteKegiatan(String kode_kegiatan) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteKegiatan),
          body: {'kode_kegiatan': kode_kegiatan});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Kegiatan');
        } else {
          Info.snackbar('Gagal Delete Kegiatan');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //bagian Event

  static Future<List<Event>> getEvent() async {
    List<Event> listEvent = [];

    try {
      var response = await http.get(Uri.parse(Api.getEvent));

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var event = responBody['event'];

          event.forEach((event) {
            listEvent.add(Event.fromJson(event));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listEvent;
  }

  static Future<String> addEvent(String kode_event, String nama_event,
      String deskripsi_event, String tanggal) async {
    String reason;

    try {
      var response = await http.post(Uri.parse(Api.addEvent), body: {
        'kode_event': kode_event,
        'nama_event': nama_event,
        'deskripsi_event': deskripsi_event,
        'tanggal': tanggal
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Event Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }

  static Future<void> UpdateEvent(
    String kode_event,
    String nama_event,
    String deskripsi_event,
    String tanggal,
  ) async {
    try {
      var response = await http.post(Uri.parse(Api.updateEvent), body: {
        'kode_event': kode_event,
        'nama_event': nama_event,
        'deskripsi_event': deskripsi_event,
        'tanggal': tanggal
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Event');
        } else {
          Info.snackbar('Gagal Update Event');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteEvent(String kode_event) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deleteEvent), body: {'kode_event': kode_event});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Event');
        } else {
          Info.snackbar('Gagal Delete Event');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
