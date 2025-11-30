import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wimpillay_main/screens/passenger/ticket_screen.dart';
import 'package:wimpillay_main/models/ticket_model.dart';

void main() {
  testWidgets('TicketScreen muestra información básica', (WidgetTester tester) async {
    // ARRANGE
    final mockTicket = TicketModel(
      id: 'test_123',
      userId: 'user_123',
      adultCount: 2,
      universityCount: 1,
      schoolCount: 0,
      totalAmount: 2.50,
      purchaseDate: Timestamp.now(),
      qrCode: 'QR_TEST',
    );

    // ACT
    await tester.pumpWidget(
      MaterialApp(
        home: TicketScreen(ticket: mockTicket),
      ),
    );

    // ASSERT - Solo elementos garantizados
    expect(find.text('Ticket Generado'), findsOneWidget);
    expect(find.text('¡Pago exitoso!'), findsOneWidget);
  });

  testWidgets('TicketScreen muestra botón de volver', (WidgetTester tester) async {
    // ARRANGE
    final mockTicket = TicketModel(
      id: 'test_123',
      userId: 'user_123',
      adultCount: 1,
      universityCount: 0,
      schoolCount: 0,
      totalAmount: 1.0,
      purchaseDate: Timestamp.now(),
      qrCode: 'QR_TEST',
    );

    // ACT
    await tester.pumpWidget(
      MaterialApp(
        home: TicketScreen(ticket: mockTicket),
      ),
    );

    // ASSERT
    expect(find.text('Volver al Inicio'), findsOneWidget);
  });
}