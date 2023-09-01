import 'package:hardware_lo/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:hardware_lo/screens/brand_products.dart';
import 'package:hardware_lo/custom/box_decorations.dart';
class BrandSquareCard extends StatefulWidget {
  int id;
  String image;
  String name;

  BrandSquareCard({Key key, this.id, this.image, this.name}) : super(key: key);

  @override
  _BrandSquareCardState createState() => _BrandSquareCardState();
}

class _BrandSquareCardState extends State<BrandSquareCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BrandProducts(id: widget.id,brand_name: widget.name,);
        }));
      },
      child: Container(
         decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Flexible(
              //   flex: 1,
              //   //height: 60,
              //     //width: double.infinity,
              //     child: ClipRRect(
              //         borderRadius: BorderRadius.vertical(
              //             top: Radius.circular(16), bottom: Radius.zero),
              //         child: FadeInImage.assetNetwork(
              //           placeholder: 'assets/placeholder.png',
              //           image:  widget.image,
              //           fit: BoxFit.cover,
              //         )
              //     )
              // ),
              Container(
                // child: Padding(
                //   padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyTheme.blue,
                        fontSize: 17,
                        height: 1.6,
                        fontWeight: FontWeight.bold),
                  ),
//                ),
              ),
            ]),
      ),
    );
  }
}
