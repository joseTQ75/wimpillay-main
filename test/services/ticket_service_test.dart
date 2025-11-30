import 'package:flutter_test/flutter_test.dart';
import 'package:wimpillay_main/services/ticket_service.dart';

void main() {
  group('TicketService - Logic Tests', () {
    late TicketService ticketService;

    setUp(() {
      // Usar el constructor de testing que NO inicializa Firebase
      ticketService = TicketService.forTesting();
    });

    test('calculateTotal returns correct amount for adults only', () {
      // ARRANGE
      final adultCount = 2;
      final universityCount = 0;
      final schoolCount = 0;

      // ACT
      final total = ticketService.calculateTotal(
        adultCount: adultCount,
        universityCount: universityCount,
        schoolCount: schoolCount,
      );

      // ASSERT
      expect(total, equals(2.0)); // 2 adultos * 1.0 = 2.0
    });

    test('calculateTotal returns correct amount for mixed passengers', () {
      // ARRANGE
      final adultCount = 1;
      final universityCount = 2;
      final schoolCount = 1;

      // ACT
      final total = ticketService.calculateTotal(
        adultCount: adultCount,
        universityCount: universityCount,
        schoolCount: schoolCount,
      );

      // ASSERT
      expect(total, equals(2.5)); // 1*1.0 + 2*0.5 + 1*0.5 = 2.5
    });

    test('calculateTotal returns zero when all counts are zero', () {
      // ARRANGE
      final adultCount = 0;
      final universityCount = 0;
      final schoolCount = 0;

      // ACT
      final total = ticketService.calculateTotal(
        adultCount: adultCount,
        universityCount: universityCount,
        schoolCount: schoolCount,
      );

      // ASSERT
      expect(total, equals(0.0));
    });

    test('TicketService instance is created successfully', () {
      // ACT & ASSERT
      expect(ticketService, isNotNull);
      expect(ticketService, isA<TicketService>());
    });

    test('createTicket returns mock ticket in test mode', () async {
      // ARRANGE
      final userId = 'test_user_123';
      final adultCount = 2;
      final universityCount = 1;
      final schoolCount = 0;

      // ACT
      final ticket = await ticketService.createTicket(
        userId: userId,
        adultCount: adultCount,
        universityCount: universityCount,
        schoolCount: schoolCount,
        totalAmount: 2.5,
      );

      // ASSERT
      expect(ticket, isNotNull);
      expect(ticket.userId, equals(userId));
      expect(ticket.adultCount, equals(adultCount));
      expect(ticket.universityCount, equals(universityCount));
      expect(ticket.totalAmount, equals(2.5));
      expect(ticket.id, equals('test_ticket_id'));
    });
  });
}