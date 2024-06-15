class Event {
  final String artistDescription;
  final List<String> artistEvents;
  final String artistImageUrl;
  final String artistName;
  final String artistStyle;

  Event({
    required this.artistDescription,
    required this.artistEvents,
    required this.artistImageUrl,
    required this.artistName,
    required this.artistStyle,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      artistDescription: json['artistDescription'] ?? '',
      artistEvents: List<String>.from(json['artistEvents'] ?? []),
      artistImageUrl: json['artistImageUrl'] ?? '',
      artistName: json['artistName'] ?? '',
      artistStyle: json['artistStyle'] ?? '',
    );
  }
}
