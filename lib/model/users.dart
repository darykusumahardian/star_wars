String tableName= "users";

class PvUserFields{
  static String id = 'id';
  static String email = 'email';
  static String name = 'name';

  static final List<String> values = [
    id, email, name
  ]; 
}

class Users {

  final String? id;
  final String? email;
  final String? name;

  const Users({
    required this.id,
    required this.email,
    required this.name,
  });

  Users copy({
    String? id,
    String? email,
    String? name,
  }) => Users(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
  );

  static Users fromJson(Map<String, Object?> json)=>Users(    
    id: json[PvUserFields.id] as String?,
    email: json[PvUserFields.email] as String?,
    name: json[PvUserFields.name] as String?,
  );

  Map<String, Object?> toJson()=>{
    PvUserFields.id: id,
    PvUserFields.email: email,
    PvUserFields.name: name,
  };
}