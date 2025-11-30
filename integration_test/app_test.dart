import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Pasajeros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PassengerCounterScreen(),
    );
  }
}

class PassengerCounterScreen extends StatefulWidget {
  @override
  _PassengerCounterScreenState createState() => _PassengerCounterScreenState();
}

class _PassengerCounterScreenState extends State<PassengerCounterScreen> {
  int adultosCount = 0;
  int universitariosCount = 0;
  int escolaresCount = 0;

  double calcularTotal() {
    return (adultosCount * 1.00) + 
           (universitariosCount * 0.75) + 
           (escolaresCount * 0.50);
  }

  Widget buildPassengerCounter(String title, String price, int count, Function() onIncrement, Function() onDecrement) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                '\$$price',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                onPressed: onDecrement,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.green),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Pasajeros'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona la cantidad de pasajeros:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 20),
            
            // Contadores de pasajeros
            buildPassengerCounter('Adultos', '1.00', adultosCount, 
              () {
                setState(() {
                  adultosCount++;
                });
              },
              () {
                setState(() {
                  if (adultosCount > 0) adultosCount--;
                });
              },
            ),
            
            buildPassengerCounter('Universitarios', '0.75', universitariosCount, 
              () {
                setState(() {
                  universitariosCount++;
                });
              },
              () {
                setState(() {
                  if (universitariosCount > 0) universitariosCount--;
                });
              },
            ),
            
            buildPassengerCounter('Escolares', '0.50', escolaresCount, 
              () {
                setState(() {
                  escolaresCount++;
                });
              },
              () {
                setState(() {
                  if (escolaresCount > 0) escolaresCount--;
                });
              },
            ),
            
            SizedBox(height: 30),
            
            // Total
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'RESUMEN DE PAGO',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Adultos:'),
                      Text('$adultosCount x \$1.00 = \$${(adultosCount * 1.00).toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Universitarios:'),
                      Text('$universitariosCount x \$0.75 = \$${(universitariosCount * 0.75).toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Escolares:'),
                      Text('$escolaresCount x \$0.50 = \$${(escolaresCount * 0.50).toStringAsFixed(2)}'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.blue[300]),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      Text(
                        '\$${calcularTotal().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Botón de pago
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica de pago
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Pago realizado'),
                      content: Text('Total pagado: \$${calcularTotal().toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              adultosCount = 0;
                              universitariosCount = 0;
                              escolaresCount = 0;
                            });
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'REALIZAR PAGO',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}