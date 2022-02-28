import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/order_history_cancelled.dart';
import 'package:flutter_ecommerce_app/order_history_completed.dart';
import 'package:flutter_ecommerce_app/order_history_pending.dart';

class orderHistory extends StatelessWidget {
  // const orderHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Order History'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Pending',
                  icon: Icon(Icons.reorder_outlined),
                ),
                Tab(
                  text: 'Completed',
                  icon: Icon(Icons.checklist_outlined),
                ),
                Tab(
                  text: 'Cancelled',
                  icon: Icon(Icons.change_circle_outlined),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OrderHistoryPending(),
              OrderHistoryCompleted(),
              OrderHistoryCancelled()
            ],
          ),
        ),
      );
}
