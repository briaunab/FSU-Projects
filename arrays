/* Name: Briauna Brown
Date: 03/24/17
Section: 07
Assignment: 5
Due Date: 03/24/17
About this project: Creating several functions that will ffill an array
with random numbers, delete and insert elements, reverse an array and find
the max even number. Then the program will print the results to the
screen.
Assumptions: Assume that there will always be an even number, that the
user will fill the array at least once, and that no char will be used as
an input for the array (index or value). Also for the menu, it is assumed
that the user will use Capital letters only.
All work below was performed by Briauna Brown */
#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;
/*Given Function prototypes*/
void PrintArray(const int arr[], const int size);
/* Add your own function prototypes here */
//Fill Array function - fills array with a range of random numbers
void fillArray(int arr[], int SIZE, int min, int max);
//Insert Array function - inserts new value into the arrat at tge
specified index
void insert(int arr[], int SIZE, int newValue, int index);
//Delete Array - deletes a value at a given index
void deleteArray(int arr[], int SIZE, int index);
//Reverse Array function - reverses the order of the array's contents
void reverse(int arr[], int SIZE);
//Largest Even Number function - looks at arrays and determines the max
even number
int maxEven(const int arr[], const int SIZE);
//Main function
int main()
{
/* We'll set the test size to 15. Use this constant in your calls
* instead of the literal 15. Then, by changing this line, you can
* easily test arrays of different sizes. */
const int SIZE = 15;
/* Declare your array of size SIZE*/
int arr [SIZE];
char menuSelection;
int min;
int max;
int maximumValue;
int newValue;
int index;
/*Loop that presents user with menu options and calls appropriate
Array functions*/
/*Note: you can assume the user will call Fill Array function first
so that the array has data in it to begin*/
cout << "\t\t ** Given Features ** \t\t" << endl;
cout << "P \t\t Print the array contents \t\t" << endl;
cout << " " << endl;
cout << "\t\t ** Function Tests ** \t\t " << endl;
cout << "F \t\t Fill the array with random values \t\t" << endl;
cout << "I \t\t Insert \t\t" << endl;
cout << "D \t\t Delete \t\t" << endl;
cout << "R \t\t Reverse \t\t" << endl;
cout << "X \t\t Max Even Value \t\t" << endl;
cout << " " << endl;
cout << " " << endl;
cout << "M \t\t Print this menu \t\t" << endl;
cout << "Q \t\t Quit this program \t\t" << endl;
//Do While Loop Start
do {
cout << "Enter your menu selection: " <<
endl;
cin >> menuSelection;
//Switch Statement for Menu Selection
switch (menuSelection)
{
case 'P' :
PrintArray(arr , SIZE);
break;
case 'F' :
//Ask for Min and Max Values
cout << "What is your minimum value?"
<< endl;
cin >> min;
cout << "What is your maximum value?"
<< endl;
cin >> max;
srand((unsigned int)time(0));
fillArray(arr , SIZE, min, max);
PrintArray(arr, SIZE);
break;
case 'I':
//Prompt user for index value
cout << "Enter the value to insert:
\n";
cin >> newValue;
//Prompt user for index
cout << "Enter index at which to
insert: \n";
cin >> index;
//Call Insert, Print Functions
insert(arr, SIZE, newValue, index);
PrintArray(arr, SIZE);
break;
case 'D':
//Prompt user for index to delete
cout << "Enter index of item to delete:
\n";
cin >> index;
//Call Delete, Print Functions
deleteArray(arr, SIZE, index);
PrintArray(arr, SIZE);
break;
case 'R':
//Call Reverse, Print Functions
reverse(arr, SIZE);
PrintArray(arr, SIZE);
break;
case 'X':
//Set maximumValue to equal maxEven
Array
maximumValue = maxEven(arr, SIZE);
//Print Maximum Even value
cout << "The maximum even value is " <<
maximumValue << "\n";
break;
case 'M':
//Print Menu
cout << "\t\t ** Given Features **
\t\t" << endl;
cout << "P \t\t Print the array
contents \t\t" << endl;
cout << " " << endl;
cout << "\t\t ** Function Tests ** \t\t
" << endl;
cout << "F \t\t Fill the array with
random values \t\t" << endl;
cout << "I \t\t Insert \t\t" << endl;
cout << "D \t\t Delete \t\t" << endl;
cout << "R \t\t Reverse \t\t" << endl;
cout << "X \t\t Max Even Value \t\t" <<
endl;
cout << " " << endl;
cout << " " << endl;
cout << "M \t\t Print this menu \t\t"
<< endl;
cout << "Q \t\t Quit this program \t\t"
<< endl;
break;
case 'Q':
//Call Print Function and quit
PrintArray(arr, SIZE);
break;
default:
cout << "Error! Invalid menu
selection." << endl;
break;
}//end switch sratement
} while(menuSelection != 'Q'); //end loop
return 0;
}// end main()
/* Add in the definitions of your own 5 functions HERE */
//fillArray function
void fillArray(int arr[], int SIZE, int min, int max)
{
int range;
for (int i = 0; i < SIZE ; i++)
{
range = (max - min + 1);
arr[i] = (rand() % (range)) + min;
}
}//End Fill Array Function
//Insert Array function - Save for last
void insert(int arr[], int SIZE, int newValue, int index)
{
if (index < SIZE)
 {
for (int i = SIZE -1; i > index; i--) //start i at the
very end
{
arr[i] = arr[i - 1];
}
arr[index] = newValue;
}
}//End Insert
//Delete Array Function
void deleteArray(int arr[], int SIZE, int index)
{
if (index < SIZE)
{
for (int i = index; i < SIZE -1 ; i++) /* SIZE - 1 so the
loop doesn't copy garbage data to the end of the array. Start at i =
index, so the loop starts incrementing from that point. */
{
arr[i] = arr[i+1]; /* How this all works: i =
index is where the array loop will start and then, i will continue to
increment (++) until condition is met (i > SIZE), arr[i+1] once the
computer reaches an index it adds 1 to the index (so 2 + 1 = 3) and then
copies whatever is in index 3 to index 2. */
}
arr[SIZE -1] = 0; /*Last Number will equal zero, must be
done outside the loop so errors don't arise*/
}
}//End Delete
//Reverse Array Function - Save for last
void reverse(int arr[], int SIZE)
{
int temp;
for (int i = 0; i < SIZE / 2; i++)
{
temp = arr[SIZE - i - 1];
arr[SIZE - i - 1] = arr[i];
arr[i] = temp;
}
}//End Reverse
//MaxEven Array Function
int maxEven(const int arr[], const int SIZE)
{
int maximum = arr[0];
for (int i = 0; i < SIZE; i++)
{
if (arr[i] % 2 == 0)
{
if (arr[i] > maximum) // If the array number
is greater than the max, maximum equals the number at the index
maximum = arr[i];
}
}
return maximum;
}// End MaxEven Function
/* Definition of PrintArray below DO NOT CHANGE!*/
//PrintArray Function
//This function prints the contents of any interger array of any size
seperated by commas
void PrintArray(const int arr[], const int size)
{
cout << "\nThe array:\n { ";
for (int i = 0; i < size - 1; i++) // for loop, prints each item (not
last due to comma handling)
cout << arr[i] << ", ";
cout << arr[size - 1] << " }\n"; // prints last item , sans comma
