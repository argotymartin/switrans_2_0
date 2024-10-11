class EntityUpdate<T> {
  final int id;
  final T entity;

  EntityUpdate({
    required this.id,
    required this.entity,
  });
}
