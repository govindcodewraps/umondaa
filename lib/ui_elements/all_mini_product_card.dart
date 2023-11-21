import 'package:umonda/custom/box_decorations.dart';
import 'package:umonda/helpers/system_config.dart';
import 'package:umonda/my_theme.dart';
import 'package:umonda/screens/product_details.dart';
import 'package:flutter/material.dart';

import '../helpers/shared_value_helper.dart';

class AllMiniProductCard extends StatefulWidget {
  int id;
  String image;
  String name;
  String main_price;
  String stroked_price;
  bool has_discount;
  bool is_wholesale;
  var discount;
  AllMiniProductCard({
    Key key,
    this.id,
    this.image,
    this.name,
    this.main_price,
    this.stroked_price,
    this.has_discount,
    this.is_wholesale=false,
    this.discount,
  }) : super(key: key);

  @override
  _AllMiniProductCardState createState() => _AllMiniProductCardState();
}

class _AllMiniProductCardState extends State<AllMiniProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(
            id: widget.id,
          );
        }));
      },
      child: Container(
        width: 135,
       // height:250,
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2.2,
                  child: Container(
                      width: double.infinity,
                     // height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(6), bottom: Radius.zero),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: widget.image,height: 100,width: 100,
                            fit: BoxFit.cover,
                          ))),
                ),
                Padding(
                  //padding: EdgeInsets.fromLTRB(8, 4, 8, 6),
                  padding: EdgeInsets.only(left: 8,top: 10),
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                widget.has_discount
                    ? Padding(
                  padding: EdgeInsets.only(left: 8,top: 10),
                  child: Text(
                    SystemConfig.systemCurrency != null
                        ? widget.stroked_price.replaceAll(
                        SystemConfig.systemCurrency.code,
                        SystemConfig.systemCurrency.symbol)
                        : widget.stroked_price,
                    maxLines: 1,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: MyTheme.medium_grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(left: 8,top: 10,bottom: 10),
                  child: Text(
                    SystemConfig.systemCurrency != null
                        ? widget.main_price.replaceAll(
                        SystemConfig.systemCurrency.code,
                        SystemConfig.systemCurrency.symbol)
                        : widget.main_price,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyTheme.accent_color,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ]),

          // discount and wholesale
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.has_discount)
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffe62e04),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x14000000),
                            offset: Offset(-1, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        widget.discount ?? "",
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.8,
                        ),
                        textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                    ),
                  Visibility(
                    visible: whole_sale_addon_installed.$,
                    child:  widget.is_wholesale
                        ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x14000000),
                            offset: Offset(-1, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        "Wholesale",
                        style: TextStyle(


                          fontSize: 10,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          height: 1.8,
                        ),
                        textHeightBehavior: TextHeightBehavior(
                            applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                    )
                        : SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),

          // whole sale
        ]),
      ),
    );
  }
}
