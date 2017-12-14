import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/models/talent.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as table;

class Hero {
  final int heroes_companion_hero_id;
  final int hero_id;
  final String name;
  final String short_name;
  final String attribute_id;
  final String icon_file_name;
  final String role;
  final String type;
  final DateTime release_date;
  List<Talent> talents;
  List<Ability> abilities;
  bool is_owned = false;
  bool is_favorite = false;

  Hero(this.heroes_companion_hero_id, this.hero_id, this.name, this.short_name, this.attribute_id, this.icon_file_name, this.role, this.type, this.release_date, this.is_owned, this.is_favorite, {this.talents, this.abilities});

  factory Hero.fromMap (Map map){
    int heroes_companion_hero_id = map[table.column_heroes_companion_hero_id];
    int hero_id = map[table.column_hero_id];
    String name = map[table.column_name];
    String short_name = map[table.column_short_name];
    String attribute_id = map[table.column_attribute_id];
    String hero_icon_file_name = map[table.column_icon_file_name];
    String role = map[table.column_role];
    String type = map[table.column_type];
    DateTime release_date = DateTime.parse(map[table.column_release_date]);
    bool is_owned = map[table.column_is_owned] == 1;
    bool is_favorite = map[table.column_is_favorite] == 1;
    return new Hero(heroes_companion_hero_id, hero_id, name, short_name, attribute_id, hero_icon_file_name, role, type, release_date, is_owned, is_favorite);
  }

  Map toMap() {
    Map map = {
      table.column_heroes_companion_hero_id: heroes_companion_hero_id,
      table.column_hero_id: hero_id,
      table.column_name: name,
      table.column_short_name: short_name,
      table.column_attribute_id: attribute_id,
      table.column_icon_file_name: icon_file_name,
      table.column_role: role,
      table.column_type: type,
      table.column_release_date: release_date.toIso8601String(),
      table.column_is_owned: is_owned == true ? 1 : 0,
      table.column_is_favorite: is_favorite == true ? 1 : 0
    };
    return map;
  }
  
 Hero copyWith({int heroes_companion_hero_id, int hero_id, String name, String short_name, String attribute_id, String icon_file_name, String role, String type, DateTime release_date, bool is_owned, bool is_favorite, List<Talent> talents, List<Ability> abilities}) {
    return new Hero(
      heroes_companion_hero_id = heroes_companion_hero_id ?? this.heroes_companion_hero_id,
      hero_id = hero_id ?? this.hero_id,
      name = name ?? this.name,
      short_name = short_name ?? this.short_name,
      attribute_id = attribute_id ?? this.attribute_id,
      icon_file_name = icon_file_name ?? this.icon_file_name,
      role = role ?? this.role,
      type = type ?? this.type,
      release_date = release_date ?? this.release_date,
      is_owned = is_owned ?? this.is_owned,
      is_favorite = is_favorite ?? this.is_favorite,
      talents: talents ?? this.talents,
      abilities: abilities ?? this.abilities,
    );
  }

  @override
  String toString(){
    return "${name}";
  }
}