import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_db.dart';
import 'package:project_kel_3/screen/admin/add_update_user.dart';

import '../../model/user.dart';

class ListUser extends StatefulWidget {
  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> _listUser = [];

  void getUser() async {
    _listUser = await EventDb.getUser();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void showOption(User? user) async {
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
        Get.to(AddUpdateUser(user: user))?.then((value) => getUser());
        break;
      case 'delete':
        EventDb.deleteUser(user!.idUser!).then((value) => getUser());
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
        title: Text('List User'),
        // backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listUser.length > 0
              ? ListView.builder(
                  itemCount: _listUser.length,
                  itemBuilder: (context, index) {
                    User user = _listUser[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.role ?? ''),
                      trailing: IconButton(
                          onPressed: () => showOption(user),
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
                  Get.to(AddUpdateUser())?.then((value) => getUser()),
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
