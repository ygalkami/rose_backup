/*  This is where you define the structs needed to 
    solve this problem.  You can define constants, global
    variables, and function signatures here as well. 
    By David Pick, 11/3/08
*/

struct Inventory {
  int number;
  int quantity; 
  float price;
  struct {
    int month;
    int year;
  } Date;
};