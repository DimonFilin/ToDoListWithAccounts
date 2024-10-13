
class Note {
  String id;
  String title;
  String subtitle;
  String time;
  bool isDone;
  String timetodo;

  Note(this.id, this.title, this.time, this.subtitle, this.isDone,
      this.timetodo);

  //Convert time in string to actual time in DataTime
  DateTime parseTimeString(String timeString) {
    final parts = timeString.split(':');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final hour = int.parse(parts[3]);
    final minute = int.parse(parts[4]);
    //final now = DateTime.now();
    return DateTime(year, month, day, hour, minute);
  }

  //Return time in more usable type
  String getTimeRemaining(String deadline) {
    final deadlineform = parseTimeString(deadline);
    final now = DateTime.now();
    final difference = deadlineform.difference(now);

    if (difference.isNegative) {
      return 'Просрочено';
    } else {
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;
      //final seconds = difference.inSeconds % 60; :${seconds}s
      if (days != 0) {
        return '${days}d:${hours}h:${minutes}m';
      } else {
        if (hours != 0) {
          return '${hours}h:${minutes}m';
        } else {
          return '${minutes}m';
        }
      }
    }
  }
}
