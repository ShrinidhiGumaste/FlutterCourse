class student{
  // Using VAR
  var name = "Jagadeesh";
  var name1 = "Jagadeesh = ";
  var matter=" had ";
  var marks = 90;
  // Using Dynamic Value
  dynamic value="Shinu";
  // Using Constants
  // Using Final
  final currentTime=DateTime.now();
  // Using CONST => Using CONST inside a class must be assigned to static otherwise it will be an Error.
  static const pi=3.14159;
  // NULL-AWARE Operator => It is used to avoid NULL related Errors.
  String? city;
  // LATE keyword => Used to Declare the Values Later.
  // It tells DART the the variable will be Declared Later.
  // It is used when the Value is not available Immediately.
  late String address;
  // FINAL Keyword => final means the variable can be assigned only once.
  // This value is determined at Runtime.
  // After assigning the value it cannot be changed.
  final String laptop='LENOVO i7 8th GEN';
}
void main(){
  // Using CONST => CONST values cannot be changed. CONST inside a method can be declared directly.
  const pi=3.14159;
  const numbers=[1,2,3,4];
  // Object Creation => Objects are Created using Class Constructors.
  // An Object is an Instance of Class.
  student s = student();
  print (s.name);
  s.value=200000;
  print("${s.name}${s.matter}${s.value}");
  print(s.currentTime);
  print(pi);
  // FOR Loop => Used for executing the block of codes Repeatedly.
  for(int i=0 ; i<=5 ; i++){
    print(i);
  }
  // FOR IN Loop => Used for executing the block of codes Repeatedly.
  // WILDCARD(_) => In DART, _ can be used as wildcard, which means that this value is not needed or ignored.
  // It improves Code Readability when some values are not required.
  for(var number in numbers){ // Here (number) is Ignored.
    print(numbers);
    // NULL-AWARE Operator
    print(s.city); // This value will be NULL.
    // LATE keyword
    s.address='Near Hanuman Temple beside Tailoring Shop Udupi';
    print("${s.name1}${s.address}");
    //FINAL Keyword
    print(s.laptop);
  }
}