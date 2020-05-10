import 'package:flutter/material.dart';
import 'package:remap/components/slimCard.dart';
import 'package:remap/utils/utils.dart';

class TutorialesListGenerator extends StatelessWidget {
  const TutorialesListGenerator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: getResponsiveDps(199, width),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SlimCard(
              //
              nombre: 'Manual para mapear',
              url:
                  'https://i2.wp.com/www.insights.la/wp-content/uploads/2018/01/Customer-Journey-Mapping.jpg?fit=620%2C400&ssl=1');
        },
      ),
    );
  }
}
