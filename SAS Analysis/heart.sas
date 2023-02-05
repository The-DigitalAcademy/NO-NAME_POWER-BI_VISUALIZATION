/*
************************************************************************************************************************************************************************************************
** Description Of Columns Used for analysis.																																				  **
************************************************************************************************************************************************************************************************
**																																															  **
**  •  	 age:The person's age in years																																						  **
**	•    sex: The person's sex (1 = male, 0 = female)																																		  **
**	•    cp: The chest pain experienced (Value 1: typical angina, Value 2: atypical angina, Value 3: non-anginal pain, Value 4: asymptomatic)												  **
**	•    trestbps: The person's resting blood pressure (mm Hg on admission to the hospital)																									  **
**	•    chol: The person's cholesterol measurement in mg/dl																																  **
**	•    fbs: The person's fasting blood sugar (> 120 mg/dl, 1 = true; 0 = false)																											  **
**	•    restecg: Resting electrocardiographic measurement (0 = normal, 1 = having ST-T wave abnormality, 2 = showing probable or definite left ventricular hypertrophy by Estes' criteria)	  **
**	•    thalach: The person's maximum heart rate achieved																																	  **
**	•    exang: Exercise induced angina (1 = yes; 0 = no)																																	  **
**	•    oldpeak: ST depression induced by exercise relative to rest ('ST' relates to positions on the ECG plot)																			  **
**	•    slope: the slope of the peak exercise ST segment (Value 1: upsloping, Value 2: flat, Value 3: downsloping)																			  **
**	•    ca: The number of major vessels (0-3)																																				  **
**	•    thal: A blood disorder called thalassemia (3 = normal; 6 = fixed defect; 7 = reversable defect)																					  **
**	•    target: Heart disease (0 = no, 1 = yes)																																			  **
**																																															  **
**--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------**
**																																															  **
**	p: chest pain type																																										  **
**	-Value 0: asymptomatic																																									  **
**	- Value 1: atypical angina																																								  **
**	- Value 2: non-anginal pain																																								  **
**	- Value 3: typical angina																																								  **
**																																															  **
**	restecg: resting electrocardiographic results																																			  **
**	- Value 0: showing probable or definite left ventricular hypertrophy by Estes' criteria																									  **
**	- Value 1: normal																																										  **
**	- Value 2: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV)																				  **
**																																															  **
**	slope: the slope of the peak exercise ST segment																										 								  **
**	0: downsloping; 1: flat; 2: upsloping																																					  **
**																																															  **
**	thal																																													  **
**	Results of the blood flow observed via the radioactive dye.																																  **
**																																															  **
************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************
*/

/*Import the csv file into SAS studio*/
PROC IMPORT DATAFILE= '/home/u62783616/Heart Disease/heart .csv'
			OUT= WORK.HEART
			DBMS= CSV
			REPLACE;
RUN;

/*Print the results*/
TITLE 'Heart disease dataset';
PROC PRINT DATA= WORK.HEART (obs=10);
RUN;

/*Check for nulls*/
title "Number of null values";
proc means data=work.heart nmiss n;
run;

/*Remove duplicates*/ 
proc sort data=WORK.HEART nodupkey;
	by _all_;
run;

/*Print Results*/
TITLE 'Heart disease dataset';
PROC PRINT DATA= WORK.HEART (obs=10);
RUN;

/*Data Visualization*/
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		layout region;
		piechart category=sex / stat=pct start=90 categorydirection=clockwise;
		endlayout;
		endgraph;
	end;
run;

TITLE "Gender comparison based on whether they have a heart disease or not";
proc sgrender template=SASStudio.Pie data=WORK.HEART;
run;

title "Age by Gender";
proc sgplot data=WORK.HEART;
	vline age / group=sex;
	yaxis grid;
run;

title "Number of male and female with a heart disease";
proc sgplot data=WORK.HEART;
	vbar sex / group=target groupdisplay=cluster;
	yaxis grid;
run;

title 'Number of observation by age';
proc sgplot data=WORK.HEART;
	vbar age /;
	yaxis grid;
run;

TITLE "Level of Thalassemia by gender";
proc sgplot data=WORK.HEART;
	vbar thal / group=target groupdisplay=cluster;
	yaxis grid;
run;

TITLE "Type of blood vessels based on whether the patient has a heart disease";
proc sgplot data=WORK.HEART;
	vbar target / group=ca groupdisplay=cluster;
	yaxis grid;
run;

title "Chest pain type for people with and without a heart disease";
proc sgplot data=WORK.HEART;
	vbar target / group=cp groupdisplay=cluster;
	yaxis grid;
run;

title "Number of male and female with and without a heart disease";
proc sgplot data=WORK.HEART;
	vbar target / group=sex groupdisplay=cluster;
	yaxis grid;
run;

title "Fasting blood sugar for people with and withou a heart disease";
proc sgplot data=WORK.HEART;
	vbar target / group=fbs groupdisplay=cluster;
	yaxis grid;
run;

title "Average heart rate ";
proc sgplot data=WORK.HEART;
	vbar target / group=slope groupdisplay=cluster;
	yaxis grid;
run;

title "Induced exsercise by target";
proc sgplot data=WORK.HEART;
	vbar target / group=exang groupdisplay=cluster;
	yaxis grid;
run;

title "Reting Resting blood pressure for people with and without a heart d";
proc sgplot data=WORK.HEART;
	vbar target / group=restecg groupdisplay=cluster;
	yaxis grid;
run;

title "Age range for people with nd without a heart disease";
proc sgplot data=WORK.HEART;
	vline age / group=target;
	yaxis grid;
run;



