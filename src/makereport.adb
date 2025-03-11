--Everytime I try to have a subprogram in "main" I get an error for too many computation units. Having seperate files was the work around I've found.
with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use Ada.Text_IO;

function makeReport(principal: Float; interestRate: Float; yearsPaying: Float; loanName : String; LoanNameLn: Integer) return Float is
   paymentsPerYear: Float := 12.0;
   monthsPayingF :Float := 0.0; -- the float version
   monthsPaying: Integer := 0; -- integer version actually used
   monthInterest: Float := 0.0;
   monthlyPay : Float := 0.0;
   newBal : Float := 0.0;
   toInterest: Float := 0.0;
   toLoan : Float := 0.0;
   file : File_Type;
   sumInterest : Float :=0.0;
   totalPaid : Float :=0.0; --redeclaring for this function

      begin

   monthsPayingF := paymentsPerYear*yearsPaying; -- the float version
   monthsPaying := Integer(monthsPayingF); -- integer version actually used
   monthInterest := interestRate/paymentsPerYear;
   monthlyPay := (monthInterest*principal*((1.0+monthInterest)**(monthsPaying)))/(((1.0+monthInterest)**(monthsPaying))-1.0); -- Calculate the monthly payment
   newBal := principal;

   Create(file, Out_File, "C:/Users/12589/OneDrive/Desktop/Lab 1 output folder/"& loanName(loanName'First..LoanNameLn)&".txt");
-- Ada.Integer_Text_IO.Put(monthsPaying); -- Debugging
   monthlyPay := Float'Ceiling(monthlyPay); -- round up the monthly payment
   New_Line;
   Put_Line(loanName(loanName'First..LoanNameLn)); -- prints loan's name and trims the printed string to the length of the actual string
    Put_Line("+-------------------------------------------------------------------------+"); -- Formatting the table
   Put_Line("| Month |  Balance  |  Payment  |  Interest  | Towards Loan | New Balance |");  -- headers
   Put_Line("+-------+-----------+-----------+------------+--------------+-------------+"); -- more format
   Put_Line(file,"+-------------------------------------------------------------------------+"); --same thing as above but for the file out
   Put_Line(file,"| Month |  Balance  |  Payment  |  Interest  | Towards Loan | New Balance |");
   Put_Line(file,"+-------+-----------+-----------+------------+--------------+-------------+");
   for I in 1..monthsPaying loop

      if monthlyPay>newBal then -- check and correct final payment
         toInterest := newBal * monthInterest;
         toLoan := newBal;
         monthlyPay := toLoan+toInterest;
      else
         toInterest := newBal * monthInterest; -- Calculate how much goes to the interest amount
         toLoan := monthlyPay - toInterest; -- Calculate how much goes to the loan principle
      end if;

      sumInterest:= sumInterest+toInterest; -- calculating the sum of interest paid throughout the loan


      Put("| ");
      Put(file,"| ");
      Ada.Integer_Text_IO.Put(I,Width =>6);
      Ada.Integer_Text_IO.Put(file,I,Width =>6);
      Put("| ");
      Put(file,"| ");
      Ada.Float_Text_IO.Put(newBal, Aft => 2, Fore=>7, Exp =>0);
      Ada.Float_Text_IO.Put(file,newBal, Aft => 2, Fore=>7, Exp =>0);
      Put("| ");
      Put(file,"| ");
      Ada.Float_Text_IO.Put(monthlyPay, Aft => 2, Fore=>7, Exp =>0);
      Ada.Float_Text_IO.Put(file,monthlyPay, Aft => 2, Fore=>7, Exp =>0);
      Put("| ");
      Put(file,"| ");
      Ada.Float_Text_IO.Put(toInterest, Aft => 2, Fore=>8, Exp =>0);
      Ada.Float_Text_IO.Put(file,toInterest, Aft => 2, Fore=>8, Exp =>0);
      Put("| ");
      Put(file,"| ");
      Ada.Float_Text_IO.Put(toLoan, Aft => 2, Fore=>10, Exp =>0);
      Ada.Float_Text_IO.Put(file,toLoan, Aft => 2, Fore=>10, Exp =>0);
      Put("| ");
      Put(file,"| ");
      newBal := newBal - toLoan; -- Calculate the new balance
      Ada.Float_Text_IO.Put(newBal, Aft => 2, Fore=>9, Exp =>0);
      Ada.Float_Text_IO.Put(file,newBal, Aft => 2, Fore=>9, Exp =>0);
      Put("| ");
      Put(file,"| ");
      New_Line;
      New_Line(file);


   end loop;
   totalPaid := sumInterest + principal;
   Put_Line("+-------------------------------------------------------------------------+"); -- table footer
   Put_Line(file,"+-------------------------------------------------------------------------+");


   Put(file,"Total Interest Paid in loan " & loanName(loanName'First..LoanNameLn)&": $");
   Ada.Float_Text_IO.Put(file,sumInterest, Aft=>2, Exp =>0);
   New_Line(file);
   Put(file,"Total paid over loan " & loanName(loanName'First..LoanNameLn)& "'s period: $");
   Ada.Float_Text_IO.Put(file,totalPaid, Aft=>2, Exp =>0);

   Close(file);
   return sumInterest;


end makeReport;
