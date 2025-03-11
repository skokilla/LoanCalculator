with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use Ada.Text_IO;


with makereport;




procedure Paycalc2 is

--declarations below
   principal : Float := 0.0; --20000.00
   interestRate : Float := 0.0; --0.060
   yearsPaying: Float:= 0.0; --5.0
   sumInterest: Float:= 0.0;
   numLoans: Integer :=0;
   totalPaid: Float :=0.0;
   loanName: String(1..50);
   loanNameLn: Natural;
  begin
   --Getting all the values
   Put_Line("Enter Number of Loans: ");
   Ada.Integer_Text_IO.Get(numLoans);
  -- compareInterest := new floatArray(1..numLoans);

   for I in 1..numLoans loop
      Ada.Text_IO.Skip_Line; --clears get buffer so it doesn't skip over getting the name
      Put_Line("Enter Loan" & Integer'Image(I)&" name: "); --'Image sets a value to a string type output
      Get_Line(loanName,loanNameLn);
      Put_Line("Enter Loan" & Integer'Image(I)& " Amount: ");
      Ada.Float_Text_IO.Get(principal);    -- principal := 20000.00;
      Put_Line("Enter the Interest Rate for loan" & Integer'Image(I)& " as a percentage: ");
      Ada.Float_Text_IO.Get(interestRate);--interestRate := 0.060;
      interestRate := interestRate/100.0;--turns percentage into a decimal
      Put_Line("Enter the number of years loan" & Integer'Image(I)& " will be paid: ");
      Ada.Float_Text_IO.Get(yearsPaying);--yearsPaying := 5.0;

      sumInterest:= makeReport(principal,interestRate, yearsPaying, loanName, loanNameLn);
      totalPaid:= principal+sumInterest;

      Put("Total Interest Paid in loan " & loanName(loanName'First..LoanNameLn)&": $");
      Ada.Float_Text_IO.Put(sumInterest, Aft=>2, Exp =>0);
      New_Line;
      Put("Total paid over loan " & loanName(loanName'First..LoanNameLn)& "'s period: $");
      Ada.Float_Text_IO.Put(totalPaid, Aft=>2, Exp =>0);
      New_Line;
      Put("View report separately here: C:/Users/12589/OneDrive/Desktop/Lab 1 output folder/"& loanName(loanName'First..LoanNameLn) &".txt");
      New_Line;
      sumInterest:=0.0; -- resests value for next loop
      totalPaid:=0.0; --resets value for next loop
   end loop;
   null;
end Paycalc2;






