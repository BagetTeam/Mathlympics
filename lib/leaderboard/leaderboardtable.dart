import "dart:collection";

import "package:mathlympics/models.dart";

class Leaderboardtable {
  Future<void> updateLeaderboard(
      String userId, String mode, double newScore) async {
    try {
      final currentData = (await supabase
          .from('leaderboard')
          .select('top_score')
          .eq('id', userId)
          .eq('mode', mode)
          .single()); //.map((hashMap) => LeaderboardModel(id: userID,));
      //if (currentData != null && )
      final response = await supabase.from('leaderboard').upsert({
        'id': userId,
        'mode': mode,
        'top_score': newScore,
      }, onConflict: 'id,mode');

      if (response.error != null) {
        // Handle error
        print('Error updating leaderboard: ${response.error!.message}');
      } else {
        // Log success
        print(
            'Leaderboard updated successfully for user $userId, mode: $mode, score: $newScore');
      }
    } catch (e) {
      // Catch and log any unexpected exceptions
      print('Unexpected error updating leaderboard: $e');
    }
  }
}
