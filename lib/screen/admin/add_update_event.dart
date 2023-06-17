import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_db.dart';
import 'package:project_kel_3/screen/admin/list_event.dart';
import 'package:project_kel_3/widget/info.dart';

import '../../model/event.dart';

class AddUpdateEvent extends StatefulWidget {
  final Event? event;
  AddUpdateEvent({this.event});

  @override
  State<AddUpdateEvent> createState() => _AddUpdateEventState();
}

class _AddUpdateEventState extends State<AddUpdateEvent> {
  var _formKey = GlobalKey<FormState>();
  var _controllerKodeEvent = TextEditingController();
  var _controllerNamaEvent = TextEditingController();
  var _controllerDeskripsiEvent = TextEditingController();
  var _controllerTanggal = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.event != null) {
      _controllerKodeEvent.text = widget.event!.kodeEvent!;
      _controllerNamaEvent.text = widget.event!.namaEvent!;
      _controllerDeskripsiEvent.text = widget.event!.deskripsiEvent!;
      _controllerTanggal.text = widget.event!.tanggal!;
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
        title: Text('List Event'),
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
                  controller: _controllerKodeEvent,
                  decoration: InputDecoration(
                      labelText: "Kode Event",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNamaEvent,
                  decoration: InputDecoration(
                      labelText: "Nama Event",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerDeskripsiEvent,
                  decoration: InputDecoration(
                      labelText: "Deskripsi",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerDeskripsiEvent,
                  decoration: InputDecoration(
                      labelText: "Tanggal",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.event == null) {
                        String message = await EventDb.addEvent(
                          _controllerKodeEvent.text,
                          _controllerNamaEvent.text,
                          _controllerDeskripsiEvent.text,
                          _controllerTanggal.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerKodeEvent.clear();
                          _controllerNamaEvent.clear();
                          _controllerDeskripsiEvent.clear();
                          _controllerTanggal.clear();
                          Get.off(
                            ListEvent(),
                          );
                        }
                      } else {
                        EventDb.UpdateEvent(
                            _controllerKodeEvent.text,
                            _controllerNamaEvent.text,
                            _controllerDeskripsiEvent.text,
                            _controllerTanggal.text);
                      }
                    }
                  },
                  child: Text(
                    widget.event == null ? 'Simpan' : 'Ubah',
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
