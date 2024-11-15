import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:latlong2/latlong.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/domain/domain.dart';
import 'package:switrans_2_0/src/packages/maestro/municipio/ui/blocs/municipio_bloc.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';


class MunicipioCreateView extends StatelessWidget {
  const MunicipioCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MunicipioBloc, MunicipioState>(
      listener: (BuildContext context, MunicipioState state) {
        if (state.status == MunicipioStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
        if (state.status == MunicipioStatus.succes) {
          final MunicipioRequest request = MunicipioRequest(codigo: state.municipio!.codigo);
          context.read<MunicipioBloc>().add(GetMunicipiosEvent(request));
          context.go('/maestros/municipio/buscar');
        }
      },
      builder: (BuildContext context, MunicipioState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.storage_outlined,
                  child: _BuildFieldsForm(state),
                ),
              ],
            ),
            if (state.status == MunicipioStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final MunicipioState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final MunicipioBloc municipioBloc = context.watch<MunicipioBloc>();
    final MunicipioRequest request = municipioBloc.request;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              TextInputForm(
                title: "Nombre",
                value: request.nombre,
                typeInput: TypeInput.lettersAndNumbers,
                isRequired: true,
                minLength: 5,
                onChanged: (String result) {
                  request.nombre = result.isNotEmpty ? result : null;
                },
                autofocus: true,
              ),
              TextInputForm(
                title: "Codigo Dane",
                value: request.codigoDane,
                typeInput: TypeInput.onlyNumbers,
                minLength: 3,
                maxLength: 3,
                icon: Icons.numbers,
                onChanged: (String result) => request.codigoDane = result.isNotEmpty ? result : null,
              ),
              TextInputForm(
                title: "Latitud",
                value: request.latitud?.toString(),
                typeInput: TypeInput.onlyNumbers,
                icon: Icons.numbers,
                onChanged: (String result) => request.latitud = double.tryParse(result),
              ),
              TextInputForm(
                title: "Longitud",
                value: request.longitud?.toString(),
                typeInput: TypeInput.onlyNumbers,
                icon: Icons.numbers,
                onChanged: (String result) => request.longitud = double.tryParse(result),
              ),
              AutocompleteInputForm(
                title: 'Pais',
                entries: state.municipioPaises,
                value: request.codigoPais,
                onChanged: (EntryAutocomplete result) {
                  request.codigoPais = result.codigo;
                  if (result.codigo != null) {
                    final MunicipioPais resultPais = MunicipioPais(
                      codigo: result.codigo!,
                      nombre: result.title,
                    );
                    municipioBloc.add(SelectMunicipioPaisEvent(resultPais));
                  }
                  if (result.codigo == null) {
                    municipioBloc.add(const CleanSelectMunicipioPaisEvent());
                  }
                },
              ),
              AutocompleteInputForm(
                title: 'Departamento',
                entries: request.codigoPais == null ? <EntryAutocomplete>[] : state.municipioDepartamentos,
                value: request.codigoDepartamento,
                onChanged: (EntryAutocomplete result) => request.codigoDepartamento = result.codigo,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              // Aquí está la parte del mapa, modificada a StatefulWidget
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blue,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: MunicipioMap(request: request),
                ),
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();
              if (isValid) {
                municipioBloc.request.codigoUsuario = context.read<AuthBloc>().state.auth?.usuario.codigo;
                context.read<MunicipioBloc>().add(SetMunicipioEvent(request));
              }
            },
            icon: Icons.save,
            label: "Crear",
          ),
        ],
      ),
    );
  }
}

class MunicipioMap extends StatefulWidget {
  final MunicipioRequest request;

  const MunicipioMap({required this.request, super.key});

  @override
  MunicipioMapState createState() => MunicipioMapState();
}

class MunicipioMapState extends State<MunicipioMap> {
  final Set<Marker> _flutterMapMarkers = <Marker>{};
  final Set<google.Marker> _googleMapMarkers = <google.Marker>{};
  bool _isGoogleMap = false;

  @override
  void initState() {
    super.initState();

    // Verificar si ya hay coordenadas iniciales, de lo contrario usa un valor predeterminado
    if (widget.request.latitud != null && widget.request.longitud != null) {
      final LatLng initialPosition = LatLng(widget.request.latitud!, widget.request.longitud!);

      // Google Maps: Agregar marcador inicial con texto
      _googleMapMarkers.add(
        google.Marker(
          markerId: const google.MarkerId('1'),
          position: google.LatLng(initialPosition.latitude, initialPosition.longitude),
          infoWindow: const google.InfoWindow(title: 'Ubicación inicial', snippet: 'Este es el marcador inicial'),
        ),
      );

      // OpenStreetMap: Agregar marcador inicial
      _flutterMapMarkers.add(
        Marker(
          point: initialPosition,
          builder: (BuildContext context) => const Icon(Icons.location_pin, color: Colors.red, size: 40),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text("Usar Google Maps"),
          value: _isGoogleMap,
          onChanged: (bool value) {
            setState(() {
              _isGoogleMap = value;
            });
          },
        ),
        Expanded(
          child: _isGoogleMap ? googleMapsWidget() : flutterMapWidget(),
        ),
      ],
    );
  }

  // Google Maps Widget
  Widget googleMapsWidget() {
    return google.GoogleMap(
      initialCameraPosition: google.CameraPosition(
        target: google.LatLng(widget.request.latitud ?? 4.6678, widget.request.longitud ?? -74.1681),
        zoom: 12,
      ),
      markers: _googleMapMarkers,
      onMapCreated: (google.GoogleMapController controller) {
        // Aquí podrías agregar otros marcadores si lo necesitas
        setState(() {
          // Agregar un marcador adicional con una ubicación diferente
          _googleMapMarkers.add(
            const google.Marker(
              markerId: google.MarkerId('2'), // Asegúrate de que el ID sea único
              position: google.LatLng(4.6789, -74.1700), // Coordenadas del nuevo marcador
              infoWindow: google.InfoWindow(title: 'Nuevo Marcador'),
            ),
          );
        });
      },
      onTap: (google.LatLng position) {
        setState(() {
          widget.request.latitud = position.latitude;
          widget.request.longitud = position.longitude;
        });

        // Mostrar las coordenadas en un popup
        _showCoordinatesDialog(context, position.latitude, position.longitude);
      },
    );
  }

  // OpenStreetMap (FlutterMap) Widget
  Widget flutterMapWidget() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.request.latitud ?? 4.6678, widget.request.longitud ?? -74.1681),
        zoom: 12.0,
        onTap: (_, LatLng position) {
          setState(() {
            _flutterMapMarkers.add(
              Marker(
                point: position,
                builder: (BuildContext context) => const Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            );
            widget.request.latitud = position.latitude;
            widget.request.longitud = position.longitude;
            final MunicipioBloc municipioBloc = context.read<MunicipioBloc>();
            municipioBloc.add(const InitialMunicipioEvent());
          });

          // Mostrar las coordenadas en un popup
          _showCoordinatesDialog(context, position.latitude, position.longitude);
        },
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: _flutterMapMarkers.toList(),
        ),
      ],
    );
  }

  // Método para mostrar el diálogo con las coordenadas
  void _showCoordinatesDialog(BuildContext context, double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coordenadas del marcador'),
          content: Text('Latitud: $latitude\nLongitud: $longitude'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
