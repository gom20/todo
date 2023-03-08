class Gratitude {
  final int id;
  final String note;

  Gratitude({
    required this.id,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
    };
  }

  @override
  String toString() {
    return 'Gratitude{id: $id, note: $note}';
  }
}