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
        physics: BouncingScrollPhysics(),
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
            nombre: 'Política de uso',
            url:
                'https://i2.wp.com/www.insights.la/wp-content/uploads/2018/01/Customer-Journey-Mapping.jpg?fit=620%2C400&ssl=1',
            onPressed: () {
              showLongTextDialog(context, """ Política de Uso
Acerca de:

Todos más cerca es una plataforma solidaria y colaborativa desarrollada por OPTIMUSOCIAL.CIA LTDA, con la cual se desea reactivar la economía y los pequeños negocios obligados a cerrar debido a la crisis que conlleva el COVID-19 a nivel mundial. No obstante, nosotros actuamos solamente como un servicio de alojamiento, manteniendo la infraestructura técnica y organizativa que permite a los usuarios tanto de comercios como clientes, cumplir con la carga de información y búsqueda de establecimientos. Debido a este rol único hay un par de cosas que usted debe considerar de nuestra relación con usted, los datos, y los usuarios:

    No ejercemos un rol de moderación o edición: Como la información cargada se la realiza de manera colaborativa, todo el contenido sobre los negocios locales lo proveen usuarios como usted, y no ejercemos un rol de moderación o edición. Esto significa que generalmente no monitoreamos o editamos el contenido de los sitios cargados en la plataforma, y no ejercemos responsabilidad alguna por este contenido. Del mismo modo, no respaldamos ninguna opinión expresada a través de nuestros servicios, y no representamos o garantizamos la veracidad, exactitud o confiabilidad del contenido publicado por la comunidad. En cambio, nosotros simplemente proveemos acceso al contenido que sus usuarios colegas han contribuido.
    Usted es el único responsable de sus actos: Usted es responsable legalmente de sus contribuciones a la plataforma. Para su propia protección, usted debe ejercitar la debida diligencia y evitar contribuir en cualquier tipo de contenido que pueda resultar en responsabilidad civil o criminal para usted bajo las leyes aplicables. Para mayor claridad, las leyes aplicables incluyen las de la República del Ecuador. OPTIMUSSOCIAL CIA LTDA. no puede ofrecer ningún tipo de protección, garantía, inmunidad o indemnización. 

Sobre los Datos:

Dado que nuestros servicios son usados por personas dentro de todo el territorio nacional, la información, que nosotros recopilamos puede ser guardada y procesada en Ecuador, en cualquier otro país en el cual se acceda a la web. Usando nuestros servicios usted consiente a dicha transferencia de información fuera de su país.
La información que alojamos:

    Podrá encontrar material reprobable o erróneo: Como proveemos un amplio rango de contenido ingresado por usuarios colegas, usted podrá encontrar información que usted encuentre errónea, engañoso, mal etiquetado, o de otro modo objetable. Por lo tanto, le pedimos que tenga sentido común y buen juicio cuando use nuestros servicios
    Nuestro contenido es solamente para uso informativo general: Aunque alojamos una gran cantidad de información de locales comerciales, como Tiendas, abarrotes, restaurantes, víveres/fruterías, panaderías, mascotas, servicios médicos y otras más. No se debería considerar como información oficial o general, o como una fuente de consulta, infalible.
    Entiendase otras más como productos o servicios que generen una recurrencia en las ventas hacia el usuario final. No venta de productos o servicios que se venda una sola vez, como por ejemplo: Venta de electrodomesticos de casa, o venta de libros usados etc. 

Sobre la información ingresada de terceros:

Usted es el único responsable por el uso o ingreso de datos de terceros. Aunque la información contiene dirección, una foto, y un teléfono de contacto, no respaldamos ni somos responsables por su disponibilidad, precisión de la información, productos o servicios relacionados, ni tenemos obligación alguna de monitorear dicho contenido de terceros.
Renuncias

Proveemos estos servicios bajo las cláusulas de "tal y como están" y "como estén disponibles". Por ello renunciamos expresamente a cualquier garantía expresa o implícita de todo tipo, incluyendo, pero no limitando, las garantías implícitas de comercialización, idoneidad para un propósito, pago, acuerdos con locales comerciales y clientes, entrega particular y no infracción. No ofrecemos ninguna garantía de que nuestros servicios satisfagan sus necesidades, sean seguros, ininterrumpidos, precisos y sin errores, o que su información o integridad personal estarán seguras.

No somos responsables por el contenido, datos o acciones de terceros, y usted libera, a nuestros directores, funcionarios, empleados y agentes de cualquier reclamo y daños, tanto conocidos como desconocidos, que surjan o relacionados de alguna manera con cualquier reclamación que tenga contra cualquier tercero. Ningún consejo o información, ya sea oral o escrita, obtenida por usted de nosotros, través de nuestros servicios, crea ningún tipo de garantía que no esté expresamente establecido en estas políticas de de uso.

Cualquier material descargado u obtenido, además de cualquier acuerdo, pago, o contacto con terceros (comercios, o externos) a través del uso de nuestros servicios se realiza bajo su propia discreción y riesgo y usted, será el único responsable de cualquier consecuencia que usted se vea afectado por alguna información obtenida por medio de nuestro servicio. Usted acepta que no tenemos ninguna responsabilidad u obligación por la supresión o no almacenamiento o transmisión del contenido o la comunicación mantenida medio el servicio dentro y fuera de éste. Nos reservamos el derecho a establecer límites sobre el uso y almacenamiento a nuestra discreción en cualquier momento con o sin previo aviso.
Limitación de responsabilidad:

OPTIMUSOCIAL.CIA LTDA no será responsable ante usted o cualquier otra parte por cualquier daño directo, indirecto, casual, especial, resultante o ejemplar, incluyendo, pero no limitado a daños por pérdidas de ganancias, fondos, uso, datos u otras pérdidas intangibles, más allá de si nosotros fuimos advertidos de la posibilidad de dicho daño. En el caso de que la ley aplicable no permita la limitación o exclusión de responsabilidad o daños casuales o resultantes, nuestra responsabilidad estará limitada al máximo permitido por la ley aplicable.
Gracias:

Apreciamos que usted se haya tomado tiempo para leer estas políticas de uso, y le agradecemos que usted contribuya este proyecto solidario y use nuestros servicios. Mediante sus contribuciones, usted no solo está ayudando a construir algo realmente grande sino también una vibrante comunidad de pares igualmente involucrados, enfocados en una muy noble meta. """);
            },
          )
        ],
      ),
    );
  }
}
