library calzone.test.a;

import "dart:async";
import "dart:collection";

@MirrorsUsed(
    targets: const [
  "calzone.test.a",
  "calzone.test.b",
  "dart.async.Completer",
  "dart.async.Future",
  "dart.collection.LinkedHashMap"
])
import "dart:mirrors";

import "test.b.dart";

part "test.a.part.dart";

class Stub {
  final LinkedHashMap map;

  Stub(this.map);

  getKeys() {
    return map.keys;
  }

  getValues() {
    return map.values;
  }
}

class CollectionsTest {
  // same as getList
  List list;

  // same as getMap
  Map<String, List> map;

  CollectionsTest(this.list, this.map);

  List getList() {
    return ["a", "b", {"a": 1, "b": 2}];
  }

  Map getMap() {
    return {
      "a": [1, {
          "c": 3,
          "d": 4
        }],
      "b": 2
    };
  }

  bool verifyList() {
    if(list[0] == "a"
        && list[1] == "b"
        && list[2] is Map
        && list[2].containsKey("a")
        && list[2]["a"] == 1
        && list[2].containsKey("b")
        && list[2]["b"] == 2)
      return true;
    return false;
  }

  bool verifyMap() {
    if(map.containsKey("a")
        && map["a"] is List
        && map["a"][0] == 1
        && map["a"][1] is Map
        && map["a"][1].containsKey("c")
        && map["a"][1]["c"] == 3
        && map["a"][1].containsKey("d")
        && map["a"][1]["d"] == 4
        && map.containsKey("b")
        && map["b"] == 2)
      return true;
    return false;
  }
}

class PromiseTest {
  Future future;

  PromiseTest(this.future);

  Future getFuture() =>
    future.then((_) {});
}

class A extends B {
  static final String stat = "Hello World!";
  static final String _stat = "Hello World!";
}

class B extends C {
  c() {
  }

  d(String hello, hello2, {String hi, String string: "Hello World!", bool boolean: false, num number: 2.55}) {
  }

  e([Map map = const {"1": 1, "2": 2, "3": 3}, List list = const [1, 2, 3]]) {
  }
}

main(List<String> args) {
  var a = new Symbol(args.length.toString());

  reflectClass(a).getField(a);
  reflectClass(a).invoke(a, []);
  currentMirrorSystem().findLibrary(a).getField(a);
}
