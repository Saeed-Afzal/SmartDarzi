import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/cardCategory.dart';
import 'package:flutter_ecommerce_app/cardPage.dart';
import 'package:flutter_ecommerce_app/colors.dart';
import 'package:flutter_ecommerce_app/config/size_config.dart';
import 'package:flutter_ecommerce_app/constant.dart';
import 'package:flutter_ecommerce_app/orders/create_order.dart';
import 'package:flutter_ecommerce_app/productDetail.dart';
import 'package:flutter_ecommerce_app/style.dart';
import 'package:flutter_ecommerce_app/widgets/Slider.dart';
import 'package:flutter_ecommerce_app/widgets/navigation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategory = 0;
  List selectedCategoryList = shirts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: false,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 10),
      //     child: RawMaterialButton(
      //       elevation: 2,
      //       onPressed: () {},
      //       constraints: BoxConstraints(
      //         minWidth: 10,
      //       ),
      //       child: SvgPicture.asset('assets/menu.svg',
      //           width: 20, color: AppColors.black),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       fillColor: AppColors.white,
      //       padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      //     ),
      //   ),
      // ),
      body: ListView(
        children: [
          //Promo
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Column(
              children: [
                Text(
                  "Get Rs.100 off your first order!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.4,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Use Promo code: WELCOME100",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.4,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          //Promo

          SizedBox(height: SizeConfig.blockSizeVertical * 4),

          //animated text
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your Clothes Our Priority!',
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 10,
              pause: const Duration(milliseconds: 150),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
          //animated text

          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          CarouselWithDotsPage(imgList: imgList),
          // Padding(
          //   padding: standardPaddingX,
          //   child: PrimaryText(
          //       text: 'Discover your best furniture',
          //       fontWeight: FontWeight.w700,
          //       size: 36),
          // ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),

          Padding(
            padding: standardPaddingX,
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[300]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200]),
                  ),
                  contentPadding: EdgeInsets.all(15),
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGray,
                      fontSize: 18),
                  prefixIcon:
                      Icon(Icons.search, size: 30, color: AppColors.black)),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3),

          //cards
          CardCategory(),
          //cards
          SizedBox(height: SizeConfig.blockSizeVertical * 3),

          //create Order

          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sideImage.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              ),
              borderRadius:
                  BorderRadius.circular(15), // Set rounded corner radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  "Easy TO Order",
                  style: TextStyle(
                      color: HexColor("#0071bc").withOpacity(0.8),
                      fontSize: 28.0,
                      height: 1.4,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    child: Text("Create Order".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#0071bc")),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: HexColor("#0071bc"))))),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CreateOrder()));
                    })
              ],
            ),
          ),

          //create Order

          //Track Order
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  icon: Icon(Icons.star_outline),
                  label: Text("Recreate Order"),
                  onPressed: () => print("it's pressed"),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: HexColor("#0071bc")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  icon: Icon(Icons.map_rounded),
                  label: Text("Track Order"),
                  onPressed: () => print("it's pressed"),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: HexColor("#0071bc")),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                )
              ],
            ),
          )
//Track Order

          // SizedBox(
          //   height: SizeConfig.blockSizeVertical * 7.5,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: categories.length,
          //     itemBuilder: (context, index) => Container(
          //       padding: EdgeInsets.only(
          //         left: index == 0 ? 25 : 0,
          //         right: 20,
          //       ),
          //       margin: EdgeInsets.only(top: 10, bottom: 10),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           setState(() {
          //             selectedCategory = index;
          //             selectedCategoryList =
          //                 categories[index]['arrayMappedname'];
          //           });
          //         },

          //         child: PrimaryText(
          //           text: categories[index]['label'],
          //           color: selectedCategory == index
          //               ? AppColors.white
          //               : AppColors.textGray,
          //           fontWeight: FontWeight.w500,
          //           size: 18,
          //         ),

          //         style: ElevatedButton.styleFrom(
          //           padding: EdgeInsets.symmetric(horizontal: 25),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //           elevation: 0,
          //           primary: selectedCategory == index
          //               ? AppColors.primaryblue
          //               : Colors.grey[200],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

//For Cart Card
          // SizedBox(
          //   height: SizeConfig.blockSizeVertical * 2,
          // ),
          // Padding(
          //   padding: standardPaddingX,
          //   child: Row(
          //     children: [
          //       PrimaryText(
          //           text: 'Popular', fontWeight: FontWeight.w800, size: 28),
          //       Spacer(),
          //       PrimaryText(
          //           text: 'View all',
          //           color: AppColors.primaryblue,
          //           fontWeight: FontWeight.w800,
          //           size: 20)
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: SizeConfig.blockSizeVertical * 4,
          // ),

          // new Card
          // Center(
          //     child: Container(
          //         height: MediaQuery.of(context).size.height - 30,
          //         width: double.infinity,
          //         child: CardPage()),
          //   ),

//For Cart Card

          // Expanded(
          //   child: Padding(
          //     padding: standardPaddingX,
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: List.generate(
          //             selectedCategoryList.length,
          //             (index) => productCard(
          //                 context,
          //                 selectedCategoryList[index]["image"],
          //                 selectedCategoryList[index]["label"],
          //                 selectedCategoryList[index]["price"]))),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget productCard(
  //     BuildContext context, String image, String label, String price) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => ProductDetail(image)));
  //     },
  //     child: Hero(
  //       tag: image,
  //             child: Container(
  //         padding: EdgeInsets.all(10),
  //         // width: (SizeConfig.screenWidth - 80) / 2,
  //         width:MediaQuery.of(context).size.width * 0.4 ,
  //         height: SizeConfig.blockSizeVertical * 30,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage(image),
  //             fit: BoxFit.cover,
  //           ),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Stack(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(10),
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: AppColors.white,
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       PrimaryText(
  //                           text: label, color: AppColors.textGray, size: 16),
  //                       SizedBox(height: 5),
  //                       PrimaryText(
  //                           text: price, size: 18, fontWeight: FontWeight.w700),
  //                       SizedBox(height: 5),
  //                     ],
  //                   ),
  //                 ),
  //                 Positioned(
  //                   right: 10,
  //                   bottom: 0,
  //                   child: RawMaterialButton(
  //                       onPressed: () {},
  //                       elevation: 0,
  //                       constraints: BoxConstraints(
  //                         minWidth: 0,
  //                       ),
  //                       shape: CircleBorder(),
  //                       fillColor: AppColors.primaryblue,
  //                       padding: EdgeInsets.all(5),
  //                       child: Icon(Icons.add, size: 16, color: AppColors.white)),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
