abstract class ModelClient<T> {
  Future<void> get(String uuid);
  Future<void> create(T model);
  Future<void> update(T model);
  Future<void> delete(String uuid);

  Future<List<T>?> getAll();
  Future<void> createBulk(List<T> modelsToCreate);
  Future<void> updateBulk(List<T> modelsToUpdate);
  Future<void> deleteBulk(List<T> modelsToDelete);
}
