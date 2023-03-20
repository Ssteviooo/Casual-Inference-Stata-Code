//1.b
//define binary var "newtype"
gen newtype = 1 if ipodtype == 2
replace newtype = 0 if ipodtype !=2
//Regression 
reg newtype white [w=stateweight],r

//1.c
reg responses white [w=stateweight],r
reg anyoffer white [w=stateweight],r

//1.e
reg bestoffer white [w=stateweight],r
mean bestoffer
display r(mean)-3.71

//1.f
gen offer = 0
replace offer = bestoffer if !missing(bestoffer)
replace offer = 0 if missing(bestoffer)
reg offer white [w=stateweight]

//1.g
reg offer white [w=stateweight] if highquality==1, r
reg offer white [w=stateweight] if highquality==0, r
reg offer white white##highquality [w=stateweight], r
reg offer white holiday night [w=stateweight] if highquality==1, r
reg offer white holiday night [w=stateweight] if highquality==0, r
reg offer white holiday night highquality##white [w=stateweight], r







