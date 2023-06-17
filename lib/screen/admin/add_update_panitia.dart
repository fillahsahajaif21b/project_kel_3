import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_db.dart';
import 'package:project_kel_3/screen/admin/list_panitia.dart';
import 'package:project_kel_3/widget/info.dart';

import '../../model/panitia.dart';

class AddUpdatePanitia extends StatefulWidget {
  final Panitia? panitia;
  AddUpdatePanitia({this.panitia});

  @override
  State<AddUpdatePanitia> createState() => _AddUpdatePanitiaState();
}

class _AddUpdatePanitiaState extends State<AddUpdatePanitia> {
  var _formKey = GlobalKey<FormState>();
  var _controllerIdPanitia = TextEditingController();
  //var _controllerKodeEvent = TextEditingController();
  var _controllerNoIden = TextEditingController();
  var _controllerNamaPanitia = TextEditingController();
  var _controllerJenisKelamin = TextEditingController();

  List<String> role_panitia = [
    "Dosen",
    "Mahasiswa",
    "Karyawan",
  ];

  String _role_panitia = "Dosen";

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.panitia != null) {
      _controllerIdPanitia.text = widget.panitia!.idPanitia!;
      _controllerNoIden.text = widget.panitia!.noIden!;
      _controllerNamaPanitia.text = widget.panitia!.namaPanitia!;
      _controllerJenisKelamin.text = widget.panitia!.jenisKelamin!;
      _role_panitia = widget.panitia!.rolePanitia!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GradientAppBar(
        gradient: LinearGradient(
            colors: [Asset.colorPrimaryDark, Asset.colorPrimary]),
        // titleSpacing: 0,
        title: Text('List User'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNamaPanitia,
                  decoration: InputDecoration(
                      labelText: "Nama Panitia",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNoIden,
                  decoration: InputDecoration(
                      labelText: "No. Identitas (NIK/NPM)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerJenisKelamin,
                  decoration: InputDecoration(
                      labelText: "Jenis Kelamin (L/P)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: _role_panitia,
                  decoration: InputDecoration(
                      labelText: "Role Panitia",
                      hintText: "Role Panitia",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  items: role_panitia.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _role_panitia = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.panitia == null) {
                        String message = await EventDb.addUser(
                          _controllerNamaPanitia.text,
                          _controllerNoIden.text,
                          _controllerJenisKelamin.text,
                          _role_panitia,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerNamaPanitia.clear();
                          _controllerNoIden.clear();
                          _controllerJenisKelamin.clear();
                          Get.off(
                            ListPanitia(),
                          );
                        }
                      } else {
                        EventDb.UpdateUser(
                            _controllerIdPanitia.text,
                            _controllerNamaPanitia.text,
                            _controllerNoIden.text,
                            _controllerJenisKelamin.text,
                            _role_panitia);
                      }
                    }
                  },
                  child: Text(
                    widget.panitia == null ? 'Simpan' : 'Ubah',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Asset.colorAccent,
                      fixedSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
