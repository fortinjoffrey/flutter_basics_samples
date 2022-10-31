# State management Bloc and Cubit / onTransition VS onChange

## Branch goal

1. Show how to use the `onTransition` method available on **Bloc*

```dart
const Transition({
    required State currentState,
    required this.event,
    required State nextState,
}) : super(currentState: currentState, nextState: nextState);
```

2. Show how to use the `onChange` method available on **Cubit*

```dart
const Change({
    required this.currentState, 
    required this.nextState,
});
```

### What is the main difference between `onTransition` and `onChange`

The `Transition` type contains the `event` property that was the event received by the bloc's stream.
We can easily track the stack of events.

In cubit, the `Change` type only contains the currentState and nextState.

## Demo

https://user-images.githubusercontent.com/36731875/199124353-18de5927-09d9-4e74-8575-cbe61edaad5a.mp4




