import 'package:flutter/material.dart';

class recordatorio extends StatelessWidget {
  final String recordatorio_texto;
  const recordatorio({
    Key? key,
    required this.recordatorio_texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shadowColor: Colors.orange,
      elevation: 20,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.info,
            color: Colors.greenAccent,
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  recordatorio_texto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
