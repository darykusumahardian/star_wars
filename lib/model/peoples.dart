String tableName= "users";

class PvPeoplesFields{
  static String name = 'name';
  static String height = 'height';
  static String mass = 'mass';
  static String gender = 'gender';

  static final List<String> values = [
    gender, mass, height, name
  ]; 
}

class Peoples {
  final String? name;
  final int? height;
  final int? mass;
  final String? gender;

  const Peoples({
    required this.gender,
    required this.height,
    required this.name,
    required this.mass,
  });

  Peoples copy({
    String? gender,
    int? height,
    String? name,
    int? mass,
  }) => Peoples(
    name: name ?? this.name,
    height: height ?? this.height,
    mass: mass ?? this.mass,
    gender: gender ?? this.gender,
  );

  static Peoples fromJson(Map<String, Object?> json)=>Peoples(    
    name: json[PvPeoplesFields.name] as String?,
    height: json[PvPeoplesFields.height] as int?,
    mass: json[PvPeoplesFields.mass] as int?,
    gender: json[PvPeoplesFields.gender] as String?,
  );

  Map<String, Object?> toJson()=>{
    PvPeoplesFields.name: name,
    PvPeoplesFields.gender: gender,
    PvPeoplesFields.mass: mass,
    PvPeoplesFields.height: height,
  };
}