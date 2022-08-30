import 'dart:io';
import 'dart:core';
import 'Queue.dart';
import 'stack.dart';
import 'EquatinFormat.dart';
import 'driv.dart';
  void main(){
     print("Hello HAPPY function ,Enter Function:");
     String? equation = stdin.readLineSync();
     List variables =EquatinFormat.variables(equation.toString()).toList();//to list to easy deal with indices
    print("enter 0 to get derivative \u{2207}");
    for(int i=1;i<=variables.length;i++){
      print("enter ${i} to get derivative to ${variables[i-1]}");
    }
    int? entered=int.tryParse(stdin.readLineSync().toString());
    if(entered==0){
      if(variables.contains("x")&&variables.contains("y")&&variables.contains("z")){
        print("<${new driv("x").derivative(equation.toString())},${new driv("y").derivative(equation.toString())},${new driv("z").derivative(equation.toString())}>");
        print("Steps are:");
        print(driv.steps.Show_in_sequence_order());
      }else{
        print("unfortantaley to get napla derivative you should have x,y,z (written small)");
      }
    }else{
      for (int i=1;i<=variables.length;i++){
        if(entered==i){
          print(new driv(variables[i-1]).derivative(equation.toString()));
          print("Steps are:");
          print(driv.steps.Show_in_sequence_order());
        }
      }
    }
    
    }
