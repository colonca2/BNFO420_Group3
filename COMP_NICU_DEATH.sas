proc import datafile="C:\Users\Zero\Documents\VCU\BNFO 420\MRD_Data_Final.csv"
    out=work.MRDdata
    dbms=csv
    replace;
    getnames=yes;  
run;

proc univariate data=work.MRDdata;
    var Maternal_Deaths Total_NICU_Admissions;
    histogram / normal;
run;

data work.NonOutlierData;
	set work.MRDdata;
	if State not in ("Florida", "North Carolina", "Texas", "California", "New York");
run;


proc corr data=work.MRDdata;
    var Maternal_Deaths Total_NICU_Admissions; 
run;

proc corr data=work.NonOutlierdata;
    var Maternal_Deaths Total_NICU_Admissions; 
run;


proc sgplot data=work.MRDdata;
    scatter x= Maternal_Deaths y= Total_NICU_Admissions;
	reg x= Maternal_Deaths y= Total_NICU_Admissions;
    title "Scatter Plot of Maternal Deaths vs. NICU Admissions (2018-2022)";
    xaxis label="Maternal Deaths";
    yaxis label="Total NICU Admissions";
run;

proc sgplot data=work.NonOutlierdata;
    scatter x= Maternal_Deaths y= Total_NICU_Admissions;
	reg x= Maternal_Deaths y= Total_NICU_Admissions;
    title "Scatter Plot of Maternal Deaths vs. NICU Admissions (2018-2022) N.O";
    xaxis label="Maternal Deaths";
    yaxis label="Total NICU Admissions";
run;
