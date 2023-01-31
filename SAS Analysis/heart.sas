/*Import the csv file into SAS studio*/
PROC IMPORT DATAFILE= '/home/u62783616/Heart Disease/heart .csv'
			OUT= WORK.HEART
			DBMS= CSV
			REPLACE;
RUN;

/*Print the results*/
TITLE 'Heart disease dataset';
PROC PRINT DATA= WORK.HEART;
RUN;

/*Check for nulls*/
proc format; 
   value $missfmt ' '='Missing' other='Not Missing'; 
   value missfmt .  ='Missing' other='Not Missing'; 
run;
proc freq data=WORK.HEART
; 
	format _NUMERIC_ missfmt.; 
	table _NUMERIC_ / missing missprint nocum nopercent; 
	format _NUMERIC_ missfmt.; 
	tables _NUMERIC_ / missing missprint nocum nopercent; 
run;

/*Remove duplicates*/ 
proc sort data=WORK.HEART nodupkey;
	by _all_;
run;
/*Print Results*/
TITLE 'Heart disease dataset';
PROC PRINT DATA= WORK.HEART;
RUN;

/*Data Visualization*/
title 'Total number of observation by gender';
proc sgplot data=WORK.HEART;
	vbar sex /;
	yaxis grid;
run;
title 'Number of observation by age';
proc sgplot data=WORK.HEART;
	vbar age /;
	yaxis grid;
run;
title "number of male and female with the disease";
proc sgplot data=WORK.HEART;
	vbar sex / group=target groupdisplay=cluster;
	yaxis grid;
run;

proc sgplot data=WORK.HEART;
	vbar sex / group=thal groupdisplay=cluster;
	yaxis grid;
run;

proc sgplot data=WORK.HEART;
	vbar sex / group=age groupdisplay=cluster;
	yaxis grid;
run;

proc sgplot data=WORK.HEART;
	vbar sex / group=ca groupdisplay=cluster;
	yaxis grid;
run;

proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=sex / stat=pct start=90 categorydirection=clockwise;
		endlayout;
		endgraph;
	end;
run;
proc sgrender template=SASStudio.Pie data=WORK.HEART;
run;



