// use nullable value if it is not null
bool isEmpty1(String? string) {
  print(string?.length);
  return string?.length == 0;
}

// safe unwrap nullable value
bool isEmpty2(String? string) {
  if (string != null) {
    print(string.length);
    return string.length == 0;
  }
  return false;
}

// force unwrap nullable value
bool isEmpty3(String? string) {
  return string!.length == 0;
}

main() {
  print(isEmpty1(null));
  print(isEmpty2(null));
  print(isEmpty3(null));
}
