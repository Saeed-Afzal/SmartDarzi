import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WishList extends StatefulWidget {
  WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Wish Lists"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
            child: Text(
              'Favourites',
              style: TextStyle(
                  color: HexColor("#0071bc"),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          WishListGroup(
            name: 'Lawn Ready',
            img: AssetImage('bear.png'),
          ),
          SizedBox(height: 15),
          WishListGroup(
            name: 'Wedding Cloth',
            img: AssetImage('penguin.png'),
          ),
        ]));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 200),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('header.jpg'),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Budget',
            style: TextStyle(
              color: HexColor("#0071bc"),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$ 1280 ',
                style: TextStyle(
                  color: HexColor("#0071bc"),
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ),
              Text(
                '\/ \$ 2000',
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WishListGroup extends StatefulWidget {
  final String name;
  final ImageProvider img;
  const WishListGroup({ this.name,  this.img});
  @override
  _WishListGroupState createState() => _WishListGroupState();
}

class _WishListGroupState extends State<WishListGroup> {
  bool vis = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                vis = !vis;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("#0071bc"),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '3 Items',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: widget.img),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: vis,
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Color(0xfff3faff),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: <Widget>[
                  WishListTile(
                    status: true,
                    name: 'Shalwar',
                    amount: 100,
                  ),
                  ListDivider(),
                  WishListTile(
                    status: true,
                    name: 'Kurta',
                    amount: 70,
                  ),
                  ListDivider(),
                  WishListTile(
                    status: true,
                    name: 'west coat',
                    amount: 10,
                  ),
                  // ListDivider(),
                  // WishListTile(
                  //   status: false,
                  //   name: 'Grandma',
                  //   amount: 0,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListDivider extends StatelessWidget {
  const ListDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.blueGrey.shade100,
    );
  }
}

class WishListTile extends StatelessWidget {
  final String name;
  final bool status;
  final int amount;
  const WishListTile(
      {this.name, this.status, this.amount});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          status ? Icons.check_circle_outline : Icons.highlight_off,
          color: status ? Colors.green.shade400 : Colors.red.shade300,
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(color: HexColor("#0071bc"), fontSize: 18),
        ),
        Spacer(),
        // Text(
        //   '\$$amount\/',
        //   style: TextStyle(color: HexColor("#0071bc"), fontSize: 18),
        // ),
        // Text(
        //   '\$100',
        //   style: TextStyle(color: Colors.red.shade300, fontSize: 18),
        // ),
      ],
    );
  }
}
