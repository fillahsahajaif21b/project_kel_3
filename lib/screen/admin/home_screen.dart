import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel_3/config/asset.dart';
import 'package:project_kel_3/event/event_pref.dart';
import 'package:project_kel_3/screen/admin/list_panitia.dart';
import 'package:project_kel_3/screen/admin/list_event.dart';
import 'package:project_kel_3/screen/admin/list_kegiatan.dart';
import 'package:project_kel_3/screen/admin/list_user.dart';
import 'package:project_kel_3/screen/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Asset.colorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image(
                image: NetworkImage(
                    'https://ftik.teknokrat.ac.id/wp-content/uploads/2022/04/FTIK-web.png')),
          ),
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton('User', Icons.people, 0),
                    IconButton('Panitia', Icons.people, 1),
                    IconButton('Kegiatan', Icons.people, 2),
                    IconButton('Penjadwalan', Icons.list, 3),
                    IconButton('Logout', Icons.logout_outlined, 99),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Slider',
              style: TextStyle(
                  color: Asset.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            alignment: Alignment.topLeft,
          ),
          SizedBox(
            height: 140,
            child: ListView(
              children: [
                CarouselSlider(
                  items: [
                    SlideItem(
                        'https://teknokrat.ac.id/wp-content/uploads/2023/06/4.jpeg'),
                    SlideItem(
                        'https://teknokrat.ac.id/wp-content/uploads/2022/01/WhatsApp-Image-2022-01-26-at-20.18.17.jpeg'),
                    SlideItem(
                        'https://teknokrat.ac.id/wp-content/uploads/2022/01/WhatsApp-Image-2022-01-26-at-20.20.04-1024x768.jpeg'),
                    SlideItem(
                        'https://teknokrat.ac.id/wp-content/uploads/2022/01/WhatsApp-Image-2022-01-26-at-20.18.17-1-1024x768.jpeg'),
                  ],
                  options: CarouselOptions(
                    height: 140.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final String img;

  SlideItem(this.img);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Image(
          image: NetworkImage(
            img,
          ),
          fit: BoxFit.cover),
    );
  }
}

class IconButton extends StatelessWidget {
  final String nameLabel;
  final IconData iconLabel;
  final int index;

  IconButton(this.nameLabel, this.iconLabel, this.index);

  List<Map> _fragment = [
    {'title': 'Daftar User', 'view': ListUser()},
    {'title': 'Daftar Panitia', 'view': ListPanitia()},
    {'title': 'Daftar Kegiatan', 'view': ListKegiatan()},
    {'title': 'Daftar Event', 'view': ListEvent()},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(bottom: 5),
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                onTap: () {
                  if (index == 99) {
                    EventPref.clear();
                    Get.off(Login());
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _fragment[index]['view']),
                    );
                  }
                },
                child: Container(
                  // margin: EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Asset.colorPrimaryDark,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Icon(
                          iconLabel,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              nameLabel,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
