$title  Production scheduling with time-varying electricity prices for a system with storage

$OnText
This is the optimization model (with hourly electricity prices) used in "A Grid View on the Dynamics of Processes
Participating in Demand Response Programs."
$OffText

SETS
i hours for three days /1*72/
*For time horizon H = 3 days
j minutes for each hour /1*60/
*For different price change frequencies, change j accordingly, e.g., j minutes for each half an hour /1*30/
s scenario /VEA7,SDGE7,SCE7,PGAE7,VEA24,SDGE24,SCE24,PGAE24/
;

PARAMETERS
tstep time step min /1/
D "demand kg/min" /36/
K "energy density constant MWh/kg" /0.000350/
gamma "tank cost coefficient   $/kg liquid air " /2.45/
tau "time constant for process min"    /10/
*tau: in the range of [10, 150] min with increments of 10 min
n "payback time in years" /5/
alpha "proccess flexibility" /0.2/
r "coefficient accounting for the electricity usage penalty" /0.01/
*r: related to supplying product from stored inventory
;

TABLE
PI(i,s) hourly electricity price in three days from different source
* $/MWh CAISO Day-Ahead electricity price 09/07/21 00:00-09/10/21 00:00 & 09/24/21-09/27/21
*For other price change frequencies, input a different price table (randomly perturbing
*the price values at each sample time by ±1% relative to the data in our case)
         VEA7        SDGE7           SCE7            PGAE7           VEA24           SDGE24          SCE24           PGAE24
1       53.68213        56.54412        55.85973        57.47597        54.86303        57.36526        56.73098        59.99552
2       50.21729        53.24097        52.46575        52.91074        52.34881        55.19000        54.33709        56.61890
3       50.84067        54.13713        53.05274        53.07075        50.06907        53.36916        52.13296        54.04828
4       50.44529        53.58839        52.58205        52.59672        50.32997        53.12197        51.89222        53.69198
5       51.35275        54.28558        53.33082        53.32879        51.63715        54.97281        53.74791        55.68369
6       55.65313        58.75789        57.60232        57.77948        57.02834        60.85648        59.49967        61.72871
7       71.22370        76.73255        75.22740        75.11452        61.24112        66.50362        64.41823        66.20944
8       61.16949        66.85385        65.54157        66.31311        55.60000        62.44437        60.75067        62.83998
9       45.38568        52.00545        51.28510        52.47187        38.87000        51.18621        49.93390        52.39763
10      39.03000        51.29680        50.62642        51.87506        40.32983        44.00002        42.56674        51.82521
11      45.27000        49.90107        49.34312        50.48392        26.68498        39.96433        38.04343        56.29565
12      49.18018        53.85302        53.08584        54.44316        39.40002        43.40479        41.36269        55.31216
13      56.71313        61.09042        61.23262        62.93284        36.55860        49.05697        46.69208        62.52384
14      65.90393        70.96017        71.16184        73.60353        45.59000        52.40176        51.30124        65.62300
15      75.85408        83.23372        81.46833        83.45757        52.49683        57.77429        54.86000        65.67883
16      83.92534        98.19410        89.78774        91.33238        58.74073        67.63462        61.76388        69.65299
17      86.42208        97.14827        91.44115        93.49860        66.43197        75.87782        69.23228        74.97651
18      111.97657       117.64359       116.85585       118.40781       78.71104        82.11544        80.81056        86.90000
19      156.95319       162.40341       160.13248       164.41480       106.03031       108.32453       107.37596       113.61887
20      135.02856       137.26486       136.30449       138.25267       81.45807        83.43869        82.22503        86.53182
21      93.89919        97.05166        95.63450        97.18663        74.74685        77.68176        76.36959        78.94733
22      86.24753        90.02628        88.69000        88.02629        69.98201        72.06609        70.93782        72.82786
23      73.17198        75.98687        75.32677        76.57109        64.43673        66.39883        65.51423        67.65591
24      63.73164        66.01883        65.50408        66.51188        61.43290        63.61647        62.82707        64.64778
25      75.77000        83.12730        82.00000        82.87821        58.44377        60.42553        59.96960        61.81763
26      69.30000        81.46176        79.69213        78.84182        55.42182        57.14149        56.74908        58.93041
27      58.76000        76.07533        73.75460        72.38119        56.74155        58.70508        58.09000        60.43205
28      58.35000        73.61808        71.91275        70.47689        54.89331        56.61105        56.14153        58.62081
29      61.77000        82.12530        79.77082        78.02196        54.52838        56.12982        55.70958        58.08335
30      91.42946        98.39462        95.98812        92.97236        56.91160        58.73945        58.14200        60.33068
31      129.85979       141.50713       139.22527       96.84820        58.52282        61.10435        59.99016        61.79236
32      94.32639        115.76294       100.61339       94.91482        53.72434        56.31353        55.41662        57.47557
33      58.76000        77.82499        75.99932        74.05699        39.39000        48.34081        47.41834        49.90916
34      58.01927        75.95784        74.76031        73.64459        38.19337        40.70821        39.74999        45.64000
35      76.22754        83.46918        81.83299        80.69234        29.82759        31.68931        30.82056        40.72496
36      80.64374        88.71965        86.70498        85.59979        31.78104        33.98877        32.90206        44.90150
37      70.92477        105.87064       104.57924       89.38329        40.40430        40.56800        39.80431        49.59133
38      103.36272       115.10777       113.48869       94.50080        45.58308        47.84240        46.79806        56.15738
39      115.05274       130.07442       122.80988       119.40858       48.21629        50.94894        49.94032        55.60641
40      140.03304       157.46000       150.00000       122.28427       53.11620        56.09116        55.14850        61.59440
41      142.07858       157.37290       150.00000       131.42680       55.64944        58.60800        57.58098        62.51468
42      167.74577       177.14458       174.10481       174.71626       65.78015        69.62580        68.42752        70.96342
43      277.05075       286.87726       283.91507       285.31073       83.66106        86.49732        85.49425        87.41392
44      209.18565       213.01830       211.15490       212.12895       70.70318        73.12412        72.07407        73.72206
45      148.76378       155.27610       151.83736       151.86778       66.56790        68.86548        68.04000        69.52586
46      145.20525       152.07430       148.76617       128.77205       62.04636        64.20743        63.17471        64.24568
47      105.53162       112.13141       109.78361       105.59654       60.36917        62.56100        61.55902        63.78216
48      99.71207        105.55465       103.65479       99.77336        56.87444        58.49876        57.71014        60.18780
49      102.69227       109.16541       106.24993       104.65960       50.63312        51.96171        51.58523        55.95083
50      96.02204        102.47413       99.87708        96.10601        49.47244        52.03347        51.01331        54.93166
51      88.79044        94.99731        92.37608        88.62856        49.69000        52.67913        51.60737        55.73067
52      82.45862        88.32729        86.18587        82.53329        48.82000        52.16768        51.11819        55.07380
53      96.33227        102.39380       100.06861       96.41399        50.73636        53.32000        52.26123        56.11524
54      112.47899       119.41114       116.40759       110.86872       52.53276        55.00907        53.83949        57.97349
55      178.73445       190.99104       187.98059       115.96275       49.76000        57.01789        55.55157        59.81620
56      126.21429       136.27911       133.21000       121.36251       47.88000        50.50209        49.51688        53.34482
57      89.02000        100.67362       98.58877        94.49667        38.63994        40.70008        39.55794        46.96742
58      81.06757        104.20020       103.08811       83.64712        31.64254        29.39216        27.99498        48.77265
59      111.05488       120.73968       119.79469       92.41293        27.84770        26.50752        24.73012        50.00754
60      129.94199       142.14378       141.36345       97.83122        26.01687        25.25837        24.00000        47.23279
61      153.67850       166.29846       166.33578       103.42732       32.75000        36.67036        36.31114        39.89690
62      184.71184       200.22926       200.40047       115.62474       34.53580        40.18690        39.84282        47.60322
63      199.57747       220.35030       215.19365       115.78747       36.12000        44.18339        43.80114        48.32662
64      227.65378       248.57286       244.27785       124.88685       45.53190        49.96031        49.26178        52.59795
65      248.10303       266.26150       264.98215       131.52962       47.64392        50.46930        49.80120        52.52969
66      302.95740       318.23538       317.13632       228.47691       61.04230        64.48657        63.53198        65.57016
67      695.62870       717.19240       717.01794       519.51556       71.97988        75.49752        74.29986        76.35622
68      419.72540       431.69974       431.09000       311.94574       69.95621        73.10187        71.93410        74.05797
69      265.12827       277.68182       275.03620       162.15556       65.32013        67.82668        67.05701        69.29110
70      249.53157       262.24936       260.27875       126.64429       63.31490        65.61370        64.52960        66.09697
71      143.27872       151.17429       148.97260       111.36238       58.39097        60.48525        59.53220        62.06962
72      132.14117       139.02000       136.79324       113.05602       53.30238        54.88683        53.95935        56.67001

;


VARIABLES
Z  annualized total cost
;

POSITIVE VARIABLES
P(s,i,j) production rate
Psplit(s,i,j) split of productoin diverted to meet demand
Psp(s,i) set point of production rate
Sin(s,i,j) flow into tank
Sout(s,i,j) flow out tank
e(s,i,j) energy consumption
EC(s) energy cost
C storage tank cost or annualized capital cost
S(s,i,j) tank holdup
Smaxx storage capacity
*Smaxx is the Smax in the formulation because Smax is a predefined function in GAMS.
;


EQUATIONS
prodlimu(s,i,j) upper bound for prod rate
prodliml(s,i,j) lower bound for prod rate

prodcal(s,i,j) calculation of prod rate
demandcon(s,i,j) demand constraint
dprodcal(s,i,j) production rate dynamics cal
holdcon(s,i,j) holdup constraint
dflowcal(s,i,j) tank flow cal

endstorage1(s) end storage
endstorage2(s) end storage

conts(s,i,j) continuity for storage state
contp(s,i,j) continuity for production rate
contpsplit(s,i,j) continuity for production split
contsout(s,i,j) continuity for storage flow out

energycal(s,i,j) energy consum
energy_cost(s) energy cost
tank_cost tank cost
totcost objective function
;

prodlimu(s,i,j).. P(s,i,j) =le= D*(1+alpha);
prodliml(s,i,j).. P(s,i,j) =ge= D*(1-alpha);

prodcal(s,i,j).. P(s,i,j) =e= Sin(s,i,j) + Psplit(s,i,j);
demandcon(s,i,j).. D =le= Sout(s,i,j)+Psplit(s,i,j);
dprodcal(s,i,j) $ (ord(j) < card(Jdyn)).. P(s,i,j+1) =e= tstep *((Psp(s,i)-P(s,i,j))/tau)+P(s,i,j);
holdcon(s,i,j).. Smaxx =ge= S(s,i,j);
dflowcal(s,i,j) $(ord(j)<card(j)).. S(s,i,j+1) =e= tstep *(Sin(s,i,j)  -Sout(s,i,j))+S(s,i,j);

S.fx(s,'1','1') = 1000;
endstorage1(s).. S(s,'72','60') =ge= S(s,'1','1');
endstorage2(s).. S(s,'72','60') =le= S(s,'1','1');


*continuity
contp(s,i,j)$((ord(i) GE 2) AND (ord(j)=card(j))).. P(s,i,'1') =e= P(s,i-1,j);
contpsplit(s,i,j)$((ord(i) GE 2) AND (ord(j)=card(j))).. Psplit(s,i,'1') =e= Psplit(s,i-1,j);
conts(s,i,j)$((ord(i) GE 2) AND (ord(j)=card(j))).. S(s,i,'1') =e= S(s,i-1,j);
contsout(s,i,j)$((ord(i) GE 2) AND (ord(j)=card(j))).. Sout(s,i,'1') =e= Sout(s,i-1,j);

*cost calculations
energycal(s,i,j)$(ord(j)<card(j)).. e(s,i,j) =e= K*(P(s,i,j)+r*Sout(s,i,j));
energy_cost(s).. EC(s) =e= sum(i, sum(j$(ord(j)<card(j)),e(s,i,j))*PI(i,s));
*change to annualized cost
tank_cost.. C =e= gamma*Smaxx/n;
totcost.. Z =e= C+(365/3)*sum(s,EC(s))/8;


MODEL storage /all/ ;


OPTION LIMROW  = 5;
OPTION LIMCOL  = 0;
OPTION RESLIM  = 10000000;
OPTION ITERLIM = 10000000;
OPTION OPTCA   = 0.0;
OPTION OPTCR   = 0.0;
OPTION NLP = conopt3;
OPTION MIP = CPLEX;
OPTION LP = CPLEX;
OPTION MINLP = SBB;


SOLVE storage using lp minimizing Z ;

file datafile2 /C:\Users\Your folder\Scheduling_Optimization.m/;
datafile2.nd=6; datafile2.nw=20; datafile2.nr=1; datafile2.nz=1e-5;
put datafile2
put 'Prod_result=[' ;
loop(s,
         loop(i,
            loop(j,
                   put (P.l(s,i,j)); put(Psp.l(s,i)); put(Psplit.l(s,i,j));  put(S.l(s,i,j));   put(Sin.l(s,i,j));  put(Sout.l(s,i,j)); put';'  /;  )
                 )
            )

;
put '];';
putclose datafile2;












