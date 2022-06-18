import 'package:flutter/material.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/simple_app_bar.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/order_model.dart';
import 'package:shop_app/services/order_service.dart';
import "package:collection/collection.dart";

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSimpleAppBar(context, "Order History", searchbar: false),
      body: FutureBuilder(
        future: OrderService().getOrderHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          }
          Map formattedSnapshot = groupBy(snapshot.data, (obj) => obj.date);
          var formattedSnapshotList = formattedSnapshot.keys.toList();

          return snapshot.data.length > 0
              ? ListView.builder(
                  itemCount: formattedSnapshotList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.black12,
                            child: Center(
                                child:
                                    Text("${formattedSnapshotList[index]}"))),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children:
                              formattedSnapshot[formattedSnapshotList[index]]
                                  .map<Widget>(
                                    (order) => ListTile(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return bottomSheetOrderView(
                                                  order, context);
                                            });
                                      },
                                      isThreeLine: true,
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("#${order.id}"),
                                          Text(
                                              "${order.products.map((e) => e.product.name).toList().join(',').substring(0, 16)}..."),
                                        ],
                                      ),
                                      subtitle: Text("\$${order.total_amount}"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 6,
                                            width: 6,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.lightGreen),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(order.status
                                              .toString()
                                              .toUpperCase()),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                        )
                      ],
                    );
                    return ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("# ${snapshot.data[index]['id']}"),
                            Text(
                                "${snapshot.data[index]['product'].map((e) => e['name']).toList().join(',').substring(0, 16)}...")
                          ],
                        ),
                        trailing: Text(
                            "${snapshot.data[index]['order_product'][0]['order_status']}"));
                  },
                )
              : const Center(child: const Text("No records found"));
        },
      ),
    );
  }

  bottomSheetOrderView(OrderModel order, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Order ID: ${order.id}', style: headingStyle),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: order.products
                  .map<Widget>((prod) => ListTile(
                        leading: Text("${prod.quantity}x"),
                        title: Text(prod.product.name),
                      ))
                  .toList(),
            ),
             ListTile(
              leading: const Text("Total : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              trailing: Text("\$${order.total_amount} ",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
