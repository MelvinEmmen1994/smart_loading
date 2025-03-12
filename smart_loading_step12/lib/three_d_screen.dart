import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class ThreeDScreen extends StatefulWidget {
  const ThreeDScreen({super.key});

  @override
  State<ThreeDScreen> createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  ARNode? containerNode;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  void onARViewCreated(
      ARSessionManager sessionManager, ARObjectManager objectManager, ARAnchorManager anchorManager) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
    );
  }

  Future<void> addContainer() async {
    if (containerNode != null) return;

    var newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/container.glb",
      position: vm.Vector3(0, 0, -1),
      scale: vm.Vector3(0.5, 0.5, 0.5),
    );

    bool didAdd = await arObjectManager.addNode(newNode);
    if (didAdd) {
      setState(() {
        containerNode = newNode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3D Laadweergave")),
      body: Column(
        children: [
          Expanded(
            child: ARView(
              onARViewCreated: onARViewCreated,
            ),
          ),
          ElevatedButton(
            onPressed: addContainer,
            child: const Text("Voeg container toe"),
          ),
        ],
      ),
    );
  }
}
