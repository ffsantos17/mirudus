import 'package:http/http.dart' as http;

const baseUrl = "https://mirudus.000webhostapp.com/";

class API {
  static Future getPlayers() async {
    var url = baseUrl + "players.php";
    return await http.get(Uri.parse(url));
  }

  static Future getSorteios() async {
    var url = baseUrl + "list_sorteios.php";
    return await http.get(Uri.parse(url));
  }

  static Future atualizaPlayers(players) async {

    var url = baseUrl + "atualiza_players.php";
    return await http.post(Uri.parse(url),
      body: {
        "players" : players.toString()
      },
    );
  }

  static Future getPlayerGC(player_Id) async {
    var url = 'https://gamersclub.com.br/api/box/init/' + player_Id;
    return await http.get(Uri.parse(url));
  }

}

class Player{
  String id;
  String name;
  String level;
  String link;
  bool checked;

  Player({required this.id,
    required this.name,
    required this.level,
    required this.link,
    required this.checked
  });

  Player.fromJson(Map json)
      : id = json['id'].toString(),
        name = json['player_nome'].toString(),
        level = json['player_level'].toString(),
        link = json['player_link'].toString(),
        checked = false;
}

class PlayerGC{
  String id;
  String name;
  String level;
  String rating;

  PlayerGC({required this.id,
    required this.name,
    required this.level,
    required this.rating
  });

  PlayerGC.fromJson(Map json)
      : id = json['playerInfo']['id'],
        name = json['playerInfo']['nick'],
        level = json['playerInfo']['level'],
        rating = json['playerInfo']['rating'];
}

class Sorteio{
  String id;
  String time1;
  String time2;
  String media1;
  String media2;
  String date;


  Sorteio({required this.id,
    required this.time1,
    required this.time2,
    required this.media1,
    required this.media2,
    required this.date
  });

  Sorteio.fromJson(Map json)
      : id = json['sorteio_id'].toString(),
        time1 = json['sorteio_time1'].toString(),
        time2 = json['sorteio_time2'].toString(),
        media1 = json['sorteio_mediaTime1'].toString(),
        media2 = json['sorteio_mediaTime2'].toString(),
        date = json['sorteio_horario'].toString();
}
