class PokemonImagesRepository {
  List<String> pokemonImages = [
    'abomasnow.png',
    'abra.png',
    'absol.png',
    'accelgor.png',
    'aegislash-shield.png',
    'aerodactyl.png',
    'aggron.png',
    'alakazam.png',
    'alcremie.png',
    'altaria.png',
    'amaura.png',
    'ambipom.png',
    'ampharos.png',
    'anorith.png',
    'appletun.png',
    'applin.png',
    'araquanid.png',
    'arbok.png',
    'arcanine.png',
    'archen.png'
  ];

  List<String> getImages(int count) {
    assert(count % 2 == 0, count != 0);
    pokemonImages.shuffle();

    var images = pokemonImages
        .take((count ~/ 2))
        .expand((element) => [element, element])
        .toList();

    images.shuffle();
    return images;
  }
}
