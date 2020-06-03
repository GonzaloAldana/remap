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
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          FaceCard(
              nombre: 'Frena La Curva',
              url:
                  'https://www.redjovencoslada.es/wp-content/uploads/2020/03/frenalacurva.png'),
          FaceCard(
              nombre: 'Lab León',
              url:
                  'https://pbs.twimg.com/profile_images/1235225894937124864/LTEfa8Ij_400x400.jpg'),
          FaceCard(
              nombre: 'Universidad De La  Salle Bajío',
              url:
                  'https://scontent.fbjx1-1.fna.fbcdn.net/v/t1.0-9/87975138_1431217893726772_7426746831360491520_n.jpg?_nc_cat=107&_nc_sid=85a577&_nc_oc=AQm6cECTbxvT7cmPEL0Qy8__AEB_agBivpZMlPyN_Ggr7xpnVUthMu1XpDKVfWj94kA&_nc_ht=scontent.fbjx1-1.fna&oh=3869297e65f7ba5e636e6ee843e6cc8b&oe=5EFB8204')
        ],
      ),
    );
  }
}
