import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ThreeDView extends StatefulWidget {
  const ThreeDView({super.key});

  @override
  State<ThreeDView> createState() => _ThreeDViewState();
}

class _ThreeDViewState extends State<ThreeDView> {
  late Object pallet;

  @override
  void initState() {
    super.initState();
    pallet = Object(fileName: "assets/pallet.obj");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3D Container Weergave")),
      body: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(pallet);
          scene.camera.position.z = 10;
        },
      ),
    );
  }
}
