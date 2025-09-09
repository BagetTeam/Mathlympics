import "package:mathlympics/models.dart";

Future<void> updateScores(String userId, String mode, double newScore) async {
  final currentLeaderboardData = await supabase
      .from("leaderboard")
      .select()
      .eq("uid", userId)
      .eq("mode", mode)
      .maybeSingle();

  final currentTopScoreData = await supabase
      .from("top_scores")
      .select()
      .eq("uid", userId)
      .eq("mode", mode)
      .order("score",
          ascending: RegExp(r"time\d+").hasMatch(mode) ? true : false);

  int numberOfTopScores = currentTopScoreData.length;

  if (numberOfTopScores < 5) {
    await supabase.from("top_scores").insert({
      "uid": userId,
      "mode": mode,
      "score": newScore,
    });
  } else {
    final worstScoreData = currentTopScoreData
        .map((hashMap) => TopScoresModel.fromJson(hashMap))
        .first;
    if (worstScoreData.score > newScore) {
      await supabase
          .from("top_scores")
          .update({"score": newScore})
          .eq("uid", userId)
          .eq("mode", mode)
          .eq("score", worstScoreData.score);
    }
  }

  if (currentLeaderboardData == null) {
    await supabase.from("leaderboard").insert({
      "uid": userId,
      "mode": mode,
      "score": newScore,
    });
  } else if (currentLeaderboardData["score"] > newScore) {
    await supabase
        .from("leaderboard")
        .update({"score": newScore})
        .eq("uid", userId)
        .eq("mode", mode);
  }
}
