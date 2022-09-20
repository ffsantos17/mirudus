import 'package:http/http.dart' as http;

// A URL da API
const baseUrl = "https://mirudus.000webhostapp.com/";

// Criamos a classe da nossa API. O nome você que escolhe. Fazemos aqui
// uma requisição get (como fizemos no react) e passamos a URL, mas usamos
// um Uri.parse pra transformar a string em uma URI.
class API {
  static Future getPlayers() async {
    var url = baseUrl + "players.php";
    return await http.get(Uri.parse(url));
  }
}

class Player{
  String id;
  String name;
  String level;
  bool checked;

  Player({required this.id,
    required this.name,
    required this.level,
    required this.checked
  });

  Player.fromJson(Map json)
      : id = json['id'],
        name = json['player_nome'],
        level = json['player_level'],
        checked = false;
}


/*
// A URL da API
const baseUrl = "https://api.tvmaze.com/search/shows?q=";
// Criamos a classe da nossa API. O nome você que escolhe. Fazemos aqui
// uma requisição get (como fizemos no react) e passamos a URL, mas usamos
// um Uri.parse pra transformar a string em uma URI.
class API {
  static Future getMovie(search) async {
    var url = baseUrl + search;
    return await http.get(Uri.parse(url));
  }
}
// Criamos uma classe para representar os objetos que vão conter os filmes
// e colocamos só os campos que vamos usar.
class Movie {
  int id;
  String name;
  String link;
  String image;
  bool checked;
  Movie({required this.id, required this.name, required this.link, required this.image, required this.checked});
  Movie.fromJson(Map json)
      : id = json['show']['id'],
        name = json['show']['name'],
        link = json['show']['url'],
        image = json['show']['image']['medium'],
        checked = false;
}
 */