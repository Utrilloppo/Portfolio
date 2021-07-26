String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + '時間前';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + '分前';
    } else if (diff.inSeconds > 0) {
      time = 'now';
    } else if (diff.inMilliseconds > 0) {
      time = 'now';
    } else if (diff.inMicroseconds > 0) {
      time = 'now';
    } else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = diff.inDays.toString() + '日前';
  } else if (diff.inDays > 6) {
    time = (diff.inDays / 7).floor().toString() + '週間前';
  } else if (diff.inDays > 29) {
    time = (diff.inDays / 30).floor().toString() + '分前';
  } else if (diff.inDays > 365) {
    time = '${date.month} ${date.day}, ${date.year}';
  }
  return time;
}
