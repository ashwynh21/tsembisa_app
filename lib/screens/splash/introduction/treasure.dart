import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tsembisa/blocs/treasure/treasure_bloc.dart';
import 'package:tsembisa/theme/colors.dart';

class Treasure extends StatefulWidget {
  final Function proceed;

  Treasure({@required this.proceed});

  @override
  State<StatefulWidget> createState() => _TreasureState();
}

class _TreasureState extends State<Treasure> {

  final BorderRadius topradius = BorderRadius.only(
      topLeft: Radius.circular(80),
      topRight: Radius.circular(80),
      bottomRight: Radius.circular(12),
      bottomLeft: Radius.circular(12)
  ),
      bottomradius = BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(80),
          bottomLeft: Radius.circular(80)
      );
  final Map<MarkerId, Marker> markers = {};
  final Map<CircleId, Circle> circles = {};

  GoogleMapController controller;
  Marker usermarker;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider<TreasureBloc>(
        create: (_) => new TreasureBloc()..add(GetLocation()),
        child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  child: Material(
                    elevation: 4.0,
                    borderRadius: topradius,

                    child: ClipRRect(
                      borderRadius: topradius,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 112,

                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('lib/assets/images/corona.jpg'), fit: BoxFit.cover),

                              borderRadius: topradius,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 112,

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.64),

                              borderRadius: topradius,
                            ),
                          ),

                          Container(
                            child: Center(
                              child: Text(
                                'Tap on the map to mark where you live, this location will be permanent to your account',
                                style: TextStyle(
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.24), blurRadius: 2.0, offset: Offset(.0, 2.0))
                                  ]
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    child: Material(
                        elevation: 3.0,
                        borderRadius: bottomradius,
                        color: Colors.white,

                        child: ClipRRect(
                          borderRadius: bottomradius,
                          child: BlocConsumer<TreasureBloc, TreasureState>(
                            listener: (treasurecontext, state) {
                              if(state is FoundLocation) {
                                markers.addAll({
                                  state.marker.markerId: state.marker
                                });
                                usermarker = state.marker;

                                CameraUpdate position = CameraUpdate.newCameraPosition(CameraPosition(
                                    target: state.marker.position,
                                    zoom: 16
                                ));
                                controller.animateCamera(position);
                              }

                              if(state is CompleteLocation) {
                                widget.proceed();
                              }
                            },
                            builder: (treasurecontext, state) {
                              return GoogleMap(
                                mapType: MapType.normal,
                                zoomControlsEnabled: false,
                                compassEnabled: false,
                                markers: Set<Marker>.of(markers.values),
                                circles: Set<Circle>.of(circles.values),
                                onMapCreated: (controller) {
                                  this.controller = controller;
                                },
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(-26.529417, 31.492765),
                                    zoom: 12
                                ),
                                onTap: (position) {
                                  BlocProvider.of<TreasureBloc>(treasurecontext).add(UpdateLocation(
                                      location: position
                                  ));
                                },
                              );
                            }
                          ),
                        )
                    )
                ),

                Container(
                    width: 128,
                    height: 44,
                    margin: EdgeInsets.only(top: 44),
                    child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(22)),

                      child: BlocBuilder<TreasureBloc, TreasureState>(
                        builder: (treasurecontext, state) {
                          return InkWell(
                              onTap: () {
                                BlocProvider.of<TreasureBloc>(treasurecontext).add(SubmitLocation(
                                  location: usermarker.position
                                ));
                              },
                              borderRadius: BorderRadius.all(Radius.circular(22)),

                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: state is LoadingLocation ?
                                Center(
                                  child: Container(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator()
                                  ),
                                )
                                :
                                Text(
                                  'continue',
                                  style: TextStyle(
                                      color: accent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Baloo Paaji 2",
                                      height: 1.4
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          );
                        }
                      ),
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}