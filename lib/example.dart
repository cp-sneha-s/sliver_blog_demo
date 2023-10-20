import 'package:flutter/material.dart';

class ChocolatePage extends StatefulWidget {
  const ChocolatePage({super.key});

  @override
  State<ChocolatePage> createState() => _ChocolatePageState();
}

class _ChocolatePageState extends State<ChocolatePage> {
  late final ScrollController scrollController;
  double scrollPercentage=0.0;


  final double maxHeight = 600;
  final double minHeight = 250;

  final double initialRadius=130;
  final double finalRadius= 60;

  @override
  void initState() {
    super.initState();
    scrollController= ScrollController();
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    double offset= scrollController.offset;
    double  maxOffset=350;
    setState(() {
      scrollPercentage=(offset/maxOffset).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            // physics: ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: SliverAppbarDelegate(
                    maxHeight: maxHeight / 2,
                    minHeight: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xff4b5de0),
                                Color(0xff1e0c98),
                              ]
                          )
                      ),
                    )
                ),
              ),
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppbarDelegate(
                        maxHeight: maxHeight / 2,
                        minHeight: 250,
                        child: Container(
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 16.0,bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text('Chips',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),),
                                SizedBox(height: 20,),
                                Text('\$12.99 ',style: TextStyle(color:Color(0xff1e0c98),fontWeight: FontWeight.w600,fontSize: 30),)
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                  recipeDetail()
                ],
              ),
            ],
          ),
          Positioned(
              top: (((maxHeight)/2)-initialRadius)*(1-scrollPercentage),
              right: (MediaQuery.of(context).size.width/2-initialRadius)*(1-scrollPercentage),
              child: Transform.scale(
                scale: (initialRadius-(initialRadius-finalRadius)*scrollPercentage)/100,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/chocolate.jpeg'),
                  radius: initialRadius,
                ),
              ))
        ],
      ),
    );
  }
}

class SliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  SliverAppbarDelegate(
      {Key? key, required this.maxHeight, required this.minHeight, required this.child});


  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) => SizedBox.expand(child: child,);

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppbarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

}

Widget recipeDetail() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 5,
            color: Colors.black45,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Details",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(loreamIpsumText, style: TextStyle(fontSize: 15),),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Ingredients",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 16,
          ),
          ...List.generate(
              ingredients.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(ingredients[index].toString()),
                  )),
        ],
      ),
    ),
  );
}

const String loreamIpsumText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
const List<String> ingredients = [
  "Vanilla",
  "Almond Flour",
  "Butter",
  "Cream",
  "Eggs",
  "Chocolates",
  "Peanut",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
  "Chocolates",
];