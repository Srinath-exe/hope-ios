// Online C compiler to run C program online
#include <iostream.h>
#include <conio.h>
#include <stdio.h>
#include <string.h>

//class account declaration and definition
class account
{
public:
    char name[30];
    int acountNumber, AccountType;
    int balance;
    int amount;

    //to initialize instance members
    void getData()
    {
        cout << "\nEnter the following details\nCustomer Name :";
        gets(name);
        cout << "\nAccount number :";
        cin >> acountNumber;
        cout << "\nAccount type\n1. Saving Account\n2.Current Account\n";
        cin >> AccountType;
        cout << "\nAccount balance:";
        cin >> balance;
    }

    //to display balance
    void display()
    {
        cout << "\nYour Account Balance :" << balance;
    }

    //to withdraw money from account
    void withdraw()
    {
        cout << "\nEnter the amount you want to withdraw :";
        cin >> amount;
        if (amount > balance)
            cout << "\nInsuficient balance";
        else
            balance = balance - amount;
        display();
    }
};

//class current account
class cur_acct : public account
{
public:
    void panelty()
    {
        if (balance < 200 && acc_type == 2)
        {
            balance = balance - 20;
            display();
        }
    }
};

//class saving account
class sav_acct : public account
{
public:
    void interest()
    {
        int t;
        cout << "\nEnter time interval in year:";
        cin >> t;
        balance = balance * (1 + 2 * t);
        display();
    }
};

//main() to test account
void main()
{
    clrscr();
    account ac;
    ac.getData();
    ac.display();
    ac.withdraw();
    getch();
}