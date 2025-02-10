import 'dart:io';


void calculate() {
   stdout.writeln('Type something');
  final input = stdin.readLineSync();
  stdout.writeln('You typed: $input');
}
