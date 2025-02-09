import "package:flutter/material.dart";
import "package:mathlympics/global_styles.dart";
import "dart:async";
import "package:mathlympics/models.dart";
import 'dart:ui' as ui;
import "classifier.dart";

class NormalGameScreen extends StatefulWidget {
  const NormalGameScreen({super.key, this.userID, required this.mode});
  final String? userID;
  final Mode mode;

  @override
  State<StatefulWidget> createState() => _NormalGameScreen();
}

class _NormalGameScreen extends State<NormalGameScreen> {
  final questionState = QuestionState();

  final classifier = Classifier();
  List<List<Offset>> lines = [];
  int strokes = 0;
  final pointMode = ui.PointMode.points;
  int? digit;

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
  int? questionLength;
  List<String>? questionList;

  Timer? _timer;
  double _time = 0;
  int idx = 0;
  double finalTime = 0;

  @override
  void initState() {
    super.initState();
    startChronometer();
    getQuestionList();
  }

  void getQuestionList() {
    if (widget.mode == Mode.cal20) {
      questionLength = eqArithmetics.length - 3;
      questionList = eqArithmetics;
    } else if (widget.mode == Mode.integ10) {
      questionLength = eqIntegrals.length - 3;
      questionList = eqIntegrals;
    }
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

  Future<void> processDrawing() async {
    if (lines.isEmpty) return;

    // Flatten the last stroke into a single list of points
    final points = lines.last;
    if (points.isEmpty) return;

    try {
      // Get prediction for the drawn digit
      print("AIHDGBWIDUAIWDB \n\n\n\n\n\n\n AHDGUIWHADA");
      digit = await classifier.classifyDrawing(points);

      // Check if the digit matches the expected answer
      final currentQuestion = questionList![questionState.idx + 2];
      final expectedAnswer = extractExpectedAnswer(currentQuestion);
      print(
          "\n\n\n\n\n " + currentQuestion + expectedAnswer + digit.toString());

      if (digit.toString() == expectedAnswer) {
        await equationIndexIncrement();
        setState(() {
          lines.clear();
          digit = null;
        });
      }
    } catch (e) {
      print('Error classifying drawing: $e');
    }
  }

  String extractExpectedAnswer(String question) {
    // Extract the expected answer from questions like "2 x 6 = __"
    final parts = question.split('=');
    if (parts.length != 2) return '';

    final expression = parts[0].trim();
    try {
      // Evaluate the expression
      // Note: This is a simplified version. You'll need a proper expression evaluator
      if (expression.contains('x')) {
        final numbers =
            expression.split('x').map((s) => int.parse(s.trim())).toList();
        return (numbers[0] * numbers[1]).toString();
      } else if (expression.contains('/')) {
        final numbers =
            expression.split('/').map((s) => int.parse(s.trim())).toList();
        return (numbers[0] ~/ numbers[1]).toString();
      } else if (expression.contains('+')) {
        final numbers =
            expression.split('+').map((s) => int.parse(s.trim())).toList();
        return (numbers[0] + numbers[1]).toString();
      }
    } catch (e) {
      print('Error evaluating expression: $e');
    }
    return '';
  }

  // check bounds of drawing
  bool isPointWithinBounds(Offset point, Size size) {
    return point.dx >= 0 &&
        point.dx <= size.width &&
        point.dy >= 0 &&
        point.dy <= size.height;
  }

  Future<void> updateScores(String userId, Mode mode, double newScore) async {
    String modeName = mode.name;
    bool timed = false;
    int mult = 1;
    if (RegExp(r"time\d+").hasMatch(modeName)) {
      timed = true;
      mult = -1;
    }

    final currentLeaderboardData = await supabase
        .from("leaderboard")
        .select()
        .eq("uid", userId)
        .eq("mode", modeName)
        .maybeSingle();

    final currentTopScoreData = await supabase
        .from("top_scores")
        .select()
        .eq("uid", userId)
        .eq("mode", modeName)
        .order("score", ascending: timed);
    int numberOfTopScores = currentTopScoreData.length;

    if (numberOfTopScores < 5) {
      await supabase.from("top_scores").insert({
        "uid": userId,
        "mode": modeName,
        "score": newScore,
      });
    } else {
      final worstScoreData = currentTopScoreData
          .map((hashMap) => TopScoresModel.fromJson(hashMap))
          .first;

      if (worstScoreData.score * mult > newScore * mult) {
        await supabase
            .from("top_scores")
            .update({"score": newScore})
            .eq("uid", userId)
            .eq("mode", modeName)
            .eq("score", worstScoreData.score);
      }
    }

    if (currentLeaderboardData == null) {
      await supabase.from("leaderboard").insert({
        "uid": userId,
        "mode": modeName,
        "score": newScore,
      });
    } else if (currentLeaderboardData["score"] * mult > newScore * mult) {
      await supabase
          .from("leaderboard")
          .update({"score": newScore})
          .eq("uid", userId)
          .eq("mode", modeName);
    }
  }

  Future<void> equationIndexIncrement() async {
    if (questionState.idx + 1 >= questionLength!) {
      questionState.resetIdx();
      _timer?.cancel();
      finalTime = _time;
      // Handle async operations after setState
      if (widget.userID != null) {
        await Navigator.pushNamed(context, "/game-over", arguments: {
          "finalTime": finalTime,
        }).then((_) => updateScores(widget.userID!, widget.mode, finalTime));
      } else {
        await Navigator.pushNamed(context, "/game-over", arguments: {
          "finalTime": finalTime,
        });
      }
    } else {
      setState(() {
        questionState.incrementIdx();
      });
    }
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
                child: ListenableBuilder(
                  listenable: questionState,
                  builder: (context, child) {
                    return QuestionList(
                      mode: widget.mode,
                      questionState: questionState,
                      questionList: questionList!,
                    );
                  },
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
                                  onPanEnd: (DragEndDetails details) async {
                                    if (lines.isNotEmpty) {
                                      await processDrawing();
                                      setState(() {});
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
                          // Text(
                          //   "Time: $_time",
                          //   style: globalStyles.font.header,
                          // ),

                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                lines.clear();
                                digit = null;
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
                              lines.clear();
                            },
                            child: Text(digit.toString()),
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

class QuestionState extends ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void incrementIdx() {
    _idx++;
    notifyListeners();
  }

  void resetIdx() {
    _idx = 0;
    notifyListeners();
  }
}

class QuestionList extends StatefulWidget {
  const QuestionList({
    super.key,
    required this.mode,
    required this.questionState,
    required this.questionList,
  });
  final List<String> questionList;
  final Mode mode;
  final QuestionState questionState;

  @override
  State<StatefulWidget> createState() => _QuestionList();
}

class _QuestionList extends State<QuestionList> {
  @override
  Widget build(BuildContext context) {
    // Use widget.questionState.idx to access the current index
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.questionList[widget.questionState.idx],
            style: globalStyles.font.equations,
          ),
          Text(
            widget.questionList[widget.questionState.idx + 1],
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
              widget.questionList[widget.questionState.idx + 2],
              style: globalStyles.font.equations,
            ),
          ),
          Text(
            widget.questionList[widget.questionState.idx + 3],
            style: globalStyles.font.equations,
          ),
        ],
      ),
    ); // Your widget tree
  }
}
