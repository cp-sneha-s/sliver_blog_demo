import 'dart:math';

import 'package:flutter/material.dart';

class SliverDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'SliverList demo',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverMainAxisGroup(slivers: [
              SliverPersistentHeader(
                delegate: HeaderDelegate(title: 'SliverList'),
                pinned: true,
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: decoratedSliverList(),
              ),
            ]),
            SliverMainAxisGroup(slivers: [
              SliverPersistentHeader(
                delegate: HeaderDelegate(title: 'SliverGrid'),
                pinned: true,
              ),
              sliverGrid(10)
            ])

            // SliverCrossAxisGroup(slivers: [
            //   SliverPadding(
            //       padding: const EdgeInsets.all(16),
            //       sliver: decoratedSliverList()),
            //   SliverCrossAxisExpanded(
            //     flex: 2,
            //     sliver: SliverPadding(
            //         padding: const EdgeInsets.all(16),
            //         sliver: decoratedSliverList()),
            //   ),
            //   SliverConstrainedCrossAxis(
            //     maxExtent: 200,
            //     sliver: SliverPadding(
            //         padding: const EdgeInsets.all(16),
            //         sliver: decoratedSliverList()),
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }


  Widget sliverGrid(int itemCount) {
    return SliverGrid.builder(
        itemCount: itemCount,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 200,
              width: 200,
              color:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
          );
        });
  }

  Widget decoratedSliverList() {
    return DecoratedSliver(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        color: Colors.yellow,
      ),
      sliver: SliverList.separated(
        itemBuilder: (_, int index) =>
            SizedBox(height: 50, child: Center(child: Text('Item $index'))),
        separatorBuilder: (_, __) => Divider(),
        itemCount: 15,
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  HeaderDelegate({required this.title}) : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return oldDelegate.title != title;
  }
}