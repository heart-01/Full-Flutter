import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // Text และ Icon เป็น Button
          TextButton.icon(
            onPressed: (){}, 
            icon: const Icon(
              Icons.help, 
              color: Colors.white,
            ), 
            label: const Text(
              "ช่วยเหลือ",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 16.0,
                fontFamily: 'NotoSansThai',
              ),
            ),
          ),

          // Icon เป็น Button
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.help, color: Colors.white),
          ),

          // Text เป็น Button
          TextButton(
            onPressed: (){}, 
            child: const Text(
              'ช่วยเหลือ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'NotoSansThai',
              ),
            ),
          ),

          const Text('|', style: TextStyle(color: Colors.white),),

          TextButton(
            onPressed: (){}, 
            child: const Text(
              'ภาษาไทย',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'NotoSansThai',
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}