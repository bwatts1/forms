List<String> generateBadges(double passwordStrength, DateTime time, double progress) {
  List<String> badges = [];
  if (passwordStrength == 1.0) badges.add("💪 Strong Password Master");
  if (time.hour < 12) badges.add("🌅 Early Bird Special");
  if (progress == 1.0) badges.add("🧙 Profile Completer");
  return badges;
}
