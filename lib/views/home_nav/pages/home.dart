import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thimar_app_g3/core/design/app_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final images = [
    "https://c8.alamy.com/comp/DCHK2D/composition-with-variety-of-fresh-organic-vegetables-isolated-on-white-DCHK2D.jpg",
    "https://c8.alamy.com/comp/FC168E/assorted-raw-organic-vegetables-isolated-on-white-FC168E.jpg"
  ];
  int currentImage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24,),
          CarouselSlider(
            options: CarouselOptions(height: 164,autoPlay: true,onPageChanged: (index, reason) {
              currentImage = index;
              setState(() {

              });
            },),
            items: images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: AppImage(i,fit: BoxFit.cover,));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(images.length, (index) => Padding(
              padding:  EdgeInsetsDirectional.only(end: 3),
              child: CircleAvatar(radius: 3.5,backgroundColor: currentImage==index?Theme.of(context).primaryColor:Theme.of(context).primaryColor.withOpacity(.38)),
            )),
          )
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            AppImage("assets/images/logo.svg"),
            SizedBox(
              width: 2,
            ),
            Text(
              "سلة ثمار",
              style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "التوصيل إلى",
                  style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  "شارع الملك فهد - جدة",
                  style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(
              flex: 3,
            ),
            AppImage("assets/icons/cart.svg")
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
