# TrackMapper

Prueba técnica de seguimiento de la ruta de un usuario en un mapa, guardando las distintas rutas.

En esta prueba se implementa clean architecture distribuyendo la aplicación en las capas de domain para la parte de negocio con los distintos casos de uso, data para la parte de datos donde se guardan las distintas rutas mediante Core Data y la parte de App donde están las vistas usando en esta parte el patrón Model-View-ViewModel.

Así mismo se ha hecho uso de RxSwift para la comunicación entre las distintas capas, así como entre las vistas y sus viewModels respectivos.

Las librerías de terceros usadas han sido implementadas usando CocoaPods y son las siguientes:

RxSwift, RxCocoa y Action para la implementación de Reactive y SnapKit para añadir constraints por código a las vistas.