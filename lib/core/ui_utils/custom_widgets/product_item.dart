import 'package:LaCoro/core/appearance/app_text_style.dart';
import 'package:LaCoro/core/ui_utils/model/item_ui.dart';
import 'package:flutter/material.dart';

import 'custom_counter.dart';

class ProductItem extends StatefulWidget {
  final ItemUI itemUI;
  final Function(int) onQuantityChange;
  final int quantity;
  final bool divider;

  ProductItem({Key key, @required this.itemUI, this.onQuantityChange, this.quantity, this.divider});

  @override
  _ProductItemState createState() => _ProductItemState(onQuantityChange, quantity ?? 0, divider ?? false);
}

class _ProductItemState extends State<ProductItem> {
  final bool divider;

  int quantity;
  bool counterVisible = false;

  final Function(int) onQuantityChange;

  _ProductItemState(this.onQuantityChange, this.quantity, this.divider);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => counterVisible = !counterVisible),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.67,
                    padding: EdgeInsets.only(right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.itemUI.name.trim() ?? "", style: AppTextStyle.boldBlack16),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(widget.itemUI.description.trim() ?? "", style: AppTextStyle.grey13, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("\$${widget.itemUI.price}", style: AppTextStyle.boldBlack16),
//                        Text("\$16.000", style: AppTextStyle.grey14overline),
//                        DiscountChip(discountPercentage: "50"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: counterVisible
                            ? CounterTouch(initialValue: quantity ?? 0, onChanged: onQuantityChange)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: widget.itemUI.image == null ? Icon(Icons.fastfood, color: Colors.black12,) : Image.network(widget.itemUI.image, fit: BoxFit.fill),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          divider ? Divider(thickness: 2) : SizedBox(),
        ],
      ),
    );
  }
}
