import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  Map detail;
  DescriptionItem(this.detail);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: detail.entries
          .map(
            (e) => Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: 250,
                      child: Text(
                        e.value,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 15),
                      )),
                  Spacer(),
                  Container(
                      child: Text(
                    e.key,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}