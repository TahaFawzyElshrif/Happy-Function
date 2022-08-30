import 'stack.dart';
import 'HapFun.dart';
import 'EquatinFormat.dart';
import 'Queue.dart';
class driv{
  String toVar;
  static Queue steps=new Queue();
  driv(this.toVar);
  
String derivative(String eq){
String deriv="";
if (eq.contains(toVar)){
List required_eq_parts=EquatinFormat.FormatToParts_plus(eq);
int indx=0;//for fencepost with +
for(var i in required_eq_parts){
if (i.contains("*")){
deriv+=_dervMultpliy(i);
}else if (i.contains("/")){
deriv+=_dervDivi(i);
}else if (new RegExp(r"\d*\~sin\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"sin");
}else if (new RegExp(r"\d*\~cos\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"cos");
}else if (new RegExp(r"\d*\~tan\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"tan");
}else if (new RegExp(r"\d*\~cot\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"cot");
}else if (new RegExp(r"\d*\~csc\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"csc");
}else if (new RegExp(r"\d*\~sec\(.*\)").hasMatch(i)){
deriv+=_dervTrangle(i,"sec");
}else if (new RegExp(r"\d*\~\d*\^\(.*\)").hasMatch(i)){
deriv+=_dervPow(i);
}else if(new RegExp(r"[\d]*log[\d]*[\(].*[\)]").hasMatch(i)){
deriv+=_dervLog(i);
}else if (new RegExp(r"[\d]*[\(]?"+toVar+"[\)]?[\^]?[\d]*").hasMatch(i)){
deriv+=_dervPoly(i);
}else{
  deriv+=_dervConst(eq);
} 
  if(indx!=required_eq_parts.length-1){
  deriv+=" + ";
  }
  indx++;
}
}
return deriv;
}
String _dervMultpliy(String eq){
String s="";
List multi_parts=EquatinFormat.FormatToParts_multiply(eq);
steps.enque("${multi_parts[0]}  ,   ${(multi_parts[1])} are multiplied");
s="((${multi_parts[0]})*(${derivative(multi_parts[1])}))+((${multi_parts[1]})*(${derivative(multi_parts[0])}))";
return s;
}
String _dervDivi(String eq){
String s="";
List divi_parts=EquatinFormat.FormatToParts_division(eq);
steps.enque("${divi_parts[0]}  ,   ${derivative(divi_parts[1])} are divied");

//multi_parts[0]:first part of division
//multi_parts[1]:second part of division
s="(((${divi_parts[1]})*(${derivative(divi_parts[0])}))-((${divi_parts[0]})*(${derivative(divi_parts[1])})))/((${derivative(divi_parts[1])})^2)";
return s;
}
String _dervConst(String eq){
steps.enque("${eq} is const as not contains ${toVar}");
return " ";
}
String _dervPoly(String eq){
  //in form Ax^B or A(....)^B regex:[\d]*[\(]?x[\)]?[\^]?[\d]*  ,very important to put ^ although it pass
  var s="";
  String factor=(eq.contains("("))?eq.substring(0,eq.indexOf("(")):eq.substring(0,eq.indexOf(toVar));
  String power=(eq.contains("("))?eq.substring(eq.indexOf(")")+2):eq.substring(eq.indexOf("^")+1);
  num factor_int=(num.tryParse(factor)==null)?1:(num.parse(factor));
  num power_int=(num.tryParse(power)==null)?1:(num.parse(power));
  String inner_Fun=(eq.contains("("))?eq.substring(eq.indexOf("(")+1,eq.indexOf(")")):"x";//" " for not be in infinite loop
  String derv_inner_fun=inner_Fun==toVar?toVar:derivative(inner_Fun);
  steps.enque("${eq} is polynimoal function");
  s= "(${(factor_int*power_int)}(${inner_Fun})^${num.parse(power)-1})*(${derv_inner_fun})";
  return s;
}
String _dervLog(String eq){
  //AlogB(...) regex: [\d]*log[\d]*[\(].*[\)]
String s="";
int indx_log=eq.indexOf("log");
String factor=eq.substring(0,indx_log);
String base=eq.substring(indx_log+3,eq.indexOf("(",indx_log));
String inner_fun=eq.substring(eq.indexOf("(",indx_log)+1,eq.lastIndexOf(")"));
String derv_inner_fun=inner_fun==toVar?toVar:derivative(inner_fun);
num factor_num=(num.tryParse(factor)==null)?1:(num.parse(factor));
num logDeg_num=(num.tryParse(base)==null)?10:(num.parse(base));
steps.enque("${eq} is logarithmeic function");
s=" ((${factor_num}/x)*log${logDeg_num}(e)*(${derv_inner_fun})) ";

return s;
}

String _dervPow(String eq){
  // in from A*B^(....) regex: \d*\*\d*\^\(.*\) 
  String s="";
  String factor=eq.substring(0,eq.indexOf("*"));
  String B=eq.substring(eq.indexOf("*")+1,eq.indexOf("^"));
  String inner_fun=eq.substring(eq.indexOf("(")+1,eq.indexOf(")"));
//  num factor_num=(num.tryParse(factor)==null)?1:(num.parse(factor));
  //num B_num=(num.tryParse(B)==null)?1:(num.parse(B));
  String derv_inner_fun=inner_fun==toVar?toVar:derivative(inner_fun);

  steps.enque("${eq} is powered-function");

  s="(${eq}.ln(${B})*${derv_inner_fun})";
  return s;
}
String _dervTrangle(String eq,String kind){
  String s="";
  String factor=eq.substring(0,eq.indexOf("~"));
  String inner_fun=eq.substring(eq.indexOf("(")+1,eq.indexOf(")"));
  String derv_inner_fun=inner_fun==toVar?toVar:derivative(inner_fun);

  //num factor_num=(num.tryParse(factor)==null)?1:(num.parse(factor));
  steps.enque("${eq} is Trinagular function (${kind})");//very imp:this line should be here to show steps in order before calling
  //derivative of inner function
  switch(kind){
  case "sin":{
  s="${factor}.cos(${inner_fun})*${derv_inner_fun}";
  break;
  }
  case "cos":{
  s="-${factor}.sin(${inner_fun})*${derv_inner_fun}";
  break;
  }
  case "tan":{
  s="${factor}.sec^2(${inner_fun})*${derv_inner_fun}";
  break;
  }
  case "sec":{
  s="${factor}.sec(${inner_fun}).tan(${inner_fun})*${derv_inner_fun}";
  break;
  }
  case "csc":{
  s="-${factor}.csc(${inner_fun}).cot(${inner_fun})*${derv_inner_fun}";
  break;
  }
  case "cot":{
  s="-${factor}.csc^2(${inner_fun})*${derv_inner_fun}";
  break;
  }
  }

  return s;
}

}