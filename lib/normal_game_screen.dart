import 'package:flutter/material.dart';
import 'package:mathlympics/global_styles.dart';
import 'package:mathlympics/game_over_screen.dart';

class NormalGameScreen extends StatefulWidget {
  const NormalGameScreen({super.key, this.isIntegral = false});
  final bool isIntegral;
  State<StatefulWidget> createState() => _NormalGameScreen();
}

class _NormalGameScreen extends State<NormalGameScreen> {
  List<List<Offset>> lines = [];
  List<String> eq_arithmetics = [
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

  List<String> eq_integrals = [
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

  int idx = 0;

  // check bounds of drawing
  bool isPointWithinBounds(Offset point, Size size) {
    return point.dx >= 0 &&
        point.dx <= size.width &&
        point.dy >= 0 &&
        point.dy <= size.height;
  }

  void equationIndexIncrement() {
    setState(() {
      idx++;
      if (idx >=
          (widget.isIntegral
              ? eq_integrals.length - 3
              : eq_arithmetics.length - 3)) {
        idx = 0;
        Navigator.pushNamed(context, '/game-over');
        //should finish the game
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalStyles.colors.white,
      body: Row(
        children: [
          // math questions side ------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isIntegral ? eq_integrals[idx] : eq_arithmetics[idx],
                    style: TextStyle(fontSize: 24, color: Colors.black87),
                  ),
                  Text(
                    widget.isIntegral
                        ? eq_integrals[idx + 1]
                        : eq_arithmetics[idx + 1],
                    style: TextStyle(fontSize: 24, color: Colors.black87),
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
                          ? eq_integrals[idx + 2]
                          : eq_arithmetics[idx + 2],
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                  ),
                  Text(
                    widget.isIntegral
                        ? eq_integrals[idx + 3]
                        : eq_arithmetics[idx + 3],
                    style: TextStyle(fontSize: 24, color: Colors.black87),
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

                  //erase button
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
                      'Erase',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, //or black idk what u guys prefer
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //TO DELETE LATER, ONLY FOR TESTING
      floatingActionButton: ElevatedButton(
          onPressed: () {
            equationIndexIncrement();
          },
          child: Text('+')),
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
