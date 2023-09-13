import 'package:hardware_lo/custom/box_decorations.dart';
import 'package:hardware_lo/custom/btn.dart';
import 'package:hardware_lo/custom/device_info.dart';
import 'package:hardware_lo/custom/useful_elements.dart';
import 'package:hardware_lo/helpers/shimmer_helper.dart';
import 'package:hardware_lo/presenter/bottom_appbar_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hardware_lo/my_theme.dart';
import 'package:hardware_lo/ui_sections/drawer.dart';
import 'package:hardware_lo/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:hardware_lo/screens/category_products.dart';
import 'package:hardware_lo/repositories/category_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hardware_lo/app_config.dart';
import 'package:hardware_lo/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryList extends StatefulWidget {
  CategoryList(
      {Key key,
      this.parent_category_id = 0,
      this.parent_category_name = "",
      this.is_base_category = false,
      this.is_top_category = false,
      this.bottomAppbarIndex})
      : super(key: key);

  final int parent_category_id;
  final String parent_category_name;
  final bool is_base_category;
  final bool is_top_category;
  final BottomAppbarIndex bottomAppbarIndex;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

 //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Stack(children: [
        Container(
          height: DeviceInfo(context).height / 4,
          width: DeviceInfo(context).width,
          color: MyTheme.accent_color,
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/background_1.png",
          ),
        ),
        Scaffold(
          backgroundColor:Colors.transparent,
            //key: _scaffoldKey,



            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   iconTheme: IconThemeData(
            //     color: Colors.black, // Change this to your desired color
            //   ),
            //   actions: [
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //
            //         // PreferredSize(
            //         //      child: buildAppBar(context),
            //         //       preferredSize:Size(DeviceInfo(context).width,50,)),
            //
            //         //buildAppBar(context),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 2,bottom: 5),
            //           child: Icon(Icons.phishing,size:20,color: Colors.black,),
            //         ),
            //         Image.asset(
            //           'assets/appbarlogo.png',
            //           //height: 40,
            //           //width: 250,
            //         ),
            //
            //         // Container(
            //         //     padding: EdgeInsets.only(bottom: 4,left: 33),
            //         //     //margin: const EdgeInsets.fromLTRB(30, 5, 10, 0),
            //         //     child: GestureDetector(
            //         //         onTap: () {
            //         //           // Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
            //         //           // return;
            //         //         },
            //         //         child: Icon(Icons.search_rounded,size:20,color: Colors.black,)
            //         //
            //         //       // Image.asset(
            //         //       //   'assets/search.png',
            //         //       //   height: 16,
            //         //       //   //color: MyTheme.dark_grey,
            //         //       //   color: MyTheme.dark_grey,
            //         //       // ),
            //         //
            //         //     )
            //         // ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 2,bottom: 5),
            //           child: Icon(Icons.notifications,size:20,color: Colors.black,),
            //         ),
            //         //SizedBox(width: 7,),
            //         //Icon(Icons.shopping_cart,color: Colors.black,),
            //
            //         //                                                                                                                                                                                                Image.asset("assets/icons/wishicon.png",height: 30,width: 30,),
            //
            //         //buildSettingAndAddonsHorizontalMenu(),
            //
            //
            //         SizedBox(width: 14,),
            //       ],
            //     )
            //   ],
            // ),

          appBar: PreferredSize(
              child: buildAppBar(context),
              preferredSize:Size(DeviceInfo(context).width,50,)),
            body: buildBody()
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: widget.is_base_category || widget.is_top_category
              ? Container(
                  height: 0,
                )
              : buildBottomContainer(),
        )
      ]),
    );
  }

  Widget buildBody() {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([

          buildCategoryList(),
          Container(
            height: widget.is_base_category ? 60 : 90,
          )
        ]))
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return

      AppBar(
      backgroundColor: Colors.white,
      //centerTitle: true,
      leading: widget.is_base_category
          ? Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: 0.0),
              child: UsefulElements.backToMain(context, go_back: false,color:Colors.black),
            ),
          )
          : Builder(
              builder: (context) => IconButton(
                icon: Icon(CupertinoIcons.arrow_left, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
      title: Row(
        children: [
          Spacer(),
          Image.asset(
            'assets/appbarlogo.png',width:100,height: 80,
            //height: 40,
            //width: 250,
          ),
          Spacer(),
          Icon(Icons.notifications),
          Icon(Icons.notifications),

        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  String getAppBarTitle() {
    String name = widget.parent_category_name == ""
        ? (widget.is_top_category
            ? AppLocalizations.of(context).top_categories_ucf
            : AppLocalizations.of(context).categories_ucf)
        : widget.parent_category_name;

    return name;
  }

  buildCategoryList() {
   var data = widget.is_top_category
        ? CategoryRepository().getTopCategories()
        : CategoryRepository()
        .getCategories(parent_id: widget.parent_category_id);

    return FutureBuilder(
        future: data  ,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return SingleChildScrollView(
                child:buildShimmer()
            );
          }
          if (snapshot.hasError) {
            //snapshot.hasError
            print("category list error");
            print(snapshot.error.toString());
            return Container(
              height: 10,
            );
          } else if (snapshot.hasData) {




            //snapshot.hasData
            var categoryResponse = snapshot.data;
            return GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1,
                crossAxisCount: 2,
              ),

              itemCount: categoryResponse.categories.length,
              padding: EdgeInsets.only(top:15,left: 18,right: 18,bottom: widget.is_base_category?30:0),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return buildCategoryItemCard(categoryResponse, index);

              },
            );
          } else {
            return SingleChildScrollView(
              child:buildShimmer()
              /*
              ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 60,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 8.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .7,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),*/
            );
          }
        });
  }

  Widget buildCategoryItemCard(categoryResponse, index) {

    var itemWidth= ((DeviceInfo(context).width-36)/2.7);
    print(itemWidth);

    return Container(
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CategoryProducts(
                  category_id:
                  categoryResponse.categories[index].id,
                  category_name:
                  categoryResponse.categories[index].name,
                );
              },
            ),
          );
        },
        child: Container(
          //padding: EdgeInsets.all(8),
          //color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: itemWidth-28),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: categoryResponse.categories[index].banner,
                    fit: BoxFit.cover,
                    height: itemWidth,
                    width: DeviceInfo(context).width,
                  ),
                ),
              ),
              Container(
                height: 60,
                //color: Colors.amber,
                alignment: Alignment.center,
                width: DeviceInfo(context).width,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  categoryResponse.categories[index].name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 17,
                      height: 1.6,
                      fontWeight: FontWeight.w600),

                ),
              ),
              Spacer()
              /*Container(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Padding(
                      padding: EdgeInsets.fromLTRB(32, 8, 8, 4),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (categoryResponse
                                      .categories[index].number_of_children >
                                  0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryList(
                                        parent_category_id:
                                            categoryResponse.categories[index].id,
                                        parent_category_name:
                                            categoryResponse.categories[index].name,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                ToastComponent.showDialog(
                                    AppLocalizations.of(context)
                                        .category_list_screen_no_subcategories,
                                    gravity: Toast.center,
                                    duration: Toast.lengthLong);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .category_list_screen_view_subcategories,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: categoryResponse.categories[index]
                                              .number_of_children >
                                          0
                                      ? MyTheme.medium_grey
                                      : MyTheme.light_grey,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Text(
                            " | ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: MyTheme.medium_grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CategoryProducts(
                                      category_id:
                                          categoryResponse.categories[index].id,
                                      category_name:
                                          categoryResponse.categories[index].name,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .category_list_screen_view_products,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.medium_grey,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      height: widget.is_base_category ? 0 : 80,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 32),
                height: 40,
                child: Btn.basic(
                  minWidth: MediaQuery.of(context).size.width,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    AppLocalizations.of(context)
                            .all_products_of_ucf +
                        " " +
                        widget.parent_category_name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryProducts(
                        category_id: widget.parent_category_id,
                        category_name: widget.parent_category_name,
                      );
                    }));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


Widget  buildShimmer(){
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
        crossAxisCount: 3,
      ),

      itemCount: 18,
      padding: EdgeInsets.only(left: 18,right: 18,bottom: widget.is_base_category?30:0),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecorations.buildBoxDecoration_1(),
          child: ShimmerHelper().buildBasicShimmer(),
        );
      },
    );



  }
}
