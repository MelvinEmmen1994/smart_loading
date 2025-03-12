import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ThreeDView extends StatefulWidget {
  final int palletCount;

  const ThreeDView({super.key, required this.palletCount});

  @override
  State<ThreeDView> createState() => _ThreeDViewState();
}

class _ThreeDViewState extends State<ThreeDView> {
  late Scene _scene;

  @override
  void initState() {
    super.initState();
    _scene = Scene();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D Laadweergave')),
      body: Cube(
        onSceneCreated: (Scene scene) {
          _scene = scene;
          _scene.camera.position.z = 10;

          for (int i = 0; i < widget.palletCount; i++) {
            scene.world.add(Object(
              scale: Vector3(1.5, 0.5, 1),
              position: Vector3(i.toDouble() - 2, 0, 0),
              fileName: 'assets/cube.obj',
            ));
          }
        },
      ),
    );
  }
}
