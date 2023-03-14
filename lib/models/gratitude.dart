class Gratitude {
  final int id;
  final String note;
  final String resolution;

  Gratitude({
    required this.id,
    required this.note,
    required this.resolution
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'resolution': resolution
    };
  }

  @override
  String toString() {
    return 'Gratitude{id: $id, note: $note, resolution: $resolution}';
  }
}