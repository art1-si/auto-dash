class Speed {
  const Speed._({required this.metersPerSecond});

  factory Speed.fromMeterPerSecond(double metersPerSecond) {
    return Speed._(metersPerSecond: metersPerSecond);
  }

  final double metersPerSecond;

  int get kilometersPerHour => (metersPerSecond * 3.6).toInt();

  int get milesPerHour => (metersPerSecond * 2.23694).toInt();

  @override
  String toString() {
    return '$metersPerSecond m/s = ${kilometersPerHour.toStringAsFixed(2)} km/h = ${milesPerHour.toStringAsFixed(2)} mph';
  }
}
