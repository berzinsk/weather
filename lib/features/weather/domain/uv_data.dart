class UVData {
  final double latitude;
  final double longitude;
  final String dateIso;
  final int date;
  final double value;

  UVData({
    required this.latitude,
    required this.longitude,
    required this.dateIso,
    required this.date,
    required this.value,
  });

  factory UVData.fromJson(Map<String, dynamic> data) {
    final latitude = data['lat'] as double;
    final longitude = data['lon'] as double;
    final dateIso = data['date_iso'] as String;
    final date = data['date'] as int;
    final value = data['value'] as double;

    return UVData(
      latitude: latitude,
      longitude: longitude,
      dateIso: dateIso,
      date: date,
      value: value,
    );
  }
}
