*Q2 b
twoway scatter classize cohsize, xline(40 80 120 160)
*Q2 c
gen above40 = (cohsize > 40)
replace above40 = 0 if cohsize <= 40
gen above80 = (cohsize > 80)
replace above80 = 0 if cohsize <= 80
gen center40=cohsize-40
gen center80=cohsize-80
reg avgscore center40 above40 if center40 >=-30 & center40<=30, cluster(coh_id)
reg avgscore center40 above40 if center40 >=-20 & center40<=20, cluster(coh_id)
reg avgscore center80 above80 if center80 >=-30 & center80<=30, cluster(coh_id)
reg avgscore center80 above80 if center80 >=-20 & center80<=20, cluster(coh_id)
*Q2 e
drop if cohsize > 80
*Q2 f 
reg tipuach above40#c.center40 if abs(center40)<=30, cl(coh_id)
reg tipuach above40##c.center40 if abs(center40)<=20, cl(coh_id)
*Q2 g
keep cohsize coh_id
duplicates drop
g count=1
collapse (sum) count, by(cohsize)
gen center40=cohsize-40
gen above40=cohsize>40
reg count above40##c.center40 if abs(center40)<=30,r
*Q2 h
reg avgscore classize
* RD model with classize as running variable
reg avgscore center40 above40 classize if center40 >=-30 & center40<=30, cluster(coh_id)
* RD model with classize as running variable and bandwidth of 20
reg avgscore center40 above40 classize if center40 >=-20 & center40<=20, cluster(coh_id)
*Q2 i
*group our center40 variable into bins of 2 (e.g., center40=0 and center40=1 will now both equal zero). 
g center40_2 = floor(center40/2)*2
*keep only observations with center40 between -20 and 20
keep if abs(center40)<=20
*take the mean of test scores and class size by our grouped bins 
collapse (mean) classize avgscore, by(center40_2)
*create a scatter plot and fit a line on both sides of the cutoff. 
scatter avgscore center40_2, ylabel(40(5)80) || ///
lfit avgscore center40_2 if center40_2<0 || ///
lfit avgscore center40_2 if center40_2>=0
*create a scatter plot and fit a line on both sides of the cutoff. 
scatter classize center40_2, ylabel(10(5)40) || ///
lfit classize center40_2 if center40_2<0 || ///
lfit classize center40_2 if center40_2>=0
