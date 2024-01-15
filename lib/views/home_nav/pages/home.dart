import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_app_g3/core/design/app_image.dart';
import 'package:thimar_app_g3/features/categories/cubit.dart';
import 'package:thimar_app_g3/features/categories/states.dart';
import 'package:thimar_app_g3/features/slider/cubit.dart';
import 'package:thimar_app_g3/features/slider/states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final images = [
  //   "https://c8.alamy.com/comp/DCHK2D/composition-with-variety-of-fresh-organic-vegetables-isolated-on-white-DCHK2D.jpg",
  //   "https://c8.alamy.com/comp/FC168E/assorted-raw-organic-vegetables-isolated-on-white-FC168E.jpg"
  // ];
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<SliderCubit, SliderStates>(
            builder: (context, state) {
              if (state is GetSliderFailedState) {
                return Text("Failed");
              } else if (state is GetSliderSuccessState) {
                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 164,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          currentImage = index;
                          setState(() {});
                        },
                      ),
                      items: state.list.map((element) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(color: Colors.amber),
                                child: AppImage(
                                  element.image,
                                  fit: BoxFit.cover,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          state.list.length,
                          (index) => Padding(
                                padding: EdgeInsetsDirectional.only(end: 3),
                                child: CircleAvatar(radius: 3.5, backgroundColor: currentImage == index ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.38)),
                              )),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height: 16,),
          BlocBuilder<CategoriesCubit, CategoriesStates>(
            builder: (context, state) {
              if (state is GetCategoriesFailedState) {
                return Text("Failed");
              } else if (state is GetCategoriesSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsetsDirectional.only(start: 16),
                      child: Text("الأقسام"),
                    ),
                    SizedBox(
                      height: 103,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>  Padding(
                            padding:  EdgeInsetsDirectional.only(end: 16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: AppImage(
                                    state.list[index].image,
                                    width: 73,
                                  ),
                                ),
                                Text(state.list[index].name),
                              ],
                            ),
                          ),
                          itemCount: state.list.length),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

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
