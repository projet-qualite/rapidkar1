import 'package:flutter/material.dart';
import 'package:rapidkar/utils/utils.dart';

class SpecificsCard extends StatelessWidget {
  final int price;
  final String name;
  final String name2;

  SpecificsCard({this.price, this.name, this.name2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: price == null ? 80 : 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: price == null
          ? Column(
        children: [
          Text(
            name,
            style: BasicHeading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name2,
            style: SubHeading,
          ),
        ],
      )
          : Column(
        children: [
          Text(
            name,
            style: BasicHeading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            (price == 0) ? '' : price.toString(),
            style: SubHeading,
          ),
          SizedBox(
            height: 5,
          ),
          Text(name2,
            style: SubHeading,)
        ],
      ),
    );
  }
}