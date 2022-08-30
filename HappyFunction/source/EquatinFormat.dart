import 'stack.dart';
import 'driv.dart';
import 'HapFun.dart';

class EquatinFormat {
  EquatinFormat();

  static Set illegal_chars = {"+", "-", "*", "/", "(", ")", "^","~"," "};
  static Set _vars = {};

  static Set variables(String eq) {
    if (new RegExp(r".*log.*\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("log")) +
          1); //after,what between ( and log is certainly number so igroned
      String tmp2 = eq.substring(0, eq.indexOf("log")); //before
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*sin\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("sin")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("sin"));
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*cos\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("cos")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("cos"));
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*tan\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("tan")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("tan"));
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*sec\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("sec")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("sec"));
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*cot\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("cot")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("cot"));
      variables(tmp);
      variables(tmp2);
    } else if (new RegExp(r".*csc\(.*\)").hasMatch(eq)) {
      String tmp = eq.substring(eq.indexOf("(", eq.indexOf("csc")) + 1);
      String tmp2 = eq.substring(0, eq.indexOf("csc"));
      variables(tmp);
      variables(tmp2);
    } else {
      for (var i = 0; i < eq.length; i++) {
        if (!illegal_chars.contains(eq[i]) &&
            (!new RegExp(r"\d").hasMatch(eq[i]))) {
          _vars.add(eq[i]);
        }
      }
    }

    return _vars;
  }

  static List FormatToParts_plus(String eq) {
    //--------------------------every part/unit should be in ()
    List F_Units_List = [];
    int i = 0;
    {
      stack Brackets = new stack();
      for (; i < eq.length; i++) {
        if (eq[i] == "(") {
          Brackets.push(eq[i]);
        } else if (eq[i] == ")") {
          Brackets.pop();
          if (Brackets.isEmpty()) {
            break;
          }
        }
      }
    }
    String one_unit =
        eq.indexOf("+", i) == -1 ? eq : (eq.substring(0, eq.indexOf("+", i)));
    F_Units_List.add(_rmve_unness_brckt(one_unit));
    eq = (one_unit == eq) ? "" : eq.replaceFirst(one_unit + "+", "");
    if (eq.length != 0) {
      F_Units_List.add(FormatToParts_plus(eq)
          .toString()
          .substring(1, FormatToParts_plus(eq).toString().length - 1));
    }

    return F_Units_List;
  }

  static List FormatToParts_multiply(String eq) {
    List F_Units_List = [];
  eq="(${eq})";
    int i = 0;
    stack Brackets = new stack();
    for (; i <eq.length; i++) {
      if (eq[i] == "(") {
        Brackets.push(eq[i]);
      } else if (eq[i] == ")") {
        Brackets.pop();
        if (Brackets.isEmpty()) {
          break;
        }
      }
    }

    String first_part=eq.substring(1,i);//to get all brachets
     String second_part=eq.substring(i+2);//to get all brackets after *
    F_Units_List.add(_rmve_unness_brckt(first_part));
    F_Units_List.add(_rmve_unness_brckt(second_part));
    return F_Units_List;
  }

  static List FormatToParts_division(String eq) {
    List F_Units_List = [];
  eq="(${eq})";
    int i = 0;
    stack Brackets = new stack();
    for (; i <eq.length; i++) {
      if (eq[i] == "(") {
        Brackets.push(eq[i]);
      } else if (eq[i] == ")") {
        Brackets.pop();
        if (Brackets.isEmpty()) {
          break;
        }
      }
    }

    String first_part=eq.substring(1,i);//to get all brachets
     String second_part=eq.substring(i+2);//to get all brackets after /
    F_Units_List.add(_rmve_unness_brckt(first_part));
    F_Units_List.add(_rmve_unness_brckt(second_part));
    return F_Units_List;
  }

  static String _rmve_unness_brckt(String txt) {
//may have probems like (x)+log(x)
    int i = 0;
    for (; i < txt.length / 2; i++) {
      if (txt[i] != "\(") {
        break;
      }
    }
    txt = txt.substring(i, txt.length - i);
    return txt;
  }
}
