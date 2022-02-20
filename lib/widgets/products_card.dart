import 'package:flutter/material.dart';

class ProductsCard extends StatelessWidget {
  String name;
  String imageUrl;
  String price;
  ProductsCard(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.blueGrey)],
        ),
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon,
              Container(
                width: double.infinity,
                height: 75,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              Text('Rs: $price')
            ],
          ),
        ),
      ),
    );
  }
}
