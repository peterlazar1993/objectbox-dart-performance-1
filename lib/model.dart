import 'package:objectbox/objectbox.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart' as isar;

part 'model.g.dart';

@isar.Collection()
@Entity()
@HiveType(typeId: 1)
class TestEntity {
  @HiveField(0)
  int id;

  @HiveField(1)
  String tString;

  @Property(type: PropertyType.int)
  @HiveField(2)
  int tInt; // 32-bit

  @HiveField(3)
  int tLong; // 64-bit

  @HiveField(4)
  double tDouble;

  TestEntity(this.id, this.tString, this.tInt, this.tLong, this.tDouble);

  TestEntity.forIsar()
      : id = 0,
        tString = '',
        tInt = 0,
        tLong = 0,
        tDouble = 0;

  static Map<String, dynamic> toMap(TestEntity object) => <String, dynamic>{
        'id': object.id == 0 ? null : object.id,
        'tString': object.tString,
        'tInt': object.tInt,
        'tLong': object.tLong,
        'tDouble': object.tDouble
      };

  static TestEntity fromMap(Map<String, dynamic> map) => TestEntity(
      map['id'] ?? 0,
      map['tString'],
      map['tInt'],
      map['tLong'],
      map['tDouble']);
}

// A separate entity for queried data so that indexes don't change CRUD results.
@isar.Collection()
@Entity()
@HiveType(typeId: 2)
class TestEntityIndexed {
  @HiveField(0)
  int id;

  @isar.Index()
  @Index()
  @HiveField(1)
  String tString;

  TestEntityIndexed(this.id, this.tString);

  TestEntityIndexed.forIsar()
      : id = 0,
        tString = '';

  static Map<String, dynamic> toMap(TestEntityIndexed object) =>
      <String, dynamic>{
        'id': object.id == 0 ? null : object.id,
        'tString': object.tString,
      };

  static TestEntityIndexed fromMap(Map<String, dynamic> map) =>
      TestEntityIndexed(map['id'] ?? 0, map['tString']);
}
