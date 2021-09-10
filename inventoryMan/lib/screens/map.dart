import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:inventoryMan/view_models/popupDialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

// api key AIzaSyA-HDdMTDwuNteQC9YY323QTtRg0H15JGA

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.lightAccent,
        title: Row(
          children: <Widget>[
            Text('Inventory Branch Locations',
                style: TextStyle(
                  color: ThemeConfig.lightPrimary,
                )),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.house_outlined,
                  color: ThemeConfig.lightPrimary,
                ),
                alignment: Alignment.center,
                padding: new EdgeInsets.all(80),
                color: Colors.black,
                onPressed: () {
                  print("Chart");
                  navigateToLandingPage(context);
                },
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('images/appDrawer.jpg')),
              color: ThemeConfig.lightAccent,
            ),
            child: Center(
              child: Text(
                'Inventory Branch List',
                style: TextStyle(
                  color: ThemeConfig.lightPrimary,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.pin_drop, color: ThemeConfig.darkBG),
            title: Text("Qing Shang Warehouse \n 青山仓库"),
            onTap: () {
              // Update the state of the app
              print("Qing Shang Warehouse \n 青山仓库");
              // moveToCongress();
              _gotoLocation(31.324640, 120.415562);
              // Then close the drawer

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop, color: ThemeConfig.darkBG),
            title: Text("Hu Qiu Warehouse \n 虎丘仓库"),
            onTap: () {
              // Update the state of the app
              print("Hu Qiu Warehouse \n 虎丘仓库");
              // libraryOfBodleian();
              _gotoLocation(31.330165, 120.430809);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop, color: ThemeConfig.darkBG),
            title: Text("Lan Shan Warehouse \n 蓝山仓库"),
            onTap: () {
              // Update the state of the app
              print("Lan Shan Warehouse \n 蓝山仓库");
              // libraryOfBritish();
              _gotoLocation(22.248989, 114.209566);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop, color: ThemeConfig.darkBG),
            title: Text("Wu Zhong Warehouse \n 吴中仓库"),
            onTap: () {
              // Update the state of the app
              print("Wu Zhong Warehouse \n 吴中仓库");
              // libraryOfBeinecke();
              _gotoLocation(31.259295, 120.631765);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop, color: ThemeConfig.darkBG),
            title: Text("Xu Zhou Warehouse \n 徐州仓库"),
            onTap: () {
              // Update the state of the app
              print("Xu Zhou Warehouse \n 徐州仓库");
              // libraryOfVatican();
              _gotoLocation(34.206652, 117.282220);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Colors.lightBlue),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Colors.lightBlue),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(31.324640, 120.415562), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(31.324640, 120.415562), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://cdn.technologyadvice.com/wp-content/uploads/2018/01/Fotolia_146463627_Subscription_Monthly_M.jpg",
                  31.324640,
                  120.415562,
                  "Qing Shang Warehouse \n 青山仓库"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://tse4-mm.cn.bing.net/th/id/OIP.-rntK1emmgGyj2w3GAp02QHaDt?pid=Api&rs=1",
                  31.330165,
                  120.430809,
                  "Hu Qiu Warehouse \n 虎丘仓库"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes("https://financesonline.com/uploads/2017/06/iv.jpg",
                  22.248989, 114.209566, "Lan Shan Warehouse \n 蓝山仓库"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://subta.com/wp-content/uploads/2018/08/warehouse-inventory-1024x680.jpg",
                  31.259295,
                  120.631765,
                  "Wu Zhong Warehouse \n 吴中仓库"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.procurious.com/blog-content/2017/02/Inside-Amazon-Warehouse5.jpg",
                  34.206652,
                  117.282220,
                  "Xu Zhou Warehouse \n 徐州仓库"),
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String factoryName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(factoryName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String factoryName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            factoryName,
            style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Chinese \u00B7 \u0024\u0024 \u00B7 1.6 mi",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(31.324640, 120.415562), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          wuZhongMarker,
          xuZhouMarker,
          qingshanMarker,
          huQiuMarker,
          lanShanMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker qingshanMarker = Marker(
  markerId: MarkerId("Qing Shang Warehouse \n 青山仓库"),
  position: LatLng(31.324640, 120.415562),
  infoWindow: InfoWindow(title: '青山仓库'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker huQiuMarker = Marker(
  markerId: MarkerId('Hu Qiu Warehouse \n 虎丘仓库'),
  position: LatLng(31.330165, 120.430809),
  infoWindow: InfoWindow(title: '虎丘仓库'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker lanShanMarker = Marker(
  markerId: MarkerId('Lan Shan Warehouse \n 蓝山仓库'),
  position: LatLng(22.248989, 114.209566),
  infoWindow: InfoWindow(title: '蓝山仓库'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

//New York Marker

Marker wuZhongMarker = Marker(
  markerId: MarkerId('Wu Zhong Warehouse \n 吴中仓库'),
  position: LatLng(31.259295, 120.631765),
  infoWindow: InfoWindow(title: '吴中仓库'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker xuZhouMarker = Marker(
  markerId: MarkerId('Xu Zhou Warehouse \n 徐州仓库'),
  position: LatLng(34.206652, 117.282220),
  infoWindow: InfoWindow(title: '徐州仓库'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Future navigateToLandingPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LandingPage()));
}
