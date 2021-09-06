import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TodoListItemSkeleton extends StatelessWidget {
  final int index;

  TodoListItemSkeleton({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(
            5,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.grey[100],
              child: Container(
                height: 25,
                width: MediaQuery.of(context).size.width * .60,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200],
              highlightColor: Colors.grey[100],
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   width: 2,
                  //   color: Colors.grey,
                  // ),
                  color: Colors.grey,
                ),
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
