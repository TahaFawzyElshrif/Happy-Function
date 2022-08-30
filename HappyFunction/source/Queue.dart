class Queue{
  List elements=[];
  Queue();
  factory Queue.same(){
    return Queue();
  }
  void enque(String element){
    elements.add(element);
  }
  String deque(){
    String dequed;
    if (!isEmpty()){
      dequed=elements[0];
      elements.removeAt(0);
      return dequed;
    }else{
      throw new Exception("Empty Queue");
    }
  }
  bool isEmpty(){
    return elements.isEmpty;
  }
  String Show_in_sequence_order(){
     String s="";
  int i=0;
  for (var j in elements){
    s=s+"${i} : ${j} \n ";
    i++;
  }
  return s; 
  }
}
void main(){
 
}