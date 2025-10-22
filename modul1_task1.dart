class Pet {
  String? breed;

  Pet._(this.breed);

  static final Map<String, Pet> _cache = {};

  factory Pet(String breed) {
    if (_cache.containsKey(breed)) {
      return _cache[breed]!; 
    } else {
      final pet = Pet._(breed);
      _cache[breed] = pet;
      return pet;
    }
  }
}

void main(){
  final pet1 = Pet('dog');
  final pet2 = Pet('cat');
  final pet3 = Pet('dog');
}

