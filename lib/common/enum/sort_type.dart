enum SortType {
  desc('DESC', '최신순'),
  asc('ASC', '오래된순');

  final String code;
  final String displayName;
  const SortType(this.code, this.displayName);

  factory SortType.getByCode(String code) {
    return SortType.values.firstWhere(
      (value) => value.code == code,
      orElse: () => SortType.desc,
    );
  }

  factory SortType.getByDisplayName(String displayName) {
    return SortType.values.firstWhere(
        (value) => (value.displayName == displayName),
        orElse: () => SortType.desc);
  }
}
