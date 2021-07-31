import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/src/home/bloc/product_bloc.dart';

class ProductPage extends StatelessWidget {
  final List<Product> products;

  const ProductPage({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: products.map((product) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: _ProductWidget(product),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(RemoveProduct(product));
                },
              ),
            ],
          );
        }).toList(),
      )),
    );
  }
}

class _ProductWidget extends StatefulWidget {
  final Product product;

  const _ProductWidget(this.product);
  @override
  __ProductWidgetState createState() => __ProductWidgetState();
}

class __ProductWidgetState extends State<_ProductWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf98xMX95QtWDHE8dlKmD60KipxRs_fnL2nXBsKTs3BLwMuzvkQxYyT7hLYKFXRHtfb3c&usqp=CAU",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10.0),
                          Text("Color: ${widget.product.color}"),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "\$ ${widget.product.price}",
                                style: TextStyle(
                                    color:
                                        widget.product.discountedPrice != null
                                            ? Colors.green
                                            : Colors.black,
                                    fontSize: 22.0),
                              ),
                              SizedBox(width: 5.0),
                              if (widget.product.discountedPrice != null)
                                Text(
                                  "\$ ${widget.product.discountedPrice}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red),
                                ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "View More",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    children: [
                                      Text("or"),
                                      Text(
                                        "Slide to Remove",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: isExpanded ? 80 : 0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: isExpanded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.description ??
                              " This is a sample description for two lines of this product"),
                          SizedBox(height: 5.0),
                          Text("Manufacture Date: ${widget.product.mdate}"),
                          SizedBox(height: 15.0),
                        ],
                      )
                    : SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
