import 'package:flutter/material.dart';
import 'package:remap/components/faceCard.dart';
import 'package:remap/utils/utils.dart';

class AliadosListGenerator extends StatelessWidget {
  const AliadosListGenerator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: getResponsiveDps(160, width),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return FaceCard(
              //
              nombre: 'Gonzalo',
              url:
                  'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500');
        },
      ),
    );
  }
}
