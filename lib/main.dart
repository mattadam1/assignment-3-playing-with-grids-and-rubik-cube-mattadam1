import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  // Rotate top face to the left
  void rotateTop() {
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[0], tempTop[3], tempTop[1]];

    List<Color> tempFront = [faces[0][0], faces[0][1]];
    List<Color> tempLeft = [faces[1][0], faces[1][1]];
    List<Color> tempRight = [faces[2][0], faces[2][1]];
    List<Color> tempBack = [faces[3][0], faces[3][1]];

    faces[0][0] = tempLeft[0];
    faces[0][1] = tempLeft[1];
    faces[1][0] = tempBack[0];
    faces[1][1] = tempBack[1];
    faces[3][0] = tempRight[0];
    faces[3][1] = tempRight[1];
    faces[2][0] = tempFront[0];
    faces[2][1] = tempFront[1];
  }

  // Rotate bottom face to the right
  void rotateBottom() {
    List<Color> tempBottom = [...faces[5]];
    faces[5] = [tempBottom[2], tempBottom[0], tempBottom[3], tempBottom[1]];

    List<Color> tempFront = [faces[0][2], faces[0][3]];
    List<Color> tempLeft = [faces[1][2], faces[1][3]];
    List<Color> tempRight = [faces[2][2], faces[2][3]];
    List<Color> tempBack = [faces[3][2], faces[3][3]];

    faces[0][2] = tempRight[0];
    faces[0][3] = tempRight[1];
    faces[1][2] = tempFront[0];
    faces[1][3] = tempFront[1];
    faces[2][2] = tempBack[0];
    faces[2][3] = tempBack[1];
    faces[3][2] = tempLeft[0];
    faces[3][3] = tempLeft[1];
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void rotateTop() {
    setState(() {
      cube.rotateTop();
    });
  }

  void rotateBottom() {
    setState(() {
      cube.rotateBottom();
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top face
            Column(
              children: [
                const Text('Top'),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: buildFace(cube.faces[4]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left face
                Column(
                  children: [
                    const Text('Left'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[1]),
                    ),
                  ],
                ),
                // Front face
                SizedBox(
                  height: 100,
                  width: 100,
                  child: buildFace(cube.faces[0]),
                ),
                // Right face
                Column(
                  children: [
                    const Text('Right'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[2]),
                    ),
                  ],
                ),
              ],
            ),
            // Buttons for rotation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: rotateTop,
                  child: const Text('Rotate Top'),
                ),
                ElevatedButton(
                  onPressed: rotateBottom,
                  child: const Text('Rotate Bottom'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
