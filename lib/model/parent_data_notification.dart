/*
import 'package:postgres/postgres.dart';

class Parent {
  int? id;
  String? name;
  String? pContact;
  String? sContact;
  String? email;
  String? password;
  DateTime? createdAt;
  String? state;
  String? country;
  String? pincode;
  String? location;
  DateTime? passwordLastModified;

  Parent({
    this.id,
    this.name,
    this.pContact,
    this.sContact,
    this.email,
    this.password,
    this.createdAt,
    this.state,
    this.country,
    this.pincode,
    this.location,
    this.passwordLastModified,
  });

  static Future<List<dynamic>> getParentById(
      PostgreSQLConnection db, int id) async {
    try {
      var result = await db.query(
        'SELECT * FROM parents WHERE id = @id LIMIT 1',
        substitutionValues: {'id': id},
      );

      if (result.isEmpty) {
        return [null, 'NOT_FOUND'];
      }
      return [result.first, null];
    } catch (error) {
      print(error);
      return [null, error];
    }
  }

  static Future<List<dynamic>> getParentByEmail(
      PostgreSQLConnection db, String email) async {
    try {
      var result = await db.query(
        'SELECT * FROM parents WHERE email = @Email LIMIT 1',
        substitutionValues: {'Email': email},
      );

      if (result.isEmpty) {
        return [null, 'NOT_FOUND'];
      }
      return [result.first, null];
    } catch (error) {
      print(error);
      return [null, error];
    }
  }

  static Future<List<dynamic>> getParentByPhone(
      PostgreSQLConnection db, String phone) async {
    try {
      var result = await db.query(
        'SELECT * FROM parents WHERE p_contact = @Phone LIMIT 1',
        substitutionValues: {'Phone': phone},
      );

      if (result.isEmpty) {
        return [null, 'NOT_FOUND'];
      }
      return [result.first, null];
    } catch (error) {
      print(error);
      return [null, error];
    }
  }

  static Future<List<dynamic>> updateParentPassword(
      PostgreSQLConnection db, String email, String newPassword) async {
    try {
      var result = await db.query(
        '''
        UPDATE parents
        SET password = @Password, password_last_modified = NOW()
        WHERE email = @Email
        RETURNING id
        ''',
        substitutionValues: {'Email': email, 'Password': newPassword},
      );

      if (result.isEmpty) {
        return [null, 'NOT_FOUND'];
      }
      return [result.first[0], null];
    } catch (error) {
      print(error);
      return [null, error];
    }
  }

  static Future<List<dynamic>> createParent(
      PostgreSQLConnection db, Map<String, dynamic> data) async {
    try {
      var result = await db.query(
        '''
        INSERT INTO parents (name, p_contact, s_contact, email, password, state, country, pincode, location, created_at)
        VALUES (@name, @p_contact, @s_contact, @Email, @Password, @State, @Country, @Pincode, ST_SetSRID(ST_MakePoint(@Longitude, @Latitude), 4326), NOW())
        RETURNING id
        ''',
        substitutionValues: {
          'name': data['name'],
          'p_contact': data['p_contact'],
          's_contact': data['s_contact'],
          'Email': data['email'],
          'Password': data['password'],
          'State': data['state'],
          'Country': data['country'],
          'Pincode': data['pincode'],
          'Longitude': data['longitude'],
          'Latitude': data['latitude'],
        },
      );

      return [result.first[0], null];
    } catch (error) {
      if (error.toString().contains('duplicate key value')) {
        return [null, 'DUPLICATE'];
      }
      if (error.toString().contains('not-null constraint')) {
        return [null, 'INVALID'];
      }
      print(error);
      return [null, error];
    }
  }

  static Future<List<dynamic>> updateParentLocation(
      PostgreSQLConnection db,
      int id,
      double latitude,
      double longitude,
      Map<String, dynamic> data) async {
    try {
      var result = await db.query(
        '''
        UPDATE parents
        SET location = ST_SetSRID(ST_MakePoint(@Longitude, @Latitude), 4326),
            state = @State,
            country = @Country,
            pincode = @Pincode
        WHERE id = @ID
        RETURNING id
        ''',
        substitutionValues: {
          'ID': id,
          'Longitude': longitude,
          'Latitude': latitude,
          'State': data['state'],
          'Country': data['country'],
          'Pincode': data['pincode'],
        },
      );

      if (result.isEmpty) {
        return [null, 'NOT_FOUND'];
      }
      return [result.first[0], null];
    } catch (error) {
      if (error.toString().contains('ST_SetSRID')) {
        return [null, 'INVALID'];
      }
      print(error);
      return [null, error];
    }
  }
}
*/
