import 'HapFun.dart';
import 'EquatinFormat.dart';
import 'driv.dart';
class stack{
    stack(){}
  List list=[];
  void push(String s){
    list.add(s);
  }
  String pop(){
    try{
    String popped=list[list.length-1];
     list.remove(list[list.length-1]);
     return popped;
    }catch(Exception){
      print("under flow");
      return "";
    }
  }
  bool isEmpty(){
    return list.length==0;
  }
}