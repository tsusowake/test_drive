class Bird {
  final int id;
  final String name;
  final String thumbnail;

  Bird(
    this.id,
    this.name,
    this.thumbnail,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Bird && other.id == id;
  }

  @override
  int get hashCode => super.hashCode;
}
