import 'package:flutter/material.dart';
import 'package:remap/components/slimCard.dart';
import 'package:remap/utils/utils.dart';
import 'package:remap/screens/AddMarker/SelectPosition.dart';

class TutorialesListGenerator extends StatelessWidget {
  const TutorialesListGenerator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: getResponsiveDps(199, width),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          SlimCard(
            nombre: 'Mapea una tienda',
            url:
                'https://i2.wp.com/www.insights.la/wp-content/uploads/2018/01/Customer-Journey-Mapping.jpg?fit=620%2C400&ssl=1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectPositionScreen(),
                ),
              );
            },
          ),
          SlimCard(
            nombre: 'Mapea una tienda',
            url:
                'https://i2.wp.com/www.insights.la/wp-content/uploads/2018/01/Customer-Journey-Mapping.jpg?fit=620%2C400&ssl=1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectPositionScreen(),
                ),
              );
            },
          ),
          SlimCard(
            nombre: 'Mapea una tienda',
            url:
                'https://i2.wp.com/www.insights.la/wp-content/uploads/2018/01/Customer-Journey-Mapping.jpg?fit=620%2C400&ssl=1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectPositionScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
