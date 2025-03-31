import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/main.dart';

void main(){
  group('Iseven Group',(){
    test('Is Even',(){
      bool result = isEven(12);
        expect(result, true);
      });
    
    test( 'Is Odd',(){
      bool result = isEven(123);
        expect(result, false);
    }); 
  });

}