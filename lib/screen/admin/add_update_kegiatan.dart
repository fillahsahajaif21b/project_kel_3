import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_db.dart';
import 'package:project_kel_3/screen/admin/list_kegiatan.dart';
import 'package:project_kel_3/widget/info.dart';

import '../../model/kegiatan.dart';

class AddUpdateKegiatan extends StatefulWidget {
  final Kegiatan? kegiatan;
  AddUpdateKegiatan({this.kegiatan});

  @override
  State<AddUpdateKegiatan> createState() => _AddUpdateKegiatanState();
}

class _AddUpdateKegiatanState extends State<AddUpdateKegiatan> {
  var _formKey = GlobalKey<FormState>();
  var _controllerKodeKegiatan = TextEditingController();
  var _controllerNamaKegiatan = TextEditingController();
  var _controllerJenisKegiatan = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.kegiatan != null) {
      _controllerKodeKegiatan.text = widget.kegiatan!.kodeKegiatan!;
      _controllerNamaKegiatan.text = widget.kegiatan!.namaKegiatan!;
      _controllerJenisKegiatan.text = widget.kegiatan!.jenisKegiatan!;
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
        title: Text('List Kegiatan'),
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
                  controller: _controllerKodeKegiatan,
                  decoration: InputDecoration(
                      labelText: "Kode Kegiatan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNamaKegiatan,
                  decoration: InputDecoration(
                      labelText: "Nama Kegiatan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerJenisKegiatan,
                  decoration: InputDecoration(
                      labelText: "Jenis Kegiatan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.kegiatan == null) {
                        String message = await EventDb.addKegiatan(
                          _controllerKodeKegiatan.text,
                          _controllerNamaKegiatan.text,
                          _controllerJenisKegiatan.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerKodeKegiatan.clear();
                          _controllerNamaKegiatan.clear();
                          _controllerJenisKegiatan.clear();
                          Get.off(
                            ListKegiatan(),
                          );
                        }
                      } else {
                        EventDb.UpdateKegiatan(
                            _controllerKodeKegiatan.text,
                            _controllerNamaKegiatan.text,
                            _controllerJenisKegiatan.text);
                      }
                    }
                  },
                  child: Text(
                    widget.kegiatan == null ? 'Simpan' : 'Ubah',
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
