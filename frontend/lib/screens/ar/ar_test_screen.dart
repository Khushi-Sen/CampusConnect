import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';

class ARTestScreen extends StatefulWidget {
  @override
  _ARTestScreenState createState() => _ARTestScreenState();
}

class _ARTestScreenState extends State<ARTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Test'),
        backgroundColor: Colors.blue,
      ),
      body: ARView(
        onARViewCreated: (sessionManager, objectManager, anchorManager, locationManager) {
          // Initialize AR session
          sessionManager.onInitialize(
            showFeaturePoints: true,
            showPlanes: true,
            showWorldOrigin: true,
            handleTaps: true,
          );
          print("✅ AR is working!");
        },
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
    );
  }
}