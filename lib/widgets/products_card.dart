import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/Screens/constant.dart';

class ProductsCard extends StatelessWidget {
  String name;
  String imageUrl;
  String price;
  Function press;
  ProductsCard(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.price,
      @required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "Cabbage",
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
  ),
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "Fruits",
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "\Rs",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                    children: [
                      TextSpan(
                        text: price,
                        style: TextStyle(color: Colors.black),
                      ),
                      // TextSpan(
                      //   text: "/kg",
                      //   style: TextStyle(
                      //       color: Colors.black26,
                      //       fontWeight: FontWeight.normal),
                      // )
                    ],
                  ),
                ),
                //FavBtn(),
              ],
            )
          ]))

);}}
