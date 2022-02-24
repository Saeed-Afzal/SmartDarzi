// import 'package:flutter/material.dart';

// class TShirts extends StatefulWidget {
//   String gender;
//   TShirts({Key key, @required this.gender}) : super(key: key);

//   @override
//   State<TShirts> createState() => _TShirtsState();
// }

// class _TShirtsState extends State<TShirts> {
//   String itemType = 'T-Shirts';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('T-Shirts'),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/firebase_data/data_firebase.dart';
import 'package:flutter_ecommerce_app/orders/productpage.dart';
import 'package:flutter_ecommerce_app/widgets/products_card.dart';

class TShirts extends StatefulWidget {
  String gender;
  TShirts({Key key, @required this.gender}) : super(key: key);

  @override
  State<TShirts> createState() => _TShirtsState();
}

class _TShirtsState extends State<TShirts> {
  String itemType = 'tshirt';
  List _productsData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    DatabaseManager data =
        DatabaseManager(gender: widget.gender, itemType: itemType);
    try {
      _productsData = await data.getProductsData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _productsData == null
                ? Center(child: Text('No product to show'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: _productsData.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProductPage(
                                    productData: _productsData,
                                    index: index,
                                  )));
                        },
                        child: ProductsCard(
                            name: _productsData[index]['name'],
                            imageUrl: _productsData[index]['image'][0],
                            price: _productsData[index]['price']),
                      );
                    }));
  }
}
