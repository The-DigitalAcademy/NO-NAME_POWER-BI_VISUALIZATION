/*Importing the dataset*/
proc import OUT = loans 
FILE ='/home/u62791206/Loans/Loan_Data.csv'
DBMS = CSV
REPLACE;
run;

/*Printing the dataset*/
 title 'Loans';
proc print data = loans;
run;

/* Checking the data types*/
proc contents DATA=loans;
run;

/* Cheching for nulls*/
proc means data= loans
nMISS n; 
var ApplicantIncome; 
run;
proc means data= loans
nMISS n; 
var CoapplicantIncome; 
run;
proc means data= loans
nMISS n; 
var LoanAmount;
run; 
proc means data= loans
nMISS n; 
var Loan_Amount_Term; 
run;
proc means data= loans
nMISS n; 
var Credit_History; 
run;
proc sql; 
select nmiss(Married) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Education) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Self_Employed) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Gender) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Property_Area) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Loan_Status) as n_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Loan_ID) as Dn_missing_state from loans; 
quit; 
run;
proc sql; 
select nmiss(Dependents) as n_missing_state from loans; 
quit; 
run;
data WORK.loans;
set WORK.loans;
 
LoanAmount= coalesce(LoanAmount,146);
Loan_Amount_Term =coalesce(Loan_Amount_Term,342);
Credit_History = coalesce(Credit_history,1);
run;
proc means;
run;
PROC FREQ data=loans;
   TABLES Gender / OUT=freq;
RUN;

PROC SORT data=freq;
   BY Gender descending;
RUN;

DATA mode_Gender;
   SET freq;
   IF _N_ = 1 THEN mode_Gender = Gender;
RUN;

proc univariate data=loans mode;
    var Gender;
run;