import 'package:hive/hive.dart';

part 'id.g.dart';

@HiveType(typeId: 0)
class Id {
  @HiveField(0)
  int id;

  @HiveField(1)
  List block;

  Id(this.id, this.block);
}