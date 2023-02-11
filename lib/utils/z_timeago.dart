String getTimeAgo(DateTime? dt) {
  if (dt == null) return '';

  var now = new DateTime.now().toUtc();
  now = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
  dt = new DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);

  var diff = now.difference(dt);

  if (diff.inSeconds <= 1) return '1 sec ago';
  if (diff.inSeconds < 60) return '${diff.inSeconds} secs ago';

  if (diff.inMinutes == 1) return '${diff.inMinutes} min ago';
  if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';

  if (diff.inHours == 1) return '${diff.inHours} hr ago';
  if (diff.inHours < 24) return '${diff.inHours} hrs ago';

  if (diff.inDays == 1) return '${diff.inDays} day ago';
  if (diff.inDays < 31) return '${diff.inDays} days ago';

  return '${diff.inDays} days ago';
}
