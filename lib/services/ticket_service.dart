import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wimpillay_main/models/ticket_model.dart';
import 'package:wimpillay_main/services/firebase_service.dart';

class TicketService {
  final FirebaseService? _firebaseService;

  // Constructor por defecto (usa FirebaseService real)
  TicketService() : _firebaseService = FirebaseService();

  // Constructor para testing (sin Firebase)
  TicketService.forTesting() : _firebaseService = null;

  Future<TicketModel> createTicket({
    required String userId,
    required int adultCount,
    required int universityCount,
    required int schoolCount,
    required double totalAmount,
  }) async {
    // Si estamos en modo test, simular respuesta
    if (_firebaseService == null) {
      return TicketModel(
        id: 'test_ticket_id',
        userId: userId,
        adultCount: adultCount,
        universityCount: universityCount,
        schoolCount: schoolCount,
        totalAmount: totalAmount,
        purchaseDate: Timestamp.now(),
        qrCode: 'QR_TEST_DATA',
        isUsed: false,
        usedAt: null,
      );
    }

    final ticket = TicketModel(
      userId: userId,
      adultCount: adultCount,
      universityCount: universityCount,
      schoolCount: schoolCount,
      totalAmount: totalAmount,
      purchaseDate: Timestamp.now(),
      qrCode: '', // Se genera y actualiza en FirebaseService
      isUsed: false,
      usedAt: null,
    );

    return await _firebaseService!.saveTicket(ticket);
  }

  // Método auxiliar para lógica de negocio (NO depende de Firebase)
  double calculateTotal({
    required int adultCount,
    required int universityCount,
    required int schoolCount,
  }) {
    const double adultPrice = 1.0;
    const double universityPrice = 0.5;
    const double schoolPrice = 0.5;

    return (adultCount * adultPrice) +
           (universityCount * universityPrice) +
           (schoolCount * schoolPrice);
  }
}