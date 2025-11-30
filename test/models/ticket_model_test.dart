import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wimpillay_main/models/ticket_model.dart';

void main() {
  group('TicketModel', () {
    test('should create TicketModel with correct values', () {
      // ARRANGE
      final purchaseDate = Timestamp.now();

      // ACT
      final ticket = TicketModel(
        id: 'test_id_123',
        userId: 'user_123',
        adultCount: 2,
        universityCount: 1,
        schoolCount: 0,
        totalAmount: 2.50,
        purchaseDate: purchaseDate,
        qrCode: 'QR_CODE_123',
        isUsed: false,
        usedAt: null,
      );

      // ASSERT
      expect(ticket.id, equals('test_id_123'));
      expect(ticket.userId, equals('user_123'));
      expect(ticket.adultCount, equals(2));
      expect(ticket.universityCount, equals(1));
      expect(ticket.schoolCount, equals(0));
      expect(ticket.totalAmount, equals(2.50));
      expect(ticket.purchaseDate, equals(purchaseDate));
      expect(ticket.qrCode, equals('QR_CODE_123'));
      expect(ticket.isUsed, equals(false));
      expect(ticket.usedAt, isNull);
    });

    test('should convert to Map correctly', () {
      // ARRANGE
      final purchaseDate = Timestamp.now();
      final ticket = TicketModel(
        id: 'test_id_123',
        userId: 'user_123',
        adultCount: 1,
        universityCount: 0,
        schoolCount: 0,
        totalAmount: 1.0,
        purchaseDate: purchaseDate,
        qrCode: 'QR_TEST',
        isUsed: false,
      );

      // ACT
      final map = ticket.toMap();

      // ASSERT
      expect(map['id'], equals('test_id_123'));
      expect(map['userId'], equals('user_123'));
      expect(map['adultCount'], equals(1));
      expect(map['universityCount'], equals(0));
      expect(map['schoolCount'], equals(0));
      expect(map['totalAmount'], equals(1.0));
      expect(map['purchaseDate'], equals(purchaseDate));
      expect(map['qrCode'], equals('QR_TEST'));
      expect(map['isUsed'], equals(false));
      expect(map['usedAt'], isNull);
    });

    test('should create from Map correctly', () {
      // ARRANGE
      final purchaseDate = Timestamp.now();
      final map = {
        'userId': 'user_456',
        'adultCount': 3,
        'universityCount': 2,
        'schoolCount': 1,
        'totalAmount': 4.50,
        'purchaseDate': purchaseDate,
        'qrCode': 'QR_FROM_MAP',
        'isUsed': true,
        'usedAt': purchaseDate,
      };

      // ACT
      final ticket = TicketModel.fromMap(map, 'document_456');

      // ASSERT
      expect(ticket.id, equals('document_456'));
      expect(ticket.userId, equals('user_456'));
      expect(ticket.adultCount, equals(3));
      expect(ticket.universityCount, equals(2));
      expect(ticket.schoolCount, equals(1));
      expect(ticket.totalAmount, equals(4.50));
      expect(ticket.purchaseDate, equals(purchaseDate));
      expect(ticket.qrCode, equals('QR_FROM_MAP'));
      expect(ticket.isUsed, equals(true));
      expect(ticket.usedAt, equals(purchaseDate));
    });

    test('should handle default values correctly', () {
      // ARRANGE
      final purchaseDate = Timestamp.now();

      // ACT - Crear ticket sin algunos parámetros opcionales
      final ticket = TicketModel(
        userId: 'user_default',
        adultCount: 1,
        universityCount: 0,
        schoolCount: 0,
        totalAmount: 1.0,
        purchaseDate: purchaseDate,
        qrCode: '',
      );

      // ASSERT - Verificar valores por defecto
      expect(ticket.isUsed, equals(false));
      expect(ticket.usedAt, isNull);
    });
  });
}