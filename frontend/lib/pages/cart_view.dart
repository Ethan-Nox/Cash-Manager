import 'package:flutter/material.dart';
import 'package:frontend/pages/pay_view.dart';
import 'package:frontend/widgets/scan/scan.dart';
import 'package:frontend/providers/cart_provider.dart';
import 'package:frontend/widgets/list_panier.dart';
import 'package:provider/provider.dart';

import '../models/articleModel.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
  }
  // final List items = [
  //   {
  //     "price": 100.0,
  //     "name": "Air force 1",
  //     "description": "Basket",
  //     "category": "Chaussure",
  //     "image":
  //         "https://www.courir.com/on/demandware.static/-/Sites-master-catalog-courir/default/dw2bc08c65/images/hi-res/001498199_101.png",
  //     "stock": 100,
  //     "id": 2
  //   },
  //   {
  //     "price": 350.0,
  //     "name": "Iphone 11",
  //     "description": "telephone apple",
  //     "category": "Apple",
  //     "image":
  //         "https://boostit.cdiscount.com/wp-content/uploads/2020/05/iPhone11_Visuel1-DM-1.png",
  //     "stock": 50,
  //     "id": 1
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    List item = Provider.of<CartProvider>(context).getItems();
    var i = 0;
    int total = Provider.of<CartProvider>(context).getTotal();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).items.add(
                Article_Model(
                    name: "_name",
                    price: 100,
                    image: "gto.jpg",
                    category: "Chaussure",
                    stock: 100,
                    description: 'test',
                    id: i));
            i += 1;
            setState(() {
              total =
                  Provider.of<CartProvider>(context, listen: false).getTotal();
            });
          },
          child: Text("Scan"),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return List_Panier(
                      id: item[index].id,
                      name: item[index].name,
                      price: item[index].price,
                      image: item[index].image,
                      description: item[index].description,
                      category: item[index].category,
                      stock: item[index].stock,
                    );
                  },
                )),
            SizedBox(
              width: 100,
              child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => payView(total: total),
                          ));
                    },
                    child: Text("Payer")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
