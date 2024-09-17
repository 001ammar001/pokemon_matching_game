class GameTimer {
  Stream<int> tick(int ticks) {
    return Stream.periodic(
      // one build each 100 miliseconds
      const Duration(milliseconds: 100),
      (computationCount) => ticks - computationCount - 1,
    ).take(ticks);
  }
}
