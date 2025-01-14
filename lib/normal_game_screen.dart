import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "dart:async";

class NormalGameScreen extends StatefulWidget {
  const NormalGameScreen({super.key, this.isIntegral = false});
  final bool isIntegral;

  @override
  State<StatefulWidget> createState() => _NormalGameScreen();
}

class _NormalGameScreen extends State<NormalGameScreen> {
  List<List<Offset>> lines = [];
  List<String> eqArithmetics = [
    "", //keep this
    "", //keep this
    "420 / 69 = __",
    "2 x 6 = __",
    "42 / 21 = __",
    "36 x 12 = __",
    "1 + 1 = __",
    "5 x 5 = __",
    "7 x 7 = __",
    "10 + 11 = __",
    "BOY YOU STUPID HOW DID YOU GET THIS WRONG",
    "" //keep this
  ];

  List<String> eqIntegrals = [
    "", //keep this
    "", //keep this
    "∫ 2x dx = __",
    "∫ 3x dx = __",
    "∫ 4x dx = __",
    "∫ 5x dx = __",
    "∫ 6x dx = __",
    "∫ 7x dx = __",
    "∫ 8x dx = __",
    "∫ 9x dx = __",
    "∫ 10x dx = __",
    "∫ sin(x) dx = __",
    "∫ cos(x) dx = __",
    "∫ e^x dx = __",
    "∫ 1/x dx = __",
    "∫ ln(x) dx = __",
    "∫ tan(x) dx = __",
    "∫ sec(x) dx = __",
    "" //keep this
  ];

  Timer? _timer;
  double _time = 0;
  int idx = 0;
  double finalTime = 0;

  @override
  void initState() {
    super.initState();
    startChronometer();
  }

  void startChronometer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _time = double.parse((_time + 0.10).toStringAsFixed(2));
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // check bounds of drawing
  bool isPointWithinBounds(Offset point, Size size) {
    return point.dx >= 0 &&
        point.dx <= size.width &&
        point.dy >= 0 &&
        point.dy <= size.height;
  }

  void equationIndexIncrement() {
    setState(() async {
      idx++;
      if (idx >=
          (widget.isIntegral
              ? eqIntegrals.length - 3
              : eqArithmetics.length - 3)) {
        idx = 0;
        _timer?.cancel();
        // Save the final time to a global variable or a service
        // For example, using a global variable:
        finalTime = _time;
        await Navigator.pushNamed(context, "/game-over", arguments: {
          "finalTime": _time,
        });
        //should finish the game
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalStyles.colors.white,
      body: Stack(
        children: [
          Row(
            children: [
              // math questions side ------------------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.isIntegral
                            ? eqIntegrals[idx]
                            : eqArithmetics[idx],
                        style: globalStyles.font.equations,
                      ),
                      Text(
                        widget.isIntegral
                            ? eqIntegrals[idx + 1]
                            : eqArithmetics[idx + 1],
                        style: globalStyles.font.equations,
                      ),
                      //highlighted equation
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 157, 225,
                              244), //maybe change to a set colour from our styles
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.isIntegral
                              ? eqIntegrals[idx + 2]
                              : eqArithmetics[idx + 2],
                          style: globalStyles.font.equations,
                        ),
                      ),
                      Text(
                        widget.isIntegral
                            ? eqIntegrals[idx + 3]
                            : eqArithmetics[idx + 3],
                        style: globalStyles.font.equations,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 2,
                color: Colors.blue,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),

              //writting side ---------------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      //writting container
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: globalStyles.colors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return GestureDetector(
                                  onPanStart: (details) {
                                    final point = details.localPosition;
                                    if (isPointWithinBounds(
                                        point, constraints.biggest)) {
                                      setState(() {
                                        lines.add([point]);
                                      });
                                    }
                                  },
                                  onPanUpdate: (details) {
                                    final point = details.localPosition;
                                    if (isPointWithinBounds(
                                            point, constraints.biggest) &&
                                        lines.isNotEmpty) {
                                      setState(() {
                                        lines.last.add(point);
                                      });
                                    }
                                  },
                                  child: CustomPaint(
                                    size: Size.infinite,
                                    painter: DrawingPainter(lines: lines),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //erase button and + button
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            "Time: $_time",
                            style: globalStyles.font.header,
                          ),

                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                lines.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: globalStyles.colors.secondary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Erase",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white, //or black idk what u guys prefer
                              ),
                            ),
                          ),

                          //TO DELETE LATER, ONLY FOR TESTING
                          ElevatedButton(
                            onPressed: () {
                              equationIndexIncrement();
                            },
                            child: Text("+"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //button to exit
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () async {
                      await Navigator.popAndPushNamed(context, "/normal");
                    }),
                Text(
                  "Quit",
                  style: globalStyles.font.header,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//btw ask moi pas de question sur sa g copy de someone and it seemed smart
class DrawingPainter extends CustomPainter {
  final List<List<Offset>> lines;

  DrawingPainter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (var line in lines) {
      for (int i = 0; i < line.length - 1; i++) {
        canvas.drawLine(line[i], line[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
