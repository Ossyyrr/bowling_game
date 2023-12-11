class ComposableRoll {
  ComposableRoll? nextRoll;
  int score = 0;
  bool isCompleted = false;

  void execute(int pins) {
    if (isCompleted) {
      createNextRoll().execute(pins);
      return;
    }
    score = pins;
    isCompleted = true;
  }

  ComposableRoll createNextRoll() {
    nextRoll ??= ComposableRoll();
    return nextRoll!;
  }

  List<ComposableRoll> asList() {
    List<ComposableRoll> rolls = [this];
    if (nextRoll != null) {
      rolls.addAll(nextRoll!.asList());
    }
    return rolls;
  }
}
