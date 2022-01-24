extension GenericApply<T> on T {
  R app<R>(R Function(T) appFunc) => appFunc(this);
}
