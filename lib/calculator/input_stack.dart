class InputStack<E> {
  List<E> _stack = new List.empty(growable: true);

  void push(E item) => _stack.add(item);

  E pop() => _stack.removeLast();

  E peek() => _stack.last;

  void clear() => _stack = new List.empty(growable: true);

  bool get isEmpty => _stack.isEmpty;

  int get length => _stack.length;

  String toString() {
    String result = "";
    for (E item in _stack) {
      result +=  " [$item] ";
    }
    return result;
  }
}