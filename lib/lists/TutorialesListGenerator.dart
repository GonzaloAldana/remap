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
              showLongTextDialog(context, """ Política de Uso de Meica

Acerca de:

Meica es una plataforma solidaria y colaborativa desarrollada por ACTG PROYECTOS & ReMap 4.0, con la cual conectamos a consumidores con tiendas cercanas, utilizando Inteligencia Artificial (AI, en inglés) para promover buenas prácticas de distanciamiento social y comercio electrónico.
No obstante, nosotros actuamos solamente como un servicio de alojamiento, manteniendo la infraestructura técnica y organizativa que permite a los usuarios tanto de comercios como clientes, cumplir con la carga de información y búsqueda de establecimientos. Por lo cual, se debe tener presente nuestra relación con usted, los datos, y los usuarios:
Ejercemos un rol retroactivo de moderación y edición: Como la información cargada bajo membresía “Freemium” se realiza de manera directa, todo el contenido sobre los negocios locales lo proveen usuarios como usted, y el rol de moderación o edición se realiza bajo petición. Contamos con validación para negocios registrados bajo otras modalidades, cuyo perfil puede ser modificado por el punto de contacto con la MIPyME y un asesor. Al tratarse de una plataforma colaborativa, no ejercemos responsabilidad alguna por el contenido de los sitios cargados en la plataforma o algún otro medio público de esta.Del mismo modo, no respaldamos ninguna opinión expresada a través de nuestros servicios freemium, y no representamos o garantizamos la veracidad, exactitud o confiabilidad del contenido publicado por la comunidad. En cambio, nosotros simplemente proveemos acceso al contenido que más usuarios han publicado..
Usted es el único responsable de sus actos: Usted es responsable legalmente de sus contribuciones a la plataforma. Para su propia protección, usted debe ejercitar la debida diligencia y evitar contribuir en cualquier tipo de contenido que pueda resultar en responsabilidad civil o criminal para usted bajo las leyes aplicables. Para mayor claridad, las leyes aplicables incluyen las de los Estados Unidos Mexicanos. Meica, ReMap 4.0, ACTG PROYECTOS o aliados,  no pueden ofrecer ningún tipo de protección, garantía, inmunidad o indemnización.

Sobre los Datos:

Dado que nuestros servicios son usados por personas dentro de todo el territorio nacional, la información, que nosotros recopilamos puede ser guardada y procesada en México y en cualquier otro país en el cual se acceda a la web. Usando nuestros servicios usted consiente a dicha transferencia de información fuera de su país.

La información que alojamos:

Podrá encontrar material reprobable o erróneo: El equipo de Meica está constantemente depurando la información alojada dentro de la plataforma; sin embargo, el contenido subido por los usuarios no es moderado en tiempo real. Como proveemos un amplio rango de contenido ingresado por usuarios, usted podrá encontrar información que usted encuentre errónea, engañosa, mal etiquetada, o de otro modo objetable. Por lo tanto, le pedimos que tenga sentido común y buen juicio cuando use nuestros servicios. 
El contenido alojado es solamente para uso informativo general: A pesar de la amplia oferta de comercios que Meica contiene, esta base de datos está siendo actualizada de manera paulatina a las diferentes dinámicas dentro de la economía actual. Es por ello que la información aquí contenida puede no corresponder con la oficial o general, ni ser considerada infalible. Para corroborar esta, a los usuarios se les invita a ponerse en contacto directo con los negocios usando la función dedicada a mensajería digital.
La plataforma aloja a MIPyMEs con ubicación establecida: Entiéndase por “ubicación establecida” a que el negocio cuenta con: lugar fijo de servicio y atención al cliente (puede ser local comercial, oficina, puesto, etc.), horario de atención que se pueda registrar en nuestros servidores, entre otras condiciones más amplias que se detallan al momento de adquirir una membresía. Meica no fue concebida para transacciones eventuales (venta de un inmueble, intercambio de productos, etc.).

Sobre la información ingresada de terceros:

El equipo de Meica se esfuerza constantemente para ofrecer un mejor servicio y se está moderando frecuentemente la información publicada dentro de la plataforma. Sin embargo, usted es el único responsable por el uso o ingreso de datos de terceros. Aunque la información contiene dirección, una foto, y un teléfono de contacto, no respaldamos ni somos responsables por su disponibilidad, precisión de la información, productos o servicios relacionados, ni tenemos obligación alguna de monitorear dicho contenido de terceros.

Renuncias:

Meica es una plataforma de servicios digitales para conectar a clientes con negocios locales, no nos hacemos responsables de las transacciones comerciales derivadas de una interacción dentro de Meica. Por ello renunciamos expresamente a cualquier garantía expresa o implícita de todo tipo, incluyendo, pero no limitando, las garantías implícitas de comercialización, idoneidad para un propósito, pago, acuerdos con locales comerciales y clientes, entrega particular y no infracción. No ofrecemos ninguna garantía de que nuestros servicios satisfagan sus necesidades, sean seguros, ininterrumpidos, precisos y sin errores, o que su información o integridad personal estarán seguras.
No somos responsables por el contenido, datos o acciones de terceros, y usted libera, a nuestros directores, funcionarios, empleados y agentes de cualquier reclamo y daños, tanto conocidos como desconocidos, que surjan o relacionados de alguna manera con cualquier reclamación que tenga contra cualquier tercero. Ningún consejo o información, ya sea oral o escrita, obtenida por usted de nosotros, través de nuestros servicios, crea ningún tipo de garantía que no esté expresamente establecido en estas políticas de uso.
Cualquier material descargado u obtenido, además de cualquier acuerdo, pago, o contacto con terceros (comercios, o externos) a través del uso de nuestros servicios se realiza bajo su propia discreción y riesgo y usted, será el único responsable de cualquier consecuencia que usted se vea afectado por alguna información obtenida por medio de nuestro servicio. Usted acepta que no tenemos ninguna responsabilidad u obligación por la supresión o no almacenamiento o transmisión del contenido o la comunicación mantenida medio el servicio dentro y fuera de éste. Nos reservamos el derecho a establecer límites sobre el uso y almacenamiento a nuestra discreción, así como la modificación de la Política de Uso de Meica, en cualquier momento con o sin previo aviso.

Limitación de responsabilidad:

ACTG PROYECTOS no será responsable ante usted o cualquier otra parte por cualquier daño directo, indirecto, casual, especial, resultante o ejemplar, incluyendo, pero no limitado a daños por pérdidas de ganancias, fondos, uso, datos u otras pérdidas intangibles, más allá de si nosotros fuimos advertidos de la posibilidad de dicho daño. En el caso de que la ley aplicable no permita la limitación o exclusión de responsabilidad o daños casuales o resultantes, nuestra responsabilidad estará limitada al máximo permitido por la ley aplicable.
 """);
            },
          )
        ],
      ),
    );
  }
}
