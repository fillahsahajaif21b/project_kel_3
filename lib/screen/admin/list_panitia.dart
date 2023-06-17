import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_db.dart';
import 'package:project_kel_3/screen/admin/add_update_panitia.dart';

import '../../model/panitia.dart';

class ListPanitia extends StatefulWidget {
  @override
  State<ListPanitia> createState() => _ListPanitiaState();
}

class _ListPanitiaState extends State<ListPanitia> {
  List<Panitia> _listPanitia = [];

  void getPanitia() async {
    _listPanitia = await EventDb.getPanitia();

    setState(() {});
  }

  @override
  void initState() {
    getPanitia();
    super.initState();
  }

  void showOption(Panitia? panitia) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'update':
        Get.to(AddUpdatePanitia(panitia: panitia))
            ?.then((value) => getPanitia());
        break;
      case 'delete':
        EventDb.deletePanitia(panitia!.idPanitia!)
            .then((value) => getPanitia());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(
            colors: [Asset.colorPrimaryDark, Asset.colorPrimary]),
        // titleSpacing: 0,
        title: Text('List Panitia'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listPanitia.length > 0
              ? ListView.builder(
                  itemCount: _listPanitia.length,
                  itemBuilder: (context, index) {
                    Panitia panitia = _listPanitia[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(panitia.namaPanitia ?? ''),
                      subtitle: Text(panitia.noIden ?? ''),
                      trailing: IconButton(
                          onPressed: () => showOption(panitia),
                          icon: Icon(Icons.more_vert)),
                    );
                  },
                )
              : Center(
                  child: Text("Data Kosong"),
                ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () =>
                  Get.to(AddUpdatePanitia())?.then((value) => getPanitia()),
              child: Icon(Icons.add),
              backgroundColor: Asset.colorAccent,
            ),
          )
        ],
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const _defaultHeight = 56.0;

  final double elevation;
  final Gradient gradient;
  final Widget title;
  final double barHeight;

  GradientAppBar(
      {this.elevation = 3.0,
      required this.gradient,
      required this.title,
      this.barHeight = _defaultHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          offset: Offset(0, elevation),
          color: Colors.black.withOpacity(0.3),
          blurRadius: 3,
        ),
      ]),
      child: AppBar(
        title: title,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
