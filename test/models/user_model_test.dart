import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wimpillay_main/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create UserModel with correct values', () {
      // ARRANGE
      final createdAt = DateTime.now();

      // ACT
      final user = UserModel(
        uid: 'user_123',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        createdAt: createdAt,
        role: 'passenger',
      );

      // ASSERT
      expect(user.uid, equals('user_123'));
      expect(user.email, equals('test@example.com'));
      expect(user.name, equals('Test User'));
      expect(user.photoUrl, equals('https://example.com/photo.jpg'));
      expect(user.createdAt, equals(createdAt));
      expect(user.role, equals('passenger'));
    });

    test('should convert to Map correctly', () {
      // ARRANGE
      final createdAt = DateTime.now();
      final user = UserModel(
        uid: 'user_456',
        email: 'user@test.com',
        name: 'John Doe',
        photoUrl: null,
        createdAt: createdAt,
        role: 'driver',
      );

      // ACT
      final map = user.toMap();

      // ASSERT
      expect(map['uid'], equals('user_456'));
      expect(map['email'], equals('user@test.com'));
      expect(map['name'], equals('John Doe'));
      expect(map['photoUrl'], isNull);
      expect(map['createdAt'], isA<Timestamp>());
      expect(map['role'], equals('driver'));
    });

    test('should create from Map correctly', () {
      // ARRANGE
      final timestamp = Timestamp.now();
      final map = {
        'uid': 'user_789',
        'email': 'from@map.com',
        'name': 'Map User',
        'photoUrl': 'https://map.com/photo.jpg',
        'createdAt': timestamp,
        'role': 'admin',
      };

      // ACT
      final user = UserModel.fromMap(map);

      // ASSERT
      expect(user.uid, equals('user_789'));
      expect(user.email, equals('from@map.com'));
      expect(user.name, equals('Map User'));
      expect(user.photoUrl, equals('https://map.com/photo.jpg'));
      expect(user.createdAt, equals(timestamp.toDate()));
      expect(user.role, equals('admin'));
    });

    test('should use default role when not provided', () {
      // ARRANGE
      final timestamp = Timestamp.now();
      final map = {
        'uid': 'user_default',
        'email': 'default@test.com',
        'name': 'Default User',
        'createdAt': timestamp,
        // role no está incluido
      };

      // ACT
      final user = UserModel.fromMap(map);

      // ASSERT
      expect(user.role, equals('passenger')); // Valor por defecto
    });
  });
}