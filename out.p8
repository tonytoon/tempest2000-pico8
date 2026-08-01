pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
e4={}function o3(n,e)local n=e4[n]if(not n)return
return@(n+min((e-1)\2,49))/128end o5={{4,4},{8,5},{24,6},{32,7},{80,8},{96,10}}te={16,8,6,5,4,3,2,1}t1={8,4,3,2,1,1,1,1}function o6(e)for n in all(o5)do if(e<=n[1])return n[2]
end return 15end function tt(n)return function()return n end end function o4(o)local e=0local function n()e+=1return ord(o,e)end local function d()return n()>>>16|n()>>>8|n()|n()<<8end return function()local n,t=n()t,n=n&252~=252and n>>>2&63,n%4if(n==0)return t and t-31or d()
if(n==3)return({true,false})[t]
local n=t or d()<<16e+=n return sub(o,e-n+1,e)end end do local n,o={function()local n=nM()return function()return e8[n]end end},split"1,0,0,2,2,2,2,2,3,2,1,2,2,2,2,2,2,2,2,1,1,2,3,2,3,1,2,2,3,2,2,1,2,3,0,1,2,2,2,3,2"function U(e)e8,nM,nk={},o4(e),function()e8,nM,nk=nil end return n[nM()]()(nk())()(_ENV)end local function d(a,b,c)local n=nk function nk()a,b,c=a(),b(),c()return n()end return function()return a end,function()end,function(f)return f end,function(...)return a(...)-b(...)end,function(...)return a(...)\b(...)end,function(...)return a(...)+b(...)end,function(f)return a(f),b(f)end,function(f)return a(f)(b(f))end,function(t,f)t[b]=f[c]return a(t,f)end,function(f)local u={__index=a({},f)}return function(...)return b(setmetatable({...},u))end end,function(f)return#a(f)end,function(f)a(f)return b(f)end,function(f)return a(f)[b(f)]end,function(f)f[b]=a(f)end,function(f)return a(f)<b(f)end,function(f)return a(f)and b(f)end,function(f)return a(f)or b(f)end,function(...)return a(...)%b(...)end,function(...)return a(...)*b(...)end,function(f)return{a(f)}end,function(f)return f[a]end,function(f)return f[a][b]end,function(f)f[b][c]=a(f)end,function(f)return a(f)>b(f)end,function(f)if(a(f))return b(f)
return c(f)end,function(f)return-a(f)end,function(f)return a(f)==b(f)end,function(...)return a(...)/b(...)end,function(f)f[c]={a(f)}return b(f)end,function(f)return a(f)>=b(f)end,function(f)return a(f)[b]end,function(f)return not a(f)end,function(f)return a(f)~=b(f)end,function(f)a(f)[b(f)]=c(f)end,function(f,v)return v end,function(f)return@a(f)end,function(...)return a(...)<<b(...)end,function(...)return a(...)|b(...)end,function(f)return a(f)<=b(f)end,function(f)a(f)[c]=b(f)end,function(...)return a(...)..b(...)end end for t,f in inext,split"0,0,0,2,2,2,2,2,1,2,1,2,2,1,2,2,2,2,2,1,0,0,1,2,3,1,2,2,2,2,1,1,2,3,0,1,2,2,2,2,2"do local function e(e)return e<f and n[nM()]()or tt(e<o[t]and nM())end add(n,function()return tt(add(e8,(select(t,d(e(0),e(1),e(2))))))end)end end U'そ☉ぬチそさ😐x█きスx\rminう▤⬆️…ケ█░█░う█⬆️░😐█	o8ぬチそ█☉ぬまき█😐うきスx\rmaxう⬆️█▤░も░|…てスx	te█⬆️tひ█ケ▤ケt█⬆️█	o9ぬチそ█☉ぬまき█😐う█オ…てスx	t1█⬆️tひ█ュ\0\0"\0█ユ█	o7ぬチそ██ぬま⬆️█▤█そxぬまろろらもケx░…█うらも█ュ\0\0.\0█う…░て█ュ\0\0.\0…░⬆️っ█ュ\0\0.\0█そt█ユ█	oEぬチそ█☉き█😐うアき█もう…█…░ら█っ░░░ュ\0\0◜\0█	e9ぬチそ█☉アき█😐う█▤░ュ\0\0○\0█ュ\0\0D\0█	e7ぬチそ█☉アき█😐う█▤░ュ\0\0?\0█そ█	eEぬチ█ュ\0\0O\0█	eAぬチそさ█░t█ぬまオ██xぬチきスt	o6█…x	oOぬチろらケ░░▤きスt	o8█…x	oxぬチろら█ュ\0\0^\0█っきスt	o9█…x	oRぬチろ█ュ\0\0e\0きスt	o7█…x	oTぬチきスt	oE█…x	n9ぬチきスt	e9█…x	e9ぬチきスt	e7█…x	e7ぬチきスt	eE█…x	eEぬチきスt	eA█…x	eA█ュ\0\0.\0█	oA██'U"そ☉ぬチオうオう░|う░…う░⬆️う░▤う░さう░ュ\0\0⬇️\0う░そう░うう░█う█きう░ュ\0\0█\0う░てう█さ░ュ\0\0▒\0うオう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう░ュ\0\0😐\0う█てう█きう░ュ\0\0🐱\0░░うオう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう░ュ\0\0♥\0う░ュ\0\0⌂\0う█ュ\0\0-\0う░ぬ░ュ\0\0♪\0うオう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう█▤う░ュ\0\0⬅️\0う░☉う█░█そうオう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう█…う█ュ\0\0.\0う░ひう█☉░ュ\0\0●\0うオう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう░きう█⬆️う█ュ\0\0O\0う█░█░オう█░う█☉う█😐う█…う█⬆️う█▤う█うう█きう█さう░ュ\0\0☉\0う█ュ\0\0O\0う█ュ\0\0/\0う█ぬ█さ█	eOぬチそさ😐t█ぬま█░xノナケx█ュ\0\0/\0██ぬきスt\rpalう█ュ\0\0☉\0うひケ█▤█ュ\0\0☉\0█さ█さぬま█ュ\0\0😐\0x█ュ\0\0⬆️\0█	exぬチオう█⬆️う█ュ\0\0_\0う█きう█ルう█てう█う█⬆️█	toぬチオう█てう█…う█ュ\0\0O\0う█…う█てう█ュ\0\0/\0う█ュ\0\0O\0█…█	oNぬチそさ█ュ\0\0✽\0x█ぬまてスx	totぬきスx\rpalう█ュ\0\0O\0うひスx	oN▤っ█ュ\0\0⬅️\0ケt█さ█さぬき█ュ\0\0と\0う░まうひ█ュ\0\0ち\0█ュ\0\0ね\0█さ███	td██"function k(e,n,t,o)for o=0,o-1do e[t+o]=n n+=@n+1end end nW={}nn={}tf={}tl={}oS=[[192,80,100,50,COLLECT POWERUPS!
192,80,100,50,PARTICLE LASER!
192,80,100,50,JUMP ENABLED!
192,80,100,50,A.I. DROID!
192,80,100,50,OUTTA HERE!
192,80,100,50,YES! YES! YES!
192,80,100,50,2 MORE FOR WARP
192,80,100,50,1 MORE FOR WARP
192,80,100,50,WARP ENABLED
192,80,100,50,CAUGHT YOU!
192,80,100,50,SHOT YOU!
192,80,100,50,FRIED YOU!
192,80,100,50,EAT ELECTRIC|DEATH!
192,80,250,50,AVOID THE SPIKES
192,32,250,50,SUPERZAPPER|RECHARGE
0,0,0,0,|      AMAZING!|  YOU FINISHED ALL| NINETY-NINE STAGES!|  I GUESS YOU WANT|   A SECOND LOOP!|   GET READY FOR|  A REAL CHALLENGE!||BEASTLY MODE UNLOCKED|||  PRESS ANY BUTTON|    TO CONTINUE
0,0,0,0,|BEASTLY RUN COMPLETE!||  A WINNER IS YOU!| COME ON FHQWHGADS!|   GAME IS OVER!|I GUESS YOU HAVE TO|WRITE YOUR OWN NOW!||   TEMPEST WILL|    NEVER DIE!|   ALL THE LOVE| TO DAVE AND JEFF|     AND YOU!
0,0,0,0,BASED ON tempest BY DAVE THEURER
0,0,0,0,AND tempest 2000 BY JEFF MINTER
0,0,0,0,CODE BY DEEPTHAW - VERSION 0.9]]function nF(n)return split(split(oS,"\n")[n])end function oL()k(nW,0,1,37)k(nW,1553,38,53)k(nW,6353,91,45)k(nn,1182,1,37)k(nn,4089,38,37)for n=75,79do nn[n]=5321end k(nn,5419,80,11)k(nn,10853,91,53)k(tf,8192,1,37)k(tl,8875,1,100)end function C(o,t,n)local f=n or nil t=t or oI local n={}for e in all(o.I)do local d=e[1]if d==-1do nB=e[2]elseif d==-3do for d=2,#e do local e=o.O[e[d]]n7(t,e,n)if(not f)n[1],n[2]=J(n[1],n[2])
pset(n[1],n[2],nB)end elseif d==-4or d==-5do local l,i,r,a for d=2,#e do local e=o.O[e[d]]n7(t,e,n)if(not f)n[1],n[2]=J(n[1],n[2])
local n,e=n[1],n[2]if(l)line(l,i,n,e,nB)else r,a=n,e
l,i=n,e end if(d==-5)line(l,i,r,a,nB)
elseif d==-8do local d=o.O[e[2]]n7(t,d,n)if(not f)n[1],n[2]=J(n[1],n[2])
local l,i=n[1],n[2]d=o.O[e[3]]n7(t,d,n)if(not f)n[1],n[2]=J(n[1],n[2])
local r,a=n[1],n[2]d=o.O[e[4]]n7(t,d,n)if(not f)n[1],n[2]=J(n[1],n[2])
oD(l,i,r,a,n[1],n[2],nB)elseif d==-7do local d={}for l=2,#e do local e=o.O[e[l]]n7(t,e,n)if(not f)n[1],n[2]=J(n[1],n[2])
add(d,{n[1],n[2]})end ti(d,nB)end end end function ne(d,f,l,n,e,t,o,i)e=e or n t=t or 4o=o or 0local o={n,o,f+2*n,0,e,l}for e=1,#d do local e=tr[sub(d,e,e)]if(e)e.I[1][2]=t C(e,o)
o[3]+=i or 5*n end end function t0(n,e,t,o)local n,e=nq(n,e)local t,o=nq(t,o)if(not n or not t)return
for d=1,8do local t,o=h(n,t,d/8)+rnd(5)-2,h(e,o,d/8)+rnd(5)-2eR(n,e,t,o,15)n,e=t,o end eR(n,e,t,o,15)end function eR(n,e,t,o,d)n,e=J(n,e)t,o=J(t,o)line(n,e,t,o,d)end function oY(n,e,t)n,e=J(n,e)pset(n,e,t)end nG={}function ta(n,e)for e=1,#n do local t=nG[e]or{}nG[e]=t t[1],t[2]=J(n[e][1],n[e][2])end for n=#n+1,#nG do nG[n]=nil end ti(nG,e)end function ti(t,n)color(n)local n,f=t[#t],{}local e,n=n[1],n[2]for o,t in inext,t do local o,t=t[1],t[2]local l,i=o,t if(n>t)e,n,o,t=o,t,e,n
local o,d=(o-e)/(t-n),n\1+1if(n<0)e-=n*o n=0d=0
e+=(d-n)*o if(t>127)t=127
for n=d,t do local t=f[n]if(t)rectfill(e,n,t,n)else f[n]=e
e+=o end e,n=l,i end end function oD(t,n,f,e,d,o,l)color(l)if(e<n)t,f,n,e=f,t,e,n
if(o<n)t,d,n,o=d,t,o,n
if(o<e)f,d,e,o=d,f,o,e
local l=t+(d-t)/(o-n)*(e-n)t2(t,t,f,l,n,e)t2(f,l,d,d,e,o)end function t2(e,t,d,f,n,o)d,f=(d-e)/(o-n),(f-t)/(o-n)if(n<0)e,t,n=e-n*d,t-n*f,0
o=min(o,128)for n=n,o do rectfill(e,n,t,n)e+=d t+=f end end U"そ☉ぬチ░|█	n1ぬチヘ░██	ntぬチヘ░ス█⁵Eぬチ░ュ\0\0@\0█	noぬチ█░█	nEぬチ░ᵇ█	nzぬチス█⁵E█	tcぬチ█ま█	eTぬチ█░█	thぬチ█😐█	tuぬチそさ😐x█ぬチスx⁵Ex	tcぬチケ█x	eTぬチスx⁵gx	thぬチきスx\rmaxうケ░█😐x	tuぬチ░⁷x	nz███	tsぬチそ█オノムスx	nE█😐ぬま█░tルきスx\rallュ\0\0 \0スx⁵l⁵Mぬまきスp█うスp░スp☉lノムケl██きスx\rminう█う…░ルユアケt░ュ\0\0 \0░まぬまき█ムう█ュ\0\0;\0き█ムうきスx\rabsスl█き█ュ\0\0C\0▤スl░█😐tぬまき█ュ\0\0001\0う█ュ\0\0002\0█ュ\0\0007\0l█ュ\0\0S\0pろらム█ュ\0\0*\0█░█うヘ░さ█	t3ぬチそ█オルうきスx⁵u█チきスx	ng█チぬまス|█tぬまス|░pぬま▤っ█ュ\0\0;\0て█ュ\0\0/\0█😐lぬまひ█ュ\0\0/\0█ュ\0\0;\0hぬまひ█ュ\0\0/\0█ュ\0\0007\0dぬまきスx⁵hうスh█うスd█ケp`ぬまき█ュ\0\0p\0うスh░うスd░█ュ\0\0s\0\\ぬまろら█ュ\0\0+\0█░░ュ\0█\0\0Xぬまアケ`ケXTぬま▤アケ\\█ュ\0\0⬇️\0ろらも█ュ\0\0*\0░░█…ヘ█ュ\0\0☉\0Pぬチきスx	n_うスx	n1うケT░ュ\0@\0\0x	n1ぬチき█ュ\0\0◆\0うスx	ntうケP█ュ\0\0★\0x	ntぬチき█ュ\0\0◆\0うスx	noう█さ█ュ\0\0★\0x	noノスx	nzぬまきスx\rmidう█░うユ…█ノスx	thスx	tu█😐Lぬチき█ュ\0\0p\0うスx	tcうスx	eTケLx⁵Eノヲ█ュ\0\0な\0█😐ぬチ█ュ\0\0と\0x⁵Eぬチ█ぬx	nz██████|█	oU██"eN=1eS=1function J(n,e)return 64+(n-64)*eN,64+(e-64)*eS end function en()eN=W and.75or 1eS=W and 0x.for 1end oI={1,0,0,0,1,0}x={}function h(n,e,t)return n+(e-n)*t end function n_(n,t,e)return mid(n-e,t,n+e)end function n7(n,e,t)local o,e=e[1],e[2]t[1]=o*n[1]+e*n[2]+n[3]t[2]=o*n[4]+e*n[5]+n[6]end function K(n,e,t,d,f,o)e=e or 1o=o or e t=t or 0d=d or 0f=f or 0local l,t=cos(t),sin(t)n[1]=l*e n[2]=-t*o n[3]=d n[4]=t*e n[5]=l*o n[6]=f end function ee(n,e,t)local o,d,h,e,f,u,l,i,r,t,a,c=e[1],e[2],e[3],e[4],e[5],e[6],t[1],t[2],t[3],t[4],t[5],t[6]n[1]=o*l+d*t n[2]=o*i+d*a n[3]=o*r+d*c+h n[4]=e*l+f*t n[5]=e*i+f*a n[6]=e*r+f*c+u end function oP(n,t)for e=1,4do local n,e=n[e],n[e%4+1]line(n[1],n[2],e[1],e[2],t)end end function eL(t,o,n)local e=-128/n return 64+t*e,no+o*e,n end function eI(e,t,n)e-=n1 t-=nt n-=E if(n<8)return
return eL(e,t,n)end function oH(t,o,n,d,f,e,l)t-=n1 o-=nt n-=E d-=n1 f-=nt e-=E if(n<8and e<8)return
if n<8do local e=(8-n)/(e-n)t=h(t,d,e)o=h(o,f,e)n=8elseif e<8do local n=(8-e)/(n-e)d=h(d,t,n)f=h(f,o,n)e=8end local n,t=eL(t,o,n)local e,o=eL(d,f,e)line(n,t,e,o,l)end function oC(n,f)local e,n=u(n),ng(n)local d,t=e%#l.M+1,l.M[e]local o,e,d=l.M[d],l.e1[e],l.e1[d]local l,i,t,o,r,e,n=h(t[1],o[1],n),h(t[2],o[2],n),h(t[3],o[3],n),h(e[1],d[1],n),h(e[2],d[2],n),h(e[3],d[3],n),f/160return h(l,o,n),h(i,r,n),h(t,e,n)end function nq(n,e)local n,e,t=oC(n,e)return eI(n,e,t)end function oM()t5=c[1]and-stat(38)or 0local n=c[1]and stat(34)or 0t6=btn(0)and-1or btn(1)and 1or 0if(btn(3)or c[1]and c[4]>0and abs(stat(39))>=c[4]*10)oW()
if(btnp(2)and d==12)nE=(nE+1)%3ts(t3(),30)
oF=btn(4)or n&1~=0oB=btn(5)or n&2~=0end function t4(e,n)for t in all(n)do local n=1while(n<=#e and e[n].n>t.n)n+=1
add(e,t,n)end end function oG()local n={}t4(n,nc)t4(n,F)for n in all(n)do og(n)end end function og(n)if(n.type==13and d==16and nh)return
if(n.type==17)oV(n)return
local e=n.type==7and w[7].a or n.a if(not e)return
local o=n.type==13and eD(n.e)or n.e local t,d,f=nq(o,n.n)if(not t)return
if(n.i==81)oY(t,d,e.I[1][2])return
local f=-64/f K(x,f,0,t,d)ee(x,x,l.a.nV[u(o)])ee(x,x,n.b)if(n.eY)x[2]*=n.eY x[5]*=n.eY
if(n.type==10and n.B>=49)t0(n.e,n.n,n.e,160)
if(n.type==11)for e=2,n.R do C(n.P[e],x)end C(n.P[1],x)else C(e,x)
end U'そ☉ぬチそさ😐x█ぬチろきスx	o3うス█■typeスx⁵Aス█⁵N█⁵Nノらスx⁵Vろろろム█…░ひム█…░チム█…░もム█…░ヘぬチユ█き░░█⁵Nノム█…░😐ぬチスx	eU█	op██ノらろム█…░█ム█…░そュ\0\0!\0█てぬチスx	t8█	et██ノろム█…░うム█…░てぬチ░|█	et█████ュ\0\0005\0█	omぬチそさ█░t█ぬまオ██xノららムケ██ュ\0\0!\0ろュ\0\0!\0ケ░ュ\0\0"\0ス░■type█ナもきスt\rrnd░ュ\0\0\0¹きスt	e9スt⁵Aぬま█ュ\0\0+\0█ぬまひスt⁵w█ュ\0\0>\0pルきスt‖pairsケpルきスl█うスl░スl☉ぬまス|█hぬまス|░dノムケh██ぬチオう█ュ\0\0!\0う█ュ\0\0000\0う█ュ\0\0000\0う█ュ\0\0000\0う█ュ\0\0!\0█ュ\0\0000\0x⁵bノ█ュ\0\0@\0ぬチス░⁵ex⁵eぬチス░⁵nx⁵nノケ☉ぬチきスt	eDスx⁵ex⁵eぬきスt	omケxぬチムスx⁵Z░ユx	nAぬチスx	nAx	nOノム█ュ\0\0>\0█ムぬチ░ᵇx	nOノム█ュ\0\0>\0░☉ぬチ░⁷t	ePぬきスt	t7█ュ\0\0q\0ノム█ュ\0\0>\0░らぬチも█ュ\0\0H\0きスt	e7█ュ\0\0J\0x	tEぬきスt\raddうろらム█ュ\0\0s\0░ムスt	ncスt⁵F█ュ\0\0q\0█ュ\0\0q\0█ュ\0\0➡️\0█ュ\0\0⧗\0█ュ\0\0∧\0█ュ\0\0い\0ぬまろろム█ュ\0\0>\0█ナム█ュ\0\0>\0░⬆️ム█ュ\0\0>\0░▤`ぬチき█ュ\0\0l\0…きスt	t9ケ`█ュ\0\0!\0x⁵e█ュ\0\0え\0ぬュ\0\0#\0█ュ\0\0q\0█ュ\0\0^\0ケdルき█ュ\0\0U\0う█ュ\0\0V\0█ュ\0\0^\0█ュ\0\0む\0||l█ュ\0\0や\0█⁵T██'function tA(e)for n in all(e)do if n.r and n.eH do K(x,1,n.eH)ee(n.b,n.b,x)elseif not n.r do del(e,n)end end end function oJ(n)del(nc,n)add(F,n)end U"そ☉ぬチそさ😐x█ノムスx⁵d░まぬチ▤ス█⁵nスx	nu█⁵nぬチ▤スx⁵E█うx⁵Eぬチ▤█う░ュ\0⁴\0\0x	nuノヲ█▤░ュ\0\0き\0ぬチ█ら█⁵nぬチろらスx	nh░😐░|x	nxぬチ░もx⁵d████ノム█😐█ノぬチ▤█▤▤█うスx	nx█⁵nぬ█ぬぬ█もぬチ▤█ュ\0\0$\0░ュ\0▮\0\0x	nxぬまろら█ア░ュ\0\0X²░ュ\0\0オ⁷tノヲ█▤ケtぬチ█ュ\0\0000\0█⁵nぬチ░⁷x	eC███████	tOぬチオ███⁵wぬチそさ█░l█ぬま░ュ\0\0¹、xぬまュ\0\0%\0ケxtぬま▤█ュ\0\0F\0░░pぬま▤ケpアュ\0\0%\0▤█ュ\0\0F\0░█░ュ\0\0002\0xぬチ█ュ\0\0A\0l⁵wぬチ█ュ\0\0A\0l	e4ぬま█ュ\0\0000\0hぬま█ュ\0\0M\0dノナケdケh██ぬま█ュ\0\0N\0xぬま█ュ\0\0G\0`ぬま█ュ\0\0O\0\\ぬまュ\0\0%\0█ュ\0\0J\0Xぬま▤█ュ\0\0F\0░☉xぬま█ュ\0\0A\0Tノュ\0\0\"\0ケ`░ユルきスl‖pairsュ\0\0 \0スl⁵wユルきスP█うスP░スP☉ぬまス|█Lぬまス|░HノムケL██ぬチ█ュ\0\0d\0T■typeノナケ\\█スぬュ\0\0#\0スl	e4█ュ\0\0d\0▤█ュ\0\0L\0ア…█ュ\0\0w\0█ュ\0\0M\0█ュ\0\0P\0ノナケX█スぬチ█ュ\0\0A\0T⁵Pぬま█ュ\0\0~\0Dぬま█ュ\0\0M\0@ノナケ@ケDぬチュ\0\0 \0スT⁵P█T⁵aぬま█ュ\0\0G\0<ぬ█ュ\0\0[\0ぬまケ<8ぬま█ュ\0\0M\0004ノナケ4ケ8ぬュ\0\0#\0█ュ\0\0h\0█ュ\0\0d\0ケTぬま▤█ュ\0\0X\0█ュ\0\0M\0d█ュ\0\0y¹ぬま█ュ\0\0G\0000ぬ█ュ\0\0[\0ぬま██,ノヲケ0░ュ\0\0█\0ぬま…█ュ\0\0▤\0█ュ\0\0▥\0000ぬまスl	ow,ノム█ュ\0\0▤\0█ュ\0\0M\0ぬチケ,T■typeぬま▤█ュ\0\0♪\0█ュ\0\0M\0004█ュ\0\0O¹ノム█ュ\0\0▤\0█ュ\0\0I\0ぬチ█ュ\0\0き\0T⁵i█ュ\0\0さ\0ノム█ュ\0\0▤\0█ュ\0\0`\0ぬチ█ュ\0\0き\0T⁵Z█ュ\0\0さ\0ノム█ュ\0\0▤\0█オぬチ█ュ\0\0き\0T⁵r█ュ\0\0さ\0ノム█ュ\0\0▤\0░…ぬチ█ュ\0\0き\0T⁵n█ュ\0\0さ\0ノム█ュ\0\0▤\0░⬆️ぬチ█ュ\0\0き\0T⁵N█ュ\0\0さ\0ノム█ュ\0\0▤\0░▤ぬチ█ュ\0\0き\0T⁵D█ュ\0\0さ\0ノム█ュ\0\0▤\0░うぬチ█ュ\0\0き\0T⁵B█ュ\0\0さ\0ノム█ュ\0\0▤\0░きぬチ█ュ\0\0き\0T	ns█ュ\0\0さ\0ノム█ュ\0\0▤\0░さぬチ█ュ\0\0き\0T⁵H█ュ\0\0さ\0ノム█ュ\0\0▤\0░そぬチ█ュ\0\0き\0T	eH█ュ\0\0さ\0ノム█ュ\0\0▤\0░てぬチ█ュ\0\0き\0T	ob█ュ\0\0さ\0ノム█ュ\0\0▤\0░ぬぬチ█ュ\0\0き\0T	tx█ュ\0\0さ\0ノム█ュ\0\0▤\0░ひぬチ█ュ\0\0き\0T	n3█ュ\0\0さ\0ノム█ュ\0\0▤\0█…ぬチ█ュ\0\0き\0T	et█ュ\0\0さ\0ノム█ュ\0\0▤\0█ノぬチ█ュ\0\0き\0T	tR█ュ\0\0さ\0ノム█ュ\0\0▤\0░らぬチ█ュ\0\0き\0T	eY█ュ\0\0さ\0ノム█ュ\0\0▤\0░ろぬチ█ュ\0\0き\0T⁵R█ュ\0\0さ\0ノム█ュ\0\0▤\0░っぬチ█ュ\0\0き\0T	nR█ュ\0\0さ\0ノム█ュ\0\0▤\0░アぬチ█ュ\0\0き\0T	oZ█ュ\0\0さ\0ノム█ュ\0\0▤\0░オぬチ█ュ\0\0き\0T	eM█ュ\0\0さ\0ノム█ュ\0\0▤\0░ケぬチ█ュ\0\0き\0T	ov█ュ\0\0さ\0ノム█ュ\0\0▤\0░スぬチ█ュ\0\0き\0T	tT█ュ\0\0さ\0ノム█ュ\0\0▤\0░チぬチ█ュ\0\0き\0T	nm█ュ\0\0さ\0ノム█ュ\0\0▤\0░ナぬチ█ュ\0\0き\0T	tN█ュ\0\0さ\0ノム█ュ\0\0▤\0░ノぬチ█ュ\0\0き\0T‖color█ュ\0\0さ\0█ュ\0\0さ\0ノヲ█ュ\0\0▤\0░ュ\0\0@\0ぬま…█ュ\0\0▤\0█ュ\0\0!¹0ぬまアヘュ\0\0'\0█ュ\0\0G\0ュ\0\0&\0█ュ\0\0O\0█ュ\0\0め\0░ュ¹\0\0\0,ぬま█ュ\0\0J\0x█ュ\0\0゛¹ノヲ█ュ\0\0▤\0░ュ\0\0 \0ぬま…█ュ\0\0▤\0█ュ\0\0/¹0ぬま█ュ\0\0003\0,█ュ\0\0゛¹ぬま█ュ\0\0&¹,ぬ█ュ\0\0+¹ノ█ュ\0\0ひ\0ぬまユ█ュ\0\0き\0█ュ\0\0▥\0,█ュ\0\0゛¹ノろ█ュ\0\0っ\0█ュ\0\0ラ\0ぬまア█ュ\0\0き\0█ュ\0\0(¹,█ュ\0\0゛¹ノろろ█ュ\0\0テ\0█ュ\0\0マ\0█ュ\0\0モ\0ぬまユ█ュ\0\0き\0░ュ\0\0\0¹,█ュ\0\0゛¹█ュ\0\0゛¹ぬきスl\raddう█ュ\0\0●\0きスl	nd█ュ\0\0G\0ぬ█ュ\0\0[\0ぬま▤█ュ\0\0⬇️\0█ュ\0\0M\0@█ュ\0\0_¹█ュ\0\0S¹█ュ\0\0c¹ぬュ\0\0#\0█ュ\0\0…\0█ュ\0\0t\0ケHルき█ュ\0\0k\0う█ュ\0\0l\0█ュ\0\0t\0█ュ\0\0o¹||P█ュ\0\0e¹█	oK██"oy={1,1,1,2,3,4,5,6,6,5,4,3,2,1,1,1}n9=9eo=3U'そ☉ぬチそさ😐x█ノムス█■type░らぬチ…░ュ\0\0き\0ス█⁵R█⁵nノムス█⁵i░ュ\0\0E\0ぬきスx⁵Tう░っケ█ぬきスx\rsfx░ュ\0\0$\0ぬチ░ᵇ█⁵r████ノらム█😐░そナ█う░|ぬチひス█⁵P█う█⁵aノらム█😐░さュ\0\0"\0█そ░ュ\0\0Q\0ぬきスx	oQ█も██ノム█そ█ュ\0\0\'\0ぬチ…ス█⁵n░░█⁵nノュ\0\0(\0█ュ\0\0.\0█▤ぬチ█▤█⁵nノム█😐░…ノもっきスx\rflrユスx⁵gスx	n9░も░☉ぬチ░ュ\0\0A\0█⁵i████ノム█😐█ュ\0\0=\0█ュ\0\0A\0ノ█ュ\0\0&\0ぬ█ュ\0\0@\0ぬチ░⁷█	n3██ノス█	nmぬチ░ュ\0\0C\0█⁵i███ュ\0\0A\0██ノム█そ█ュ\0\0?\0ぬきスx	tL█もノろろろろろろろム█😐░█ム█😐░うム█😐░て█ルム█😐█ュ\0\0/\0ム█😐░⬆️ム█😐░▤█ュ\0\0005\0ノ█ュ\0\0005\0ぬュ\0\0#\0スx⁵qきスx⁵uス█⁵eスx	eoぬま█ュ\0\0<\0tノらヲケt█ュ\0\0004\0ュ\0\0(\0█ュ\0\0o\0░きぬチ░ひx	eoノらム█ュ\0\0o\0█ュ\0\0d\0ムき█ュ\0\0i\0ュ\0\0 \0スx⁵o⁵e█ュ\0\0k\0ぬきスx	nfう░ュ\0\0I\0█もノきスx	nT█も█ュ\0\0K\0███ュ\0\0🐱\0ぬチ█ュ\0\0=\0x	eo█ュ\0\0🐱\0█ュ\0\0🐱\0ノ█ュ\0\0C\0ぬま█ュ\0\0k\0pぬまひスx	nNケplノュ\0\0!\0ケlぬまき█ひう█…█もlぬュ\0\0#\0█ュ\0\0♪\0█ュ\0\0🅾️\0█ュ\0\0➡️\0ノき█ュ\0\0█\0う█も█ュ\0\0%\0ぬチ░ュ\0\0L\0█⁵i██ノナ…█▤█ュ\0\0.\0スl⁵Rぬチきスx\rminう░ュ\0\0∧\0▤█ュ\0\0え\0ス█⁵Nl⁵Rぬチ…ス█	tI█ュ\0\0V\0█	tIノも█ュ\0\0す\0█ヲ█ュ\0\0い\0█████ュ\0\0な\0ノム█😐░😐ぬチ▤ス█⁵D█ュ\0\0V\0█⁵Dぬまきスx\rmaxう█ュ\0\0V\0ろろス█	opスx	eU░ュ\0\0001\0hノヲ█ュ\0\0へ\0ケhぬチ█ヲ█⁵Dぬチ░ュ\0\0P\0█⁵iぬチきスx	eWう█ュ\0\0j\0う█ュ\0\0x\0ュ\0\0 \0スx⁵l⁵v█⁵f██ぬ█ュ\0\0▒\0██ノム█😐█ュ\0\0q\0ぬき█ュ\0\0█\0う█も░ュ\0\0(\0██ノム█😐█ュ\0\0;\0ぬ█ュ\0\0▒\0ノらムスx⁵d█ュ\0\0[\0きスx	ed█もぬ█ュ\0\0○\0ぬきスx	tD█もぬ█スノス█	oXぬきスx	tY█も████ノナ█ュ\0\0.\0█ヲ███ュ\0\0ヘ\0██ノム█そ█ュ\0\0I\0ノ█ュ\0\0^\0ノムス█	nS█ュ\0\0/\0ぬチ░ᶠ█	nSぬ█ュ\0\0ろ\0ぬチ░ュ\0\0F\0█⁵i██ノら█ュ\0\0テ\0ス█	nAぬき█ュ\0\0|\0う░ュ\0\0H\0█もノュ\0\0!\0スx⁵Vぬ█ュ\0\0ま\0ノも█ュ\0\0へ\0ス█	et███ュ\0\0ュ\0█ュ\0\0ュ\0█ュ\0\0	¹ノ█ュ\0\0005\0ルうき█ひう░ア█も█ュ\0\0ᶠ¹ぬまス|█dぬまス|░`ぬルうヘ█ュ\0\0V\0█ュ\0\0V\0ぬチ█ュ\0\0■¹d⁵fチ█ュ\0\0⁙¹`⁵f|█チ|ノろろ█ュ\0\0_\0█ュ\0\0b\0█ュ\0\0e\0ぬきスx	tU█も█ナノム█😐█ュ\0\0\r¹ノ█ュ\0\0テ\0ぬ█ュ\0\0○\0ぬ█ュ\0\0ま\0ノヲ█ュ\0\0へ\0█ュ\0\0004\0ぬ█ュ\0\0ろ\0ノらュ\0\0!\0█ュ\0\0ゃ\0ろも▤█ュ\0\0j\0ス█⁵f█ヲヲ█ュ\0\0(¹スx⁵Gぬチヘ█ュ\0\0\'¹█⁵fぬチ█ュ\0\0(¹█⁵e███ュ\0\0001¹███ュ\0\0006¹██ノム█そ█ュ\0\0わ\0ノらら█ュ\0\0ふ\0ュ\0\0(\0█ュ\0\0.\0█ヲ█ュ\0\0テ\0ぬ█ュ\0\0○\0██ぬチ▤ス█⁵B█ュ\0\0V\0█⁵Bぬチ▤█ュ\0\0j\0ユ█ュ\0\0\'¹░ュ\0\0 \0█⁵eぬチろュ\0\0"\0█😐█ュ\0\0ひ\0らヲ█ュ\0\0B¹█ュ\0\0a\0ュ\0\0(\0█ュ\0\0B¹░ス█	nOノヲ█ュ\0\0B¹█ュ\0\0E¹ぬチ█ヲ█⁵Bぬ█ュ\0\0@\0ノ█ュ\0\0ふ\0ぬチ█ケ█	nO██████ノム█そ█ュ\0\0▥\0ぬ█ュ\0\0U\0ぬチ▤█ュ\0\0.\0█ュ\0\0く\0█⁵nノヲ█ュ\0\0.\0█▤ぬ█ュ\0\0003\0ぬきスx	t7█も█ュ\0\0A\0██ノム█そ█ュ\0\0ン\0ノ█ュ\0\0H\0ぬチき█ュ\0\000み\0う█ヲ…█ュ\0\0.\0█ュ\0\0く\0█⁵nノム█ュ\0\0.\0█ヲぬチ█ュ\0\0ワ\0█	nmノきスx	ok█もぬチろら█ュ\0\0H\0█ュ\0\0I\0█ュ\0\0?\0█⁵i██ノららムス█	tP█ュ\0\0y\0ュ\0\0(\0きスx\rabs…█ュ\0\0.\0ュ\0\0 \0█ュ\0\0w\0⁵n█ュ\0\0/\0█ュ\0\0◜\0ぬ█ュ\0\0²¹█████ュ\0\0○¹█ュ\0\0○¹██ノろ█ュ\0\0005\0█ュ\0\0$¹ぬチひ█ュ\0\0"\0スx	tS█⁵a█ュ\0\0⌂¹ノら█ュ\0\0ふ\0ムっ█ュ\0\0007\0█ュ\0\0ひ\0█ヲぬチひ█ュ\0\0"\0▤き█ュ\0\0006\0きスx\rrnd█ュ\0\0/\0█ュ\0\0V\0█⁵a█ュ\0\0⌂¹█ュ\0\0⌂¹█	oj██'function oQ(n)if n.n>-15do n.n=max(-15,n.n-n.N*2)if(n.n==-15)n.n3=nil
elseif n.B==0do n.f=n.f or(rnd()<.5and-1or 1)if(not l.v and(n.e+n.f<0or n.e+n.f>G))n.f=-n.f
n.B=1elseif n.B<49do n.e+=n.f/48n.B+=1else q[u(n.e)]=eo if(u(n.e)==u(o.e)and o.n>=0)nf(73,n)
n.B=(n.B+1)%81end end function ow()return 250+flr(rnd(3))*250end U"そ☉ぬチそさ😐p█ぬまろろムス█■type░░ム█😐░⬆️ム█😐░▤xノム█😐░きぬまス█⁵Stぬチ░ᵇ█⁵Sぬチ…ス█⁵R░██⁵Rぬチ▤ス█⁵nアス█⁵N░も█⁵nノらナ█ア░|ュ\0\0(\0█チ░ュ\0\0き\0ぬチ█ノt■typeぬチュ\0\0 \0ュ\0\0 \0スp⁵wき	ozt⁵aぬチ░⁷t	oXぬチ░ᶠt⁵Zぬチ█ュ\0\0*\0t	eHぬきスp	oJケtぬきスp\rsfx░ュ\0\0&\0██ぬチ█ュ\0\0(\0█⁵Sぬまろろろろろろろろろろろム█😐█オ█⬆️ム█😐░☉ム█😐░…█う█そム█😐░うム█😐░そム█😐░てム█😐█ノム█😐░らム█😐░アlぬまらららケl█もュ\0\0!\0ス█	tHきスp	dnケ█hぬチ█ュ\0\0*\0█	tHノ█もノ█ュ\0\0>\0ぬチ█ろp	ePノ█ュ\0\0N\0ぬきスp	tD█ュ\0\0]\0ぬチ█ろ█⁵rぬまス█	tNdノムきスp■typeケd░!functionぬまき█ュ\0\0i\0██dぬきスp	npうろ█ュ\0\0i\0█ルうス█⁵e█チノュ\0\0!\0ケhぬまきスp⁵Tう░っ█ュ\0\0]\0`ノケxぬルうュ\0\0 \0ス`⁵P☉う█ュ\0\0S\0█…ぬチス|█`⁵aぬチス|░`	nRチス|☉`	eM|ぬき█ュ\0\0000\0░ュ\0\0$\0███ュ\0\0😐\0█ュ\0\0😐\0█ュ\0\0➡️\0█ュ\0\0ˇ\0█ュ\0\0❎\0██ノム█😐░さノス█	n3ぬチ▤█チア█ナ░ュ\0\0 \0█⁵nぬき█ュ\0\0w\0う░オ█ュ\0\0]\0ぬチヲ█チ█ュ\0\0 \0█⁵Sノュ\0\0!\0█も███ュ\0\0え\0█ュ\0\0え\0ノ█ュ\0\0|\0ぬきスp	tU█ュ\0\0]\0█ュ\0\0え\0ノ█ュ\0\0Q\0ぬき█ュ\0\0o\0う█ュ\0\0f\0█ュ\0\0r\0ぬチ…█ア█ュ\0\0=\0█⁵Rノヲ█ア█ルぬ█っぬ█ュ\0\0と\0ノナ█ア░ュ\0\0`\0ぬき█ュ\0\0000\0░ュ\0\0(\0█ュ\0\0え\0ノナ█ア░ュ\0\0000\0ぬき█ュ\0\0000\0░ュ\0\0)\0█ュ\0\0え\0ぬき█ュ\0\0000\0░ュ\0\0*\0█ュ\0\0え\0ぬュ\0\0#\0スp	nNきスp⁵u█ュ\0\0q\0█ュ\0\0*\0█ュ\0\0え\0ノ█ュ\0\0I\0ぬま█も\\ぬ█スノ█ヲぬまき█ュ\0\0w\0う░ヘ█ュ\0\0]\0Xぬチユス\\⁵N█…X⁵NぬチひスX⁵P█アX⁵aぬチ█ュ\0\0(\0X	o_ぬ█っ█ュ\0\0え\0█ュ\0\0え\0█ュ\0\0え\0█	oq██"function ed(n)return u(n.e)==u(o.e)and abs(n.n-o.n)<=2end function nT(n,e)e=e or 0n.n-=n.N if(n.n<=e)n.n=e return true
end function tU(e)local n=e.type==2and 1or e.type==6and 4or 5local e,t=T(n,e),T(n,e)e.i=n==4and 80or 70t.i=e.i e.f,t.f=-1,1if(n~=4)e.nS=1t.nS=1if(n==1)tC(e,1)tC(t,-1)
end function tC(n,e)if(rnd(256)>=eE(A))return
n.type=8n.et=0n.tR=true n.ef=(flr(rnd(4))+1)*e if(rnd(256)<eA(A))n.type=12
n.a=w[n.type].a end function ok(n)if n.ns==0do n.f=n.f or eW(n.e,o.e,l.v)if(n.nm)n.f=-n.f
n.tP=u(n.e)n.de=n.n>0end n.ns+=1local e,t=n.type==8and 16or 32,n.de and-1or 1K(x,1,n.f*t/e/2)ee(n.b,n.b,x)n.b[3],n.b[6]=0,t*12*(1-abs(n.ns/e*2-1))n.e+=n.f/e n.nA=n.ns<=e*.6and not n.nS n.nO=n.ns>e*.6if(n.ns<e)return
sfx(38)n.ns=0n.f=false n.tP=nil n.nA=true n.nO=true if(n.ef and n.ef~=0)n.f=sgn(n.ef)n.ef-=n.f return
if(n.nS)n.nS=2
return true end function tL(n)if(not n.tR)return
eF-=1if(eF>0)return
local e=l.dz or 113eF=V and max(1,flr(e*.6))or e if(d~=12or n.n<=60or el>=d1)return
local n=T(16,n)n.tM=true el+=1end function tD(n)if(n.tM)n.tM=false el=max(0,el-1)
end function t7(n)local e,t=32767,{}for n=1,G do local o=nN[n]and nN[n].R or 0if o<e do e=o t={n}elseif o==e do add(t,n)end end n.e=rnd(t)-.5n.tI=50end function t9(e)local n=flr(rnd(G))+1if(e and not l.v and(n==1or n==G))return t9(e)
return n end function oV(n)local t,o,e=u(n.e),ng(n.e),l.M local e,t=e[t],e[t%#e+1]local e,t=h(e[1],t[1],o),h(e[2],t[2],o)oH(e,t,30+n.n,e,t,190,n.tE and 15or 6)end U"そ☉ぬチオう░ュ\0\0\0¹う░ュ\0\0³¹う░ュ\0\0¹¹う█☉う░ュ\0\0²¹う░ュ\0\0⁴¹う█☉█☉█	tWぬチそさ😐x█ぬチ…スx	eB░█x	eBノも█ろ░|ぬチスx	dtx	eBぬまきスx⁵Tう░ろケ█tぬチひスx	tWスx	eGt	ddぬチきスx\rminう▤█ュ\0\0!\0█って█ュ\0\0 \0x	eGノュ\0\0!\0スx	tFぬチ░⁷x	tFぬきスx⁵y█っ█ュ\0\0,\0█ュ\0\0,\0░ᵇ█	dnぬチそ█らノもきスx\rrnd█░░きぬチ█ュ\0\0,\0x	nJぬきスx⁵j█ュ\0\0,\0ぬき█ュ\0\0.\0░…ぬきスx	npう░ュ\0\0まᵇうュ\0\0 \0スx⁵o⁵eュ\0\0 \0█ュ\0\0G\0⁵nぬュ\0\0)\0ュ\0\0 \0スx⁵l	ei█ケ	nKルきスx\rallスx⁵Fぬまきスt█うスt░スt☉pノムケp████ノムスp⁵Z░ユぬチ█ュ\0\0007\0p⁵rぬまき█ュ\0\0S\0う█ュ\0\0T\0█ュ\0\0Y\0p█ュ\0\0e\0█ュ\0\0b\0tぬき█ュ\0\0E\0う░ュ\0\0オ⁷█ュ\0\0J\0███	tBぬチそ█らノヲスx⁵d░まノュ\0\0!\0スx	erぬチ█ュ\0\0,\0x	erぬチ░ュ\0\0Z\0x	e0ぬチオ██x	ea████ぬきスx\rsfx░ュ\0\0-\0ノ█ュ\0\0w\0ぬま█…█ぬチ█ュ\0\0007\0x	erノム█ム█░ぬチ█ュ\0\0,\0x	e2ぬチき█ュ\0\0$\0うスx	nL░☉x	nLぬき█ュ\0\0.\0░░██ノム█ム█😐ぬき█ュ\0\0.\0█ュ\0\0⌂\0ぬチ█ュ\0\0,\0x	tG██ノム█ム█…ノスx	tgぬきスx	tB████ぬき█ュ\0\0.\0░😐ぬき█ノう░スう█ュ\0\0G\0█っぬき█ュ\0\0🐱\0░ュ\0\0,\0ぬチ█ュ\0\0,\0x	tg██ノム█ム█⬆️ぬきスx\raddうスx	nwオうきスx	nd░ュ\0\0Y\0う█ュ\0\0H\0う█ュ\0\0I\0░ュ\0\0∧\0ぬチ▤スx⁵z█っx⁵zぬき█ュ\0\0.\0ろろらム█ュ\0\0ま\0█っ░▤らム█ュ\0\0ま\0█ュ\0\0🅾️\0░う█ュ\0\0>\0ノム█ュ\0\0ま\0█ュ\0\0⌂\0ぬチろらもスx⁵A█ュ\0\0z\0█ュ\0\0え\0█ケx	ecぬチナスx	ec█ケx	nhぬ█ュ\0\0B\0ノもスx	nl█ケぬチ█ケx	nl█████ュ\0\0キ\0ノム█ム█☉█ュ\0\0う\0█ュ\0\0p\0█ュ\0\0テ\0█	dfぬチそ█らノムス█■type░っぬチュ\0\0!\0きスx	tm█ム█⁵r██ノム█ュ\0\0ヒ\0░オぬチ…ス█	nR█っ█	nRぬチナ█ュ\0\0ユ\0█ケ█⁵r██ノム█ュ\0\0ヒ\0░ナノろュ\0\0!\0ス█	ehュ\0\0!\0ュ\0\0 \0█ュ\0\0ン\0⁵rぬチ█ュ\0\0007\0█⁵r██ぬチ▤ュ\0\0 \0█ュ\0\0ン\0⁵nス█	dl█⁵nぬチュ\0\0 \0█ュ\0\0ン\0⁵e█⁵e██ノムス█⁵i░ュ\0\0N\0ノ█ュ\0\0マ\0ぬチ░ュ\0\0A\0█⁵iぬチュ\0\0 \0ス█⁵P░█⁵aぬきスx⁵Kス█⁵bぬまヘ█ュ\0\0🅾️\0tノナケt█ュ\0\0🅾️\0██ぬまき█ノう█ュ\0\0ワ\0█ムpぬチア█ュ\0\0◀¹█ュ\0\0よ\0p	dlぬチ█ムp	ehぬま▤█ュ\0\0◀¹█っt█ュ\0\0$¹██ノム█ュ\0\0	¹█ュ\0\0ᶜ¹ぬま…ス█⁵n█ュ\0\0I\0lノららムきスx⁵uス█⁵eき█ュ\0\0.¹█ュ\0\0H\0ヲケl█ケュ\0\0(\0█ュ\0\0003¹ス█	txぬまき█ノう█ュ\0\0フ\0█ムhぬルうュ\0\0 \0スh⁵P░う░ュ\0\0001\0█ュ\0\0⌂\0ぬチス|█h⁵aぬチス|░h	nRチス|☉h	eM|ぬきスx	dfス█	dd█ュ\0\0◝\0ノきスx	nT█ム█ュ\0\0◝\0█████	tV██"function tm(n)n.D+=1n.tT+=n.ov K(n.b,h(n.oZ,n.eM,n.D/n.nR),n.tT)return n.D>=n.nR end o={}function j(n)tp=n sfx(n and 37or-1,3)end function nf(e,n)if(d~=12and(d~=15or n.type~=17))return
y(e==72and 10or n.type==16and 11or 12)o.i=e o.H=0di=n j(false)nJ=false eu=120d=17if(e==73)o.a=dr else o.e=n.e
end function oW()if(d==12and tG and not nb)nI=-2eg=E nb=true sfx(43)
end function tY(n)if(n.eV)n.eV.nZ=max(0,n.eV.nZ-1)else nv=max(0,nv-1)
end function d0(e)if(e2 and e.N<4.5)e.N=4.5
e.n+=e.N if e.n>160do e.r=false else for n in all(F)do if e.r and n.r and n.nO and(n.type~=11or not n.S)and u(e.e)==u(n.e)and abs(e.n-n.n)<(e.tx or 6)do if n.type==9do n.S=e return elseif n.type==10and n.n3 do n.S=true e.r=false else if n.type==11do n.S=e if(n.R>1)e.r=false
elseif not n.n3 do n.S=true end if(n.type~=11and(not e.ob or n.n3 and not n.o_ or n.type==17and n.tE))e.r=false
end end end end if(not e.r)tY(e)
end function da(n)local e for n in all(F)do if(n.r and n.Z==29and n.type~=17and(not e or n.n<e.n))e=n
end n.D+=1if n.D>5do n.nZ=n.nZ or 0if(n.nZ<8)local e=T(14,n)e.eV=n n.nZ+=1
n.D=0end if ng(n.e)==.5do if(not e)return
n.f=eW(n.e,e.e,l.v)if(n.f==0)n.f=1
if(not l.v and(n.e==.5and n.f<0or n.e==G-.5and n.f>0))n.f=-n.f
end n.e=em(n.e+n.f/16)end U'そ☉ぬチそさ😐x█ノムスx⁵d░もぬきスx	tOケ███ノム█😐░まぬ█きノ█⬆️██ぬチきスx\rmaxう░|…スx	nL░█x	nLノュ\0\0"\0スx	t5█ひぬまユ▤ュ\0\0 \0スx⁵c☉█も░😐tぬチきスx\rmidうヘケtうユアヘ█オ▤ュ\0\0 \0█ス░█も░ュ\0\0\0¹█ル█⁵Hノららスx	oFもスx	nv░うュ\0\0(\0█ま█ひぬきスx⁵Tうろらスx	e2░チ░ひう█う█もぬきスx\rsfx░ュ\0\0#\0ぬチ▤█ュ\0\0+\0█もx	nvぬまろら█ュ\0\0002\0░☉ろらスx⁵V█ュ\0\0,\0█ノpぬチケpx	nLノららスx	oBュ\0\0!\0スx	tpヲスx	nl█ひぬきスx⁵j░⁷ノナ█ュ\0\0L\0█ひぬきスx⁵y░ぬぬチ…█ュ\0\0L\0█もx	nlぬチ▤ス█⁵eス█⁵H█⁵eノスx	nbぬチ▤ス█⁵nスx	nI█⁵nぬチ▤█ュ\0\0^\0░ュ■ᶜ\0\0x	nIぬチ▤スx	eg█ュ\0\0]\0x⁵Eノらヲ█ュ\0\0^\0█ひヲ█ュ\0\0]\0█ひぬチ█ひ█⁵nぬチ█ュ\0\0d\0x⁵Eぬチ█ひx	nIぬチ░ᵇx	nbぬチきスx	em█ュ\0\0X\0█⁵eぬま…█ュ\0\0,\0きスx\rflrアきスx	ng█ュ\0\0X\0█ュ\0\0,\0lぬチひス█⁵Pケl█⁵aぬュ\0\0#\0スx⁵qきスx⁵u█ュ\0\0X\0█ノ███ュ\0\0░\0█ュ\0\0░\0█ュ\0\0◆\0█ュ\0\0🅾️\0█ュ\0\0⧗\0ノムスx	t6ヘ█もノナ█ュ\0\0Y\0█ひぬチ█ひ█⁵H█ュ\0\0▥\0ぬチき█ぬう…█ュ\0\0Y\0░ュ\0⁴\0\0ヘ░ュA_\0\0█⁵H█ュ\0\0▥\0ノム█ュ\0\0う\0█もノも█ュ\0\0Y\0█ひ█ュ\0\0く\0ぬチきスx\rminう▤█ュ\0\0Y\0█ュ\0\0け\0█ュ\0\0さ\0█⁵H█ュ\0\0▥\0█ュ\0\0く\0█ュ\0\0ほ\0█	tJぬチそ█☉ノ█ュ\0\0J\0██ノムっスx⁵g█ノ█ひぬまスx	nJtルきスx\rallスx⁵Fぬまきスp█うスp░スp☉lノム█ュ\0\0z\0██ぬき█ュ\0\0O\0█ュ\0\0m\0ぬチ█ュ\0\0m\0x	nJ██ノららららららスl⁵rムスl⁵Z░ユュ\0\0"\0スl⁵i░ュ\0\0Q\0ュ\0\0"\0スl■type░らュ\0\0"\0█ュ\0\0ソ\0░きろ█ュ\0\0M\0ュ\0\0"\0█ュ\0\0ソ\0█…ュ\0\0!\0スl	n3ノム█ュ\0\0ソ\0░そぬチ█ひl⁵Rぬチ█ュ\0\0z\0x	esぬチ█ュ\0\0P\0l⁵Sぬチらュ\0\0!\0█ル█ュ\0\0M\0l	tHノ█ュ\0\0ム\0ノも█ュ\0\0L\0█ひぬ█ュ\0\0イ\0████ぬまき█ュ\0\0を\0う█ュ\0\0ん\0█ュ\0\0z\0l█ュ\0\0ョ\0█ュ\0\0ン\0█ュ\0\0レ\0p███	d2██'ep={}dc={2,8,5}ny=.01function nj()return rnd(2)-1,rnd(2)-1,rnd(1)end function eJ(n)local e,t=n*.382,(n%8+1)/8return cos(e)*t,sin(e)*t,n/64end function dh(n)local e,t=n/8,(n%8+1)/8return cos(e)*t,sin(e)*t,n/64end function eK(n)local e,t=n/64,.5+n%2/2return cos(e)*t,sin(e)*t,n/64end function tK(n)du(({nj,eJ,dh,eK})[(n-1)%4+1])end function du(n)ni=n or nj ny=.01tw=(ni==eJ or ni==eK)and.35or 0for n=1,64do local e,t,o=ni(n)local f,l,d=n<=32and 3or dc[(n-33)%3+1],ni==nj and 1or min(1,tw+(1-o)*2),(ni==eJ or ni==eK)and.1/sqrt(e*e+t*t)or 0ep[n]={tb=e,tZ=t,nD=o,ds=f,nQ=l,tv=e*d,ty=t*d}end end function e3()ny=.01+nx/32for n in all(ep)do n.nD-=ny if n.nD<=.05do if(ni==nj)n.tb,n.tZ=rnd(2)-1,rnd(2)-1else n.nQ=tw
n.nD=1end if(ni~=nj)n.nQ=min(1,n.nQ+max(.02,ny))
end end function tj()for n in all(ep)do local e,t,o=n.nD+ny,n.tv+(n.tb-n.tv)*n.nQ,n.ty+(n.tZ-n.ty)*n.nQ eR(64+t/e*32,no+o/e*32,64+t/n.nD*32,no+o/n.nD*32,n.ds)end end function e5(n)n+=1if(@n==0)return(@(n+1)|@(n+2)<<8)+1
return n end function d3(n)n=e5(n)local t,e=@n,{nK=@(n+1),ew={}}n+=2for t=1,t do add(e.ew,{type=@n,tQ=@(n+1)|@(n+2)<<8})n+=3end return e end function eb(n)n=e5(n)local o,e={},@n n+=1for e=1,e do local e,t,d={},@n,@(n+1)if(t>=128)t-=256
add(e,t)for t=1,d do local n=@(n+1+t)if(n>=128)n-=256
add(e,n)end add(o,e)n+=2+d end return o end function tX(n)n=e5(n)local o,e={},@n n+=1for e=1,e do local e,t=@n,@(n+1)if(e>=128)e-=256
if(t>=128)t-=256
add(o,{e,t})n+=2end return o end function nd(n)return{O=tX(nW[n]),I=eb(nn[n])}end function d5(n)n=e5(n)local e={n5=@n,eZ=@(n+1),v=@(n+2)~=0,nV={}}n+=3for t=1,e.n5 do local t=@n if(t>=128)t-=256
add(e.nV,t)n+=1end return e end function d6()tr={}local e="ABCDEFGHIJKLMNOPQRSTUVWXYZ!1234567890"for n=1,#e do tr[sub(e,n,n)]=nd(91+n-1)end w[9].oz=nd(80)dr=nd(81)ev={}for n=0,5do add(ev,nd(82+n))end d4=nd(90)end function d8(n)for n in all(n.ew)do n.ey=flr(n.tQ/2)end end function d9()local e=l.ei if(e.nK<=0)return
for n in all(e.ew)do n.ey-=1if n.ey<0and e.nK>0do if(n.type~=3or not eP)T(n.type)
n.ey=n.tQ e.nK-=1end end end nN={}l={}n6={}nr={}tk={O=n6}tq={O=nr}n0={O={},I={}}function tz(n,e)for e=1,#n do n[e]=nil end for e=1,e do n[e]={0,0}end end function d7()local n=#l.a.O n0.O={}n0.I={{-1,11}}for n=1,n do add(n0.O,n6[n])end for e=1,n do add(n0.O,nr[e])add(n0.I,{-4,e,e+n})end end function t_()local o=E+8ej=o<190if(not ej)return
for n=1,#l.M do local t,e=l.M[n],l.e1[n]local d,o=mid(0,(o-t[3])/(e[3]-t[3]),1),max(t[3],o)n6[n][1],n6[n][2]=eI(h(t[1],e[1],d),h(t[2],e[2],d),o)nr[n][1],nr[n][2]=eI(e[1],e[2],e[3])end end function on()C(tk)C(tq)n0.I[1][2]=nY>0and 15or 11end function eQ(n)local e=n%#nr+1return{n6[n],n6[e],nr[e],nr[n]}end function u(n)return min(flr(n+1),l.n5)end function ng(n)return n%1end function eD(n)return flr(n)+.5end function em(n)return l.v and n%G or mid(0,n,G-.00002)end function eW(n,e,t)local n=e-n if(t)n=(n+G/2)%G-G/2
if(n<0)return-1
if(n>0)return 1
return 0end oe={5,11,1,2,9,3,18,19,20,4,14,10,17,6,16,22,24,23,27,25,21,28,29,30,32,33,34,35,36,37,26,31}function dE(e)local n={}n.a={I={},nV={}}n.ei=d3(tl[e])local e=oe[(e-1)%#oe+1]n.a.O=tX(nW[e])n.a.I=eb(nn[e])local e=d5(tf[e])n.n5=e.n5 n.eZ=e.eZ n.v=e.v for t in all(e.nV)do local e={1,0,0,0,1,0}K(e,1,.5-t/256)add(n.a.nV,e)end return n end function dA(n)l=dE(n)dO(l)l.M={}l.e1={}for n in all(l.a.O)do add(l.M,{n[1]*4,n[2]*4,30})add(l.e1,{n[1]*4,n[2]*4,190})end G=l.n5 nN={}tz(n6,#l.a.O)tz(nr,#l.a.O)d7()tk.I=l.a.I tq.I=l.a.I end function dO(n)for n in all(n.a.O)do n[1]=8-n[1]n[2]=8-n[2]end end function eX(n,e)ex(eO[flr((n-1)/16)+1])if(e)dA(n)
end U"そ☉ぬチそ██ぬま…ケ█░█xアア▤アケx░ュ\0\0っ\0░ュ\0\0(\n░ュ¹\0\0\0█⬆️█	o1ぬチそさ😐x█ぬチ░|x	elぬチ░ᵇx	eP███	otぬチそ█ろぬチオ██x⁵Fノ█░ぬチオスx⁵ox	ncぬュ\0\0)\0█ユ…ュ\0\0 \0スx⁵l	eZ░ュ\0█\0\0⁵e██ぬチ█ヘx	ncぬチきスx⁵T░ぬx⁵o█ュ\0\0%\0█	ooぬチそ█ろぬチ░ろx⁵dぬチ█☉x⁵sぬチ█っx⁵_ぬチ█☉x⁵Aぬチ█っx	naぬチ█☉x	ekぬルう█っ█ヘぬチス|█x	nYチス|░x	nw|ぬチ░☉x	nUぬチ█っx⁵gぬチ░ュ\0\0q\0x	eFぬチ░もx	t8ぬチ░うx	eUぬチ█っx⁵zぬチ█っx	ecぬチ█オx	nhぬチ█ヘx	nPぬチ█オx	d_ぬチ█オx	erぬチ█っx	e0ぬチ█っx	eqぬチ█オx	nJぬチ░ᶠx	of███	odぬチそ█ろぬきスx⁵j█オノナスx⁵z░░ぬ█ュ\0\0I\0ノナ█░░ュ\0\0c\0ぬま█☉█ノスx⁵Vノナ█░スx	n4ぬチ█░x	n4ぬきスx	nH██ぬきスx	eXう█░ュ\0\0!\0ケ░ノ█ュ\0\0|\0ぬルう█っうヘ█☉うヘ░ュ\0\0き\0░ュ\0\0@\0ぬチ█ュ\0\0:\0x	n1ぬチ█ュ\0\0<\0x	ntぬチス|☉x⁵Eチス|😐x	no|ぬチ█オx	tFぬチ█☉x	eGぬチきスx	oAう█░█ュ\0\0t\0x	nPぬチュ\0\0 \0スx	nP	oOx	dtぬチ█っx	eBぬチュ\0\0 \0█ュ\0\0∧\0	oxx	d1ぬチュ\0\0 \0█ュ\0\0∧\0	oRx	t8ぬチュ\0\0 \0█ュ\0\0∧\0	oTx	eUぬきスx	ot██ぬチュ\0\0 \0█ュ\0\0∧\0	n9x	n9ノ█ュ\0\0|\0ぬきスx	tK█░ぬチ░ひx⁵dぬきスx	tsうきスx	t3██░ュ\0\0x\0ぬチ█っx	nvぬルう█オう█オ█オぬチ█ュ\0\0:\0x	e2ぬチ█ュ\0\0<\0x	tgチ█ュ\0\0☉\0x	tG|ぬチ█☉x	nlぬ█ュ\0\0Q\0ノナ█░█☉ぬきスx⁵y░まぬチ█っx	nLぬチ█っx	nIぬチスx⁵Ex	egぬチ█オx	nbぬルう█っ█っぬチ█ュ\0\0:\0x	nuチ█ュ\0\0<\0x	nx|ぬチ█オx	eCぬきスx	oo█オノ█ュ\0\0{\0ぬュ\0\0)\0█ユ…█ュ\0\0ゆ\0░ル⁵nぬュ\0\0)\0█ユユヘュ\0\0 \0█ユ⁵n█ュ\0\0つ\0⁵Nぬチ░ュ\0\0ユ\0x	fnぬチ█オx	dxノュ\0\0!\0スx	ofぬきスx‖music█っぬチ░⁷x	dxぬチ█░x	ofぬきスx	d8ュ\0\0 \0█ュ\0\0 \0	ei███ュ\0\0ツ\0█ュ\0\0ネ\0█ュ\0\0メ\0█ュ\0\0レ\0█ュ\0\0¹¹█ュ\0\0⁴¹ノナ█░スx⁵mぬチ█░x⁵m█ュ\0\0⁵¹█ュ\0\0⁴¹█ュ\0\0\r¹█ュ\0\0ᶠ¹█	ezぬチそ█ろぬき█ュ\0\0z\0う█░█ュ\0\0シ\0ぬき█ュ\0\0ん\0█ュ\0\0シ\0ぬュ\0\0)\0█ユ█ュ\0\0█\0⁵nぬュ\0\0)\0█ユ█っ⁵Hぬルう█っう█ュ\0\0○\0ヘ░スぬ█ュ\0\0●\0ぬ█ュ\0\0♥\0█ュ\0\0웃\0|ぬ█ュ\0\0く\0ぬチ█ヘx⁵q███	dRぬチそ█ろぬき█ュ\0\0z\0うスx⁵A█ュ\0\0シ\0ぬチ█っx	nxぬき█ュ\0\0さ\0█ュ\0\0+¹ぬま█っtルきスx\rallュ\0\0 \0█ュ\0\0 \0⁵Mぬまきスp█うスp░スp☉lノムケl██ぬルう█っう█っう…█ュ\0\0ゃ\0ユア░そケt█ュ\0\0@\0░ュ\0\0/\0█ュ\0\0🅾️\0|██ぬまきスx\rmaxう█ュ\0\0=¹うきスx\rabsスl█き█ュ\0\0H¹スl░tぬまき█ュ\0\0004¹う█ュ\0\0005¹█ュ\0\0:¹l█ュ\0\0V¹p█	olぬチそ█ろぬチ…スx	nU█☉x	nUノヲ█ュ\0\0_¹█っぬきスx	ez█ュ\0\0+¹██ぬチ█っx	nUぬきスx	e_█████	dTぬチそ█ろぬ█ュ\0\0を\0ノム█ュ\0\0+¹█ュ\0\0q\0█ュ\0\0i¹ぬチ▤█ュ\0\0+¹█☉x⁵Aノらスx	nhナスx	ec█っぬチ…█ュ\0\0s¹█☉x	ecぬきスx	dR█ュ\0\0+¹██ノ█ュ\0\0r¹ぬ█ュ\0\0K\0ぬ█ュ\0\0I\0ぬ█ュ\0\0d¹ぬチ█ュ\0\0@\0x	eq███ュ\0\0~¹█	dN██"function dS(n)nb=false nI=0nu,nx=0,0j(false)nv=0for n in all(nc)do if(n.type==14)n.r=false
end d=15if(n)y(14)
end function dL()local n=nF(V and 17or 16)dI=n[5]if(not V)Q=true m=99nH()
fe=180d=19music(-1)j(false)end function dD()if(d~=12)return
if(l.ei.nK>0)return
local e for n in all(F)do if(n.r and n.type==17)e=true
if(n.r and n.nA and n.type~=16and n.type~=17)return
end if(A==99)dL()return
dS(e)end oi,o0={},{}function dY()for n=0,7do local e=nd(128+n)add(oi,e)add(o0,{O=e.O,I=eb(nn[136+n])})end end function oa(e,t,n,o,d)local n=n/120local e={n,0,e,0,n,t}for n in all(d and o0 or oi)do n.I[1][2]=o or 7C(n,e)end end c={false,3,9,0}W=false L=1nX=false m=1n4=1function dU()cartdata"tempest2000v09"n2,p={},{}for n=0,4do add(n2,dget(n))end for n=7,46do add(p,dget(n))end if(n2[5]==0)o2()
X=dget(5)m=mid(1,X&127,99)Q=X>=128X=dget(6)if(X>0)c={X&1>0,X>>1&15,X>>5&15,X>>9&7}W=X&4096>0n4=mid(1,X>>13,99)
if(Q)m=99
en()end function oc()for n=1,5do dset(n-1,n2[n])end for n=1,40do dset(n+6,p[n])end nH()end function oh()menuitem(1,"crt adjust:"..(W and"on"or"off"),function()W=not W en()nH()oh()return true end)end function nH()dset(5,m|(Q and 128or 0))dset(6,(c[1]and 1or 0)|c[2]<<1|c[3]<<5|c[4]<<9|(W and 4096or 0)|n4<<13)end function o2()m=1n4=1Q=false c={false,3,9,0}W=false en()eN=1eS=1n2={0xa.604,0x7.d,6.4087,4.7928,.76294}p={}for n in all(split"YAK,DAVE,ZAPHOD,LISTER,JOOLS")do for e=1,8do add(p,e<=#n and ord(n,e)-64or 0)end end oc()end function e_()d=13music(-1)j(false)for n=1,5do if(na>n2[n])add(n2,na,n)deli(n2,6)for n=40,n*8+1,-1do p[n]=p[n-8]end for e=1,8do p[(n-1)*8+e]=0end n8,e6=n,1return
end end function dP()local n,e="",(n8-1)*8+1for t=0,7do local e=p[e+t]if(e<=0)break
n..=chr(64+e)end if n=="KRYTEN"do Q=true m=99elseif n=="RIMMER"do m=99elseif n=="HOLLY"do Q=true m=99n4=99end end ea={}function y(n)n=nF(n)n[3]+=n[4]ea={n}end function np(n,e,t)na+=n*.00002local n=ev[n==2000and 5or n\250]if(n)add(nw,{n,e,t,150})
end function dH()for n in all(ea)do n[3]-=1if(n[3]<=0)del(ea,n)
local t,o=n[2]+32,split(n[5],"|")local e=120/(5*#o[1]-1)local d,f=e*(abs(g*2%256-127)-63)/128,e*min(1,n[3]/20)t-=4*e*(#o-1)for n in all(o)do local o=64-(5*#n-1)*e/2ne(n,o,t,e,f,nil,d)t+=8*e end end end function dC()if e0>0do local n=90-e0 if(n%30<21)local n=(n\30+1)*128/66K(x,n,0,64,64)C(d4,x)
e0-=1end?"score:"..tostr(na,2),1,1+Y,1
?"score:"..tostr(na,2),0,0+Y,3
local e=z>=3and 15or 6?"warp:",1,9+Y,1
local n=print("warp:",0,8+Y,3)for t=1,z do n=print(chr(143),n,8+Y,e)end?"lives:"..nU,97,1+Y,1
?"lives:"..nU,96,0+Y,3
?"stage:"..A,96,8+Y,3
dH()end q={}function _init()ex(eO[1])oL()oK()d6()dY()dU()V=false od()poke(24365,c[1]and 5or 0)end U'そ☉ぬチそさ😐x█ノムスx⁵s░░ぬきスx	e3██ノスx	tnノろケ█きスx■btnp░…ぬチ░ᵇx	tn████ノスx	nXノ█さぬきスx	o2██ぬきスx■pokeう░ュ\0\0-_░|ぬチ█まx	nX██ノ█ぬ█ム██ノスx	nCぬチ▤スx⁵_スx	oux⁵_ノヲきスx\rabs█ュ\0\0"\0░ュ\0\0█\0ノム█ュ\0\0!\0█チぬチ█チx⁵_ぬチ▤スx	naきスx	o1スx⁵Ax	naぬチ▤⬆️ユ█ュ\0\0,\0░ュ N\0\0░██ュ\0\0004\0x	ekぬきスx	ezう█ュ\0\0.\0░⁷ぬチ░ᶠx	nC██ぬチ█ュ\0\0!\0x⁵sぬチヘ█ュ\0\0"\0x⁵_ぬチ█ュ\0\0004\0x⁵Lノ█⬆️ぬきスx	ol███ュ\0\0>\0ノム█😐█ュ\0\0004\0ぬきスx	exュ\0\0 \0スx	eO█ぬチ░ュ\0\0@\0x	no█ュ\0\0>\0█ュ\0\0>\0██ノュ\0\0"\0█ュ\0\0"\0█チぬチきスx	n_う█ュ\0\0"\0う█チ░もx⁵_██ぬきスx	dW█さノら█ぬュ\0\0"\0█😐█ュ\0\0004\0ぬチ█ュ\0\0004\0x	nCぬチ█ュ\0\0]\0x	ou██ノ█さぬきスx	dF███████ュ\0\0t\0█	dMぬチそ█☉ノ█ュ\0\0J\0ろらスx⁵Q░➡️start game,beastly game,options,data░]start game,options,dataノム█😐░☉░とmouse,sensitivity,max lanes,jump,crt adjustノム█😐░😐░Yhigh scores,reset dataュ\0\0*\0░。stage: ュ\0\0*\0█ュ\0\0.\0ュ\0\0*\0░%  bonus: ュ\0\0*\0きスx‖tostrう█ュ\0\0/\0█…░み,up/down: stage +/- 1,left/right: stage +/- 10█	dBぬチそ█☉ろろら█ュ\0\0J\0░ュ\0\0T\0ら█⬆️░ュ\0\0X\0░ュ\0\0H\0█	dGぬチそ█☉ノ█⬆️ぬまろろろろらき█そ█…█ュ\0\0004\0らき█そ█ュ\0\0~\0ヘ█ュ\0\0004\0らき█そ█チヘ░さらき█そ█ュ\0\0004\0█ュ\0\0こ\0█チtぬチきスx\rmidう█ュ\0\0004\0う▤█ュ\0\0.\0ケtろらスx⁵Vスx	n4ろら█ュ\0\0y\0░ュ\0\0c\0スx⁵mx⁵Aノュ\0\0"\0█ュ\0\0と\0█チぬ█ュ\0\0H\0████ノ█ュ\0\0○\0ノろ█ュ\0\0う\0█ュ\0\0お\0ぬチ▤っ▤スx⁵Lろら█ュ\0\0お\0█チヘ█…█て█ュ\0\0004\0x⁵Lノららュ\0\0!\0ュ\0\0 \0スx⁵c█ナ█ュ\0\0り\0█ュ\0\0004\0も█ュ\0\0り\0█てぬチろら█ュ\0\0お\0█て█ュ\0\0004\0x⁵L████ノろろ█ュ\0\0け\0█ュ\0\0せ\0█さぬまろら█ュ\0\0け\0█ュ\0\0か\0█ュ\0\0004\0pノム█ュ\0\0り\0█ュ\0\0004\0ぬュ\0\0)\0█ュ\0\0ゃ\0█ュ\0\0ょ\0█ぬき█ケう█スろら█ュ\0\0ゅ\0█て█チぬきスx	nH████ノム█ュ\0\0り\0█てぬチュ\0\0!\0スx⁵Wx⁵Wぬきスx	en██ぬきスx	oh███ュ\0\0ネ\0ぬま█ュ\0\0り\0hぬュ\0\0#\0█ュ\0\0ゃ\0ケhっ▤ひ█ュ\0\0ゃ\0█ュ\0\0ラ\0ケpろらも█ュ\0\0ラ\0█ュ\0\0▒\0█ュ\0\0]\0░⬆️█ュ\0\0ネ\0██ノ█ュ\0\0ら\0ぬまろろら█ュ\0\0J\0ろら█ュ\0\0y\0█ュ\0\0▒\0█ュ\0\0~\0ら█ュ\0\0🐱\0█…█ュ\0\0▒\0lぬチ▤っ█ュ\0\0わ\0ケl█ュ\0\0004\0x⁵L█████	dWぬチそ█☉ノら█ュ\0\0🐱\0ム█ュ\0\0り\0█…ぬチ█ュ\0\0009\0x	nX█ュ\0\0009\0ぬチヘ█ュ\0\0]\0x	ouノ█ュ\0\0J\0ぬまろら█ュ\0\0y\0█ュ\0\0004\0█チtぬチ█ュ\0\0‖¹x⁵Vぬチろろらュ\0\0(\0█ュ\0\0り\0▤█ュ\0\0004\0█ュ\0\0と\0█…らム█ュ\0\0り\0▤█…█ュ\0\0と\0█ュ\0\0~\0█ュ\0\0▒\0x	nC█まノ█⬆️ぬチ█チx	nC█まノ█ュ\0\0🐱\0ぬチ█ュ\0\0009\0x	tn█ま█ま█	dF██'function dg()eu-=1if o.i==73do E-=1K(o.b,16-eu/8,eu*0x.0c)elseif o.n<160do o.n+=2.25di.n=o.n else E-=8end if(eu<=0)dT()
end U"そ☉ぬチそさ😐x█ノスx	n8ぬまろらきスx■btnp░░ヘ░█らき█…░☉█うtノケtぬま▤ア…█😐█う░うスx	e6pぬュ\0\0#\0スx⁵pケpっ▤ひ█ス█チ█も░ヘノき█…░😐ぬチ▤█ア█うx	e6ノろナ█ア█ろき█…░…ノ█😐ぬきスx	dP██ぬきスx	oc██ぬチ░ᶠx	n8███ュ\0\0-\0███ュ\0\0000\0█ュ\0\0002\0ノ█ヲぬきスx	od███████	dVぬチそ█☉ノろ█ヲ█ュ\0\0$\0ぬきスx	e_███████	dmぬチそ█☉ぬきスx	e3██ぬチオ██x⁵qぬュ\0\0)\0スx⁵oきスx\rminう░|▤ュ\0\0 \0█ュ\0\0I\0⁵nュ\0\0 \0█ュ\0\0I\0⁵N⁵nノュ\0\0!\0スx	nzぬチ░てx⁵d█████	dp██"function dJ()local e=d==12q={}e3()oM()tJ(o)for n in all(nc)do if n.r do if n.type==14do d0(n)elseif n.type==23do if(e)da(n)else n.r=false
end end end if(e)d2()d9()
for n in all(F)do if(n.Z==29and n.S)oq(n)
end for n in all(F)do if n.r do if n.Z==29or n.type==17or n.type==16do oj(n)if(not e and n.type==17and u(n.e)==u(o.e)and o.n>=n.n and o.n<160)nf(73,n)
elseif n.Z==30do tV(n)end n.e=em(n.e)end end if e do if(na>=ek*.30518)nU+=1ek+=1nY=60
dD()end end U"そ☉ぬチ███⁵Uぬチそさ😐x█ぬチオ██x⁵qぬきスx	e3██ぬきスx	tJスx⁵oルきスx\rallスx⁵Fぬまきスt█うスt░スt☉pノムケp██ノスx	eCぬきスx	dN██░⁷██ノらムスp⁵Z░ルスp⁵rぬきスx	tV█オぬまき█まう█も█オp█ュ\0\0*\0█ュ\0\0'\0t█	dKぬチそ█😐ぬきスx	tAスx	ncぬき█ュ\0\0002\0█ぬぬきスx	oUュ\0\0 \0█さ⁵e███	dw██"function _update60()if(W)Y=4else Y=0
g+=1local n=c[1]and stat(34)>0local e=btnp(4)or n and not db db=n if(d==19)td(flr(g/16))else td(g)
tS=oy[flr(g/n9)%16+1]w[7].a=w[7].P[tS]if(d==18)dM(e)return
if(d==17)dg()
if(d==13)dV()return
if(d==19)dm()return
if d==14do dp()elseif d==12or d==15do dJ()elseif d==16do if(dK())return
end dw()end function dZ(n,e)e=(e or 72)-Y local t,o=split(n),24+_ for n=1,#t do local t=t[n]if(s==3)t..=" "..(n==1and(c[1]and"on"or"off")or n==5and(W and"on"or"off")or n<4and(c[n]+1)/4or c[n]>0and c[n]*10or"off")
local d=s==3and n>1and n<5and not c[1]and 1or 3?t,o,e+n*8,d
if(n==L)?">",o-8,e+n*8,3
end end function os()ne("CHAMPIONS",7,10,2.5)for n=1,5do local t=""for e=1,8do local n=p[(n-1)*8+e]t..=n>0and chr(64+n)or" "end local e=22+n*12ne(tostr(n),0,e+3,1,nil,nil,nil,6)ne(t,18,e+3,1,nil,nil,nil,6)ne(tostr(n2[n],2),76,e+3,1,nil,nil,nil,6)end if(n8)?"^",20+(e6-1)*4,23+n8*12
end function dv()tj()t_()for n=1,l.n5 do ta(eQ(n),n%2>0and 12or 13)end on()C(n0)end function dy()if(tn)os()return
if s==2do dv()else oa(0,0,120,5)oa(0,0,120,2,1)ne("2000",5,48,6,3,0)ne("2000",5,47,6,3,4)if nX do?"this will erase all",26,88,3
?"settings and high scores.",18,96,3
?"are you sure?",38,104,3
?"🅾️ yes  ❎ no",34,116,3
return end if s==1do?nF(18)[5],0,64-Y,3
?nF(19)[5],2,72-Y,3
?nF(20)[5],1,80-Y,3
end end dZ(dB(),dG())?"🅾️ to select ❎ to return",12,122-Y,3
end function dj()t_()tj()if(not ej)return
if(d>=15and d<17)fillp(~(-1<<min(16,o.n/5)),true)
for n=1,l.n5 do ta(eQ(n),n%2>0and 12or 13)end fillp()on()end function dQ()if(nY<=0and#nw==0)return
fillp(23130,true)if(nY>0)K(x,8-nY/7.5,0,64,64)poke(24414,85)C(ev[6],x)nY-=1
poke(24414,187)for n in all(nw)do local e,t,o=nq(n[2],n[3])if(e)K(x,64/o,0,e,t)C(n[1],x)
n[3]-=1n[4]-=1if(n[4]<0)del(nw,n)
end poke(24414,255)fillp()end function dX()if(not ej)return
C(n0)for n=1,G do if(q[n])oP(eQ(n),q[n])
end end function dk()cls()fillp()local n=16for e in all(split(dI,"|"))do ne(e,0,n,1,nil,14,nil,6)n+=8end end function dq()dj()dQ()dX()if(d<18)oG()
if(es)t0(o.e,o.n,es.e,es.n)es=nil
dC()if(eq>0)rectfill(0,0,127,127,3)eq-=1
end function _draw()cls()if d==13do os()elseif d==19do dk()elseif d==18do dy()else dq()end end
__gfx__
91c0df01ff0110013001500170019001b001d001f0011101310112011010203030504070509060b070d080f0a0f0b0d0c0b0d090e070f0500130111012011010
103010501070209040b060c080c0a0c0c0c0e0b001901170115011301110120180607040505040706080409050b070c080a090c0b0b0c090a080c070b0509040
12017020503030502070209030b050d070e090e0b0d0d0b0e090e070d050b03090201201103020503070409050b060d070f090f0a0d0b0b0d0b0e090f0700150
1130211012017060505030501070109030b050b070a090a0b0b0d0b0f090f070d050b050906012017070505030501070109030b050b070909070b050d050f070
f090d0b0b0b0909052218010703060505070409030b020d040d060d080d0a0d0c0d0e0d0d0b0c090b070a0509030120170307050507030703090509070b070d0
90d090b0b090d090d070b07090509030120140404060408040a040c060c080c0a0c0c0c0c0a0c080c060c040a04080406040f1f0df80ffa010c030e0500160e0
70c080a090c0a0e0b001d0e0f0c011a03180f1f0efe0efc0ffa0108030705070708090a0b0c0d0d0f0d011c031a041804160d1e010f020d030b0409050707050
9040b040d050f070019011b021d031f05221805060404030202030404060508060a070c080e090c0a0a0b080c060d040e020c030a04012011040ff60ff8010a0
30a040c050e06001800190e0a0c0b0a0d0a0f080f060d040b1d060104020304020603080509070a090a0b090c070d050e030f010d1e0c030a030803060404060
308030a030c050c070c090b0b090c070c050f1f0df30df50df70df90dfb0ffd010d030c050b070a09090b080d070f0600140d1e0ff01dff0dfd0dfb0ff901080
30705060704080209000a0efc0dfe0df118070505070509070b090b0b090b070905091c0705050703080509070b080d090b0b090d080b0709050803012011090
20b040c060d080d0a0c0c0a0d080d060c040b020901070105030505070605221108010a020c040d060e080e0a0e0c0d0e0c0f0a0f080e060c050a04080406040
40502060b1d080df80ff7010503030502070209030b050d070e090e0b0d0d0b01201803080507070508030805080709080b080d080b09090b080d080b0809070
8050f1f0802060404060208030a040c050e070e090e0b0e0c0c0d0a0e080c060a040b1d0ef80ff60105030405030701080ff9010b030d040f05011602180f1f0
20c040c060c080c0a0c0c0c0e0c0e0a0d080b060905070505060308020a0d1e0ef00ef20ef40ef60ef80ffa010c030d050d070d090d0b0c0d0c0f0d052212001
40e040014021500160e070c080a090807060507030801090ffa0dfb0ffb010b0ffd0b1d0df40cf60cf80dfa0ffb010b030a020c020e030015011701190011201
801060204000302010303040406060808080a080c060d040f030d020c000a020f1f080ff8010703050504070409050b070c090c0b0b0c090c070b05090308010
f1f010ef1000202020403060308040a040c050e0500160218021a011c011e001b1d02070309050a070b090b0b0a0d090e070c060a060807060604060120160a0
40c060e080e0a0d0c0c0e0b0f090f070e050c040a03080206020404060602120ff10b0cfc0102030405060708090a0b0c06120ff10b0cf011020304050607080
90a0b0c0d0e0f00130001b406120ff10b0bf01102030405060708090a0b0c0d0e0f0013000cc4030001b403000cc403000cc408120ff10b0bf21102030405060
708090a0b0c0d0e0f00111213000cc403000cc405120ff10b0cff0102030405060708090a0b0c0d0e0f0300041504120ff10b0cfe0102030405060708090a0b0
c0d0e030003f4030001b403120ff10b0cfd0102030405060708090a0b0c0d04120ff10b0bfe0102030405060708090a0b0c0d0e0300041503000e250e020ff10
b0bf8010203040506070802120ff10b0bfc0102030405060708090a0b0c030001b4030003f403000b4503000cc405120ff10b0bff0102030405060708090a0b0
c0d0e0f03000b4503000ea503000e2508120ff10b0cf21102030405060708090a0b0c0d0e0f00111213000b4503000cc403000ea50300041503120ff10b0bfd0
102030405060708090a0b0c0d030001b40b1d00000cf0040000fcf01cf0f40014000cf0040408f4080cf8fcf8091c000ffff00efffffdf20ef0010ef10cfefff
bf40df3040cf5092418f00cfdfcfff0000df8f20bf00cf000060bf500040ef00007050205030300000ef80cf30ef40000092418f00cf30cf100000df8fcfdfef
df000060bf10bf20df00007050500040100000ef8020500040000051a07f00af60af40df0000af00cf300060606040900051a07f00af50af30df0000bf00df30
0060506030900051a07f00af40af20df0000cf00ef300060406020900051a07f00af30af10df0000df00ff300060306010900051a07f00af20af00df0000ef00
00300060206000900051a07f00af10afffdf0000ff00103000601060ff9000d1e04fcfcf8f408fc0cfc0404080cf804f408fcfcfcfcf0080cf40cf400011800f
ce0f8f4f4f4fcfcf8f804040404001118001ce018fc04fc0cf408f8f40cf40cf011180dfdf6090c060c00030df90009060606011809060c00030df900090307f
00dfdf4f0011803060c00030df900060307f00dfdf4f0011803060c00030df900030307f00dfdf4f001180df60c00030df9000df307f00dfdf4f001180af60c0
0030df9000af307f00dfdf4f0011807f60c00030df90007f307f00dfdf4f0011804f30af9030dfaf607f607f00dfdf4f00904000df20000020ef0015820e002e
4f9e9e4f2e000ec02e719ee14f0200e1c07171c0e100024fe19e712ec02cfe3d3dfe2c112cd23de3fee311d2d211e3fee33dd22c111800290c0c290018f329e6
1cf700e60404e600f70ce629041180a000707000a09f706f009f9f006f709fd060ef00308f3000400000800000120140005000401050100040104000501050cf
00df00cf10df1000cf10cf00df10df91c08f00bf00cfffcf10409f20cf30df10cf407030401040303091c09fcf9f40ff00500070cf008f10ffef400080704000
10dfcf3000bf70d0608f00cf0000cf00404000800011808f00cf0000cf00404000800000af0060f0700000cf0040008f7f807f8f90809011800020804000af80
cf8f4000608fcf00eff0709fcf108f70cf704010809f40100011808f8f808f80808f80cfcf40cf4040cf4015828f00cfdfcfff0000df8f20bf00cf000060bf50
0040ef00007050205030300000ef80cf30ef4000008f00cf30cf100000df8fcfdfefdf000060bf10bf20df00007050500040100000ef8020500040000092417f
00af60af40df0000af00cf3000606060409000900060af60cf300000600040df00afafafcf7f0092417f00af50af30df0000bf00df3000605060309000900060
bf60df300000500030df00afbfafdf7f0092417f00af40af20df0000cf00ef3000604060209000900060cf60ef300000400020df00afcfafef7f0092417f00af
30af10df0000df00ff3000603060109000900060df60ff300000300010df00afdfafff7f0092417f00af20af00df0000ef00003000602060009000900060ef60
00300000200000df00afefaf007f0092417f00af10afffdf0000ff00103000601060ff9000900060ff60103000001000ffdf00afffaf107f0012018000606000
80af608f00afaf008f60af400030300040df30cf00dfdf00cf30df51a0afafffef50af30ff703020201070ef20af40dfff3a15ce8fee6f4f6f7f8f7fcf4fdf4f
bf3f9ffe9fdebfbeaf4fbf7fcf6f003f30fe50de80be70ce400f103fffce60fe707f707fa0bea0be70bf6f606f509fef9fdfdfafdfbfcf30cf60ef60604090df
a0af80cf60ef7020603040301020ffcfffaf7fef8fdfefafffb06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f51
7041802160a060c07021704160518031a0b0a090809a45ce6f7f6f6f9ffe9feedfbedfcecf4fcf7fef7f605f90eea0be80de60fe703f604f404f103fffdeffbe
7ffe8feeefbeffcf6f406f608f60bf40cf30af209fef9fcfafbfcfafbfaf8faf9fdfafdf60bf80af7030af609f607050803060bf60df7030705060608040a0cf
a0af80b06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f517041802160a060c07021704160518031a0b0a0908038
14be6f7f6f7f9f4fcf1f10fe80dea0ce80ee002f9fce9fbf6f606f509fef9fdfdfafdfbfcf30cf60ef60604090dfa0af80cf60ef7020603040301020ffcfffaf
7fef8fdfefafffb06f316f518f51bf31cf21af119fd09fb0afa0cf90bf908f909fc0afc060a080907021af519f517041802160a060c07021704160518031a0b0
a09080bc565eaf9e6fde6fde700f80fea07ea06e809e709ebf7edf5f6fdf6fff8fffbfdfcfcfafbf9f7f9f5faf4fcf3fbf3f8f3f9f6faf6f604f803f70cfafff
9fff70ef80cf604f606f70cf70ef60ff80dfa05fa03f80406fc06fe08fe0bfc0cfb0afa09f609f40af30cf20bf208f209f50af506030802070b0afe09fe070d0
80b06030605070b070d060e080c0a040a02080316fb16fd18fd1bfb1cfa1af919f519f31af21cf11bf118f119f41af416021801170a1afd19fd170c180a16021
604170a170c160d180b1a031a01180be575e8f7e6fde6f0f8f0fcfdedfdebfce9f8e9f6ebf4eafdebf0fcffe00ce308e506e804e705e409e10ceff5e608e700f
700fa04ea04e705f6fdf6fff8fffbfdfcfcfafbf9f7f9f5faf4fcf3fbf3f8f3f9f6faf6f604f803f70cfafff9fff70ef80cf604f606f70cf70ef60ff80dfa05f
a03f80406fc06fe08fe0bfc0cfb0afa09f609f40af30cf20bf208f209f50af506030802070b0afe09fe070d080b06030605070b070d060e080c0a040a0208031
6fb16fd18fd1bfb1cfa1af919f519f31af21cf11bf118f119f41af416021801170a1afd19fd170c180a16021604170a170c160d180b1a031a011809643fd5f5e
cefecefed05f016f410e41fd015ed05e9f1e9ffe4f7f4f7f709fa0cfa0cf117f112fe0fe80cfa0ef70ef4f604f608030e0ff11cf11604fe04fe0416041c04f91
4fe17f12cfb1ef91bf61afc0af12cf1250e1a0a150b120b1efe1a091d0c0d0c0707170a15015822100d0d000213fd0ee003f3f00eed03f6380b22241338f63ed
b2dc41ac8f5dedcedc80ac225d33ce9650265225249385b156bf96bd26eb258a93b9b179bfe9bdeaeb7c8a5eb9507952e924ea857c565e9a450e9f6e9f6ecf2e
cf2eef5eef5e102e102e406e406e700e707e9f9e9fde70ce70ce9fde9f9e707e705f9ffe9ffe705f705f400f400fcf5fcf6f9fcf9fcfcf8fcf8fefbfefbf108f
108f40cf40cf706f70df9fff9fff4030403070df70409f609f6040a040a0704070b09f119f11cfd0cfd0ef01ef0110d010d04011401170b070319f419f417031
70419f619f91707170719f919f91707170a19f029f02cfa1cfc1bfe1bfe170c17075b25f9f7f9f9f00af9fcf9faf10af708f708f10ef9f309f30cf00cf00ef20
ef20100010004030403070ef70609fa09fb0afb0cf80cf70df70ef80ffa0ffb000b050a07060705060504080409030902080106010500050bf2531ff10508f30
a050108f3070b0108f30d060108f3040c010ff10908f30402010ff10a08f305030108f30602010ff10908f30703010ff10908f30a08010ff10a08f3090b0108f
30c08010ff10908f30d090102120ff1060cfc0102030405060708090a0b0c01541ff10808f30102030ff10808f30402030ff10708f30506070ff10708f308060
70ff10608f3090a0b0ff10608f30c0a0b0ff10508f30d0e0f0ff10508f3001e0f0ff10408f30112131ff10408f304121313000f50113c0ff10f08f30102030ff
10f08f30203040ff10f08f30405060ff10f08f30506070ff10f08f30708090ff10f08f308090a030005b0130005b0130005b0130005b0130005b011401ff1010
8f30102030ff10208f30103040ff10208f30108050ff10208f30104050ff10208f30807050ff10208f30706050ff10908f3090a0b0ff10908f30e0d0c01280ff
10408f30102030ff10408f30203040ff10408f30304050ff10308f306070801280ff10408f30302010ff10408f30403020ff10408f30504030ff10308f308070
602270ff10408f308010208f304050608f303040608f303060708f302030708f302070802270ff10408f302030408f302040508f301020508f308010508f3080
50608f306070802270ff10408f302030408f301020408f301040508f301050608f306070808f301060802270ff10408f302030408f301020408f301040508f30
8010508f308050608f306070803000ae113000ae113000ae112270ff10408f302030408f302040508f306070808f305060808f305080108f30102050a020ff10
609f40102030408360ff10f0df01102030405060708090a0b0c0d0e0f001ff10f0dfc0112131415161718191a1b1c1ff10f0dfc0d1e1f1021222324252627282
e020ff10e0df8010203040506070801140ff10408f30102030ff10408f304050606120ff10f0df01102030405060708090a0b0c0d0e0f0013140ff10408f3010
30408f305070808f3090b0c06140ff1040bf4010203040bf4050607080bf4090a0b0c08360ff10e0df01102030405060708090a0b0c0d0e0f001ff10e0dfc011
2131415161718191a1b1c1ff10e0dfc0d1e1f10212223242526272821280ff10908f30102030ff10908f30605030ff10908f30102040ff10908f3060504013c0
ff10a08f30702050ff10a08f30802050ff10908f30102030ff10908f30605030ff10908f30102040ff10908f306050401280ff10908f30402010ff10908f3050
3010ff10908f30602010ff10908f307030100270ff10f0bf4010204030bf4050608070cf201050cf202060cf203070cf20408013c0ff10708f30102070ff1030
8f30203070ff10208f30304070ff10108f30405070ff10208f30506070ff10308f306010701401ff10108f30102050ff10508f30203060ff10508f30304070ff
10108f30401080ff10208f30506020ff10808f30607030ff10808f30708040ff10208f308050101a82ff10808f30102030ff10808f30402030ff10708f305060
70ff10708f30806070ff10608f3090a0b0ff10608f30c0a0b0ff10508f30d0e0f0ff10508f3001e0f0ff10408f30112131ff10408f30412131ff10808f305161
71ff10808f30816171ff10708f3091a1b1ff10708f30c1a1b1ff10608f30d1e1f1ff10608f3002e1f1ff10508f30122232ff10508f30422232ff10408f305262
72ff10408f308262721681ff10f08f30102030ff10f08f30203040ff10f08f30405060ff10f08f30506070ff10f08f30708090ff10f08f308090a0ff10f08f30
b0c0d0ff10f08f30c0d0e0ff10f08f30e0f001ff10f08f30f00111ff10f08f30112131ff10f08f302131418130ff10e0bf801020304050607080bf8090a0b0c0
d0e0f0010120ff1040bfa0102030405060708090a096b0ff10609fb0102030405060708090a0b09fa0c0d0e0f00111213141519f6061718191a1b19f60c1d1e1
f102129fe02232425262728292a2b2c2d2e2f29f40031323339fc0435363738393a3b3c3d3e3f39f5004142434449f5054647484949f80a4b4c4d4e4f40515e6
c0ff10609f601020304050609fe0708090a0b0c0d0e0f001112131419f40516171819fc091a1b1c1d1e1f102122232429f5052627282929f50a2b2c2d2e29f80
f2031323334353639fc0738393a3b3c3d3e3f30414249f5034445464749f508494a4b4c49f80d4e4f405152535455590ff10609fb0102030405060708090a0b0
9f60c0d0e0f001119fe02131415161718191a1b1c1d1e1f19f40021222329fc0425262728292a2b2c2d2e2f29f5003132333439f5053637383939f80a3b3c3d3
e3f3041438e0ff10609fb0102030405060708090a0b09fc0c0d0e0f001112131415161719f508191a1b1c19f50d1e1f102129f8022324252627282929fc0a2b2
c2d2e2f20313233343539f5063738393a39f50b3c3d3e3f39f8004142434445464749fc08494a4b4c4d4e4f4051525359f5045556575859f5095a5b5c5d59f80
e5f50616263646567901ff10609fb0102030405060708090a0b09fa0c0d0e0f00111213141519f6061718191a1b19fc0c1d1e1f102122232425262729f508292
a2b2c29f50d2e2f203139f8023334353637383939fc0a3b3c3d3e3f30414243444549f5064748494a49f50b4c4d4e4f49f8005152535455565759fc08595a5b5
c5d5e5f5061626369f5046566676869f5096a6b6c6d69f80e6f60717273747576480ff10109fb0102030405060708090a0b09f90c0d0e0f001112131419f8051
61718191a1b1c19f40d1e1f1029f8012223242526272829f6092a2b2c2d2e29f60f203132333438360ff1030df801020304050607080ff1040dfc090a0b0c0d0
e0f00111213141ff10f0df415161718191a1b1c1d1e1f102122232425262728227e0ff10609fc0102030405060708090a0b0c09f40d0e0f0019f40112131419f
805161718191a1b1c19fc0d1e1f10212223242526272829f6092a2b2c2d2e29f60f203132333439fc05363738393a3b3c3d3e3f3049f40142434449f40546474
849f4094a4b4c49f40d4e4f4059f4015253545d360ff10409f40102030909f40405060309f5030607080909fc0a0b0c0d0e0f00111213141519f6161718191a1
b1c1d1e1f102122232425262728292a2b2b050ef3000df2030ff00100091c0efdfef301030202020101000ef00100020ff20ef10dfefdf904020dfefdfef3020
30f070efdfef301030202020ef10dfefdfd06020dfefdfef302030ef001000b050efdfef3020dfef001000d06020dfefdfef30203020000000d060efdfef3020
df2030ef002000d060efdf20df00df0030ef302030d060efdf20df20201030ff30ef20b050efdfef3020dfef0020307030efdfef302030b050ef30efdf000020
df20309040ef30efdf203020df9040efdf20df2030ef30f070ef30efdf10df20ef20ff1000ef00d060efdf20df2030ef30001020303190ef30efdf10df20ef20
ff1000ef00ff002030d06020dfefdfef0020002030ef309040efdf20df00df0030d060efdfef20ff301030202020df7030efdf003020dfb050efdfff30000010
3020df9040efdf203020dfef309040efdf000020df00309040efdf20dfef302030703000df00100030b050ffef00df0030ff301030f070efefffdf10df20ef20
ffef30203071b0efdf10df20ef20ff1000ff001000201020201030ef309040103010dfef102010118020dfefdfef001000201020201030ef3071b020ef10dfff
dfefefef20ff301030202020101000ef007030efdf20dfff301201ffdf10df20ef20ff1000ff00efffefefff001000201020201030ff30ef20ef1051a02000ff
00efffefefffdf10df20ef20201030ff301180ffdf10df20ef20201030ff30ef20efeff5f2d600d6b087b037f0d6f0d6f1e64227528712f6e23673b473846324
0304a204c114e144e174c1848164312421f341e381e3d20413c373a373b381933124f08401b46194f1147214c25413f4539563264396e2c692962296f056e046
c0968091c036d0e0e0f06221c27113f0d2b082a0e000e09090e000e0b013818313838243225391434123410371f282d212d251a24182618202c252e2a2a25232
12425182f0b2f0f22143f08311836191c0326151c171f1b112f10232e1e132613211e111716121d121b1d06511a531c56105c105d155129502c5d195222532d4
f1c48105215221c47285921652361236e1d561d52116f0760186614611163186d1762246620692a5a22592b05041a1e161b141815151719040f4a17551554125
5191400515253545556575455565758595a5b58595a5b5c5d5e5f58595a5b5c5d5e5f58595a5b5c5d5e5f506162636465666768696040444448484c4c4040444
448484c4c40404c4c40505c5c50404c4c40505c5c50404c4c40505c5c50505c5c506064646050586860787088809898686078708880989868607870888098986
860787088809890a0a8a8a0b0b0b0b8a0b0b8b8b0c0c0c8a0b040404040404448484c4054585c50646054585c5064686c6054585c5064686c6054585c5064686
c6064686c6074787c78647d1d100009020150030d1004250cc10600400700000800000900000a13000b1d0008033435363738393a35020240030c100500000a0
0000a1600041e00010b35020140030c100600c10b00080a1600081810010f37010e00020140030c100600420b00840c2a1700011710010644020240030c100b0
0010a16000710100100460201400600c00b00040d02000910000a1600091b10020231370100100201400600e00b00040d02000e2910000211010105450f09000
03110800916900a19000f08010103440f0000003916900a1900001c010104450f000000383916900a1900041b0103003132350f0000003213000916900a1a000
e02020106230b00040914600a15000f03030107240b0004003916900a16000011100004020140021e100913000a1600001500060a2b2c2d2e2f220918c00a1f0
0061410060a2b2c2d2e2f240203400600800916900a1f000d0404020829230b0002099a18000e06020109430b00010914600a1f00031702060a4b4c4d4e4f430
b00010914600a1f000c09040107430b000102150009990a010108420b4002099f1310030c324858020140030e1003123004100005108106100a0710000a1f000
41510010145020140030e100b00030318000a160004221002024e3a020e40030e100600c00d0020031c40041002051000061f820710000a1e00011910010d340
20140030e100b00010a1e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000
000000000000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j6000000000000000000
000000000000j6600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066000000000000000000
0000000000006j600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j66000000000000000000
00000000000j6j6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006j6000000000000000000
000000000006jj60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j6j6000000000000000000
0000000000j6jj600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006jj6000000000000000000
00000000006jjj6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j6jj6000000000000000000
000000000j6jjj60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006jjj6000000000000000000
0000000006jjjj60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j6jjjj6000000000000000000
000000066jjjjj600000000000000000000000000000000000000000000000000000000000000000000000000000000000000066jjjjj6000000000000000000
0000066jjjjjjj6666666666666666666666000000000000000000000000000000000000000000000000000000000000000006jjjjjjj6666666666660000000
00066jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj66666666666666666666666666666666666666666600000000000000000000006jjjjjjjjjjjjjjjjjj600000000
066jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj6666666666666666666666666666666666666666666j6jjjjjjjjjjjjjjj66000000000
66666666666jjj66666666666666666666666666666666666666666660000000000000000000000000000000000000000000066jjjjjjjjjjjjj600000000000
00000000006jjj60000000000000000000000000666600000000600000000000066666000000000000000000000000000666600666jjj6666666000000000000
00000000006jjj60000000000000000000000006jjjj60000066j660000000066jjjjj6660000000000000000000000j6jjjj66606jjj6000000000000000000
00000000006jjj600000000000000000000000j6jjjjj66066jjjjj66000066jjjjjjjjjj60000000006666000000066jjjj6jj606jjj6000000000000000000
00000000006jjj6000000066666666000000006jjjjjjjj6jjjjjjjj60066jjjjj66jjjjj6000000666jjjj6600006jjjj66j6j606jjj6000000000000000000
00000000006jjj60000006jjjjjjjj66000006jjjjjjjjjjjjjjjjjj666jjjjj6600666jjj600006jjjjjjjjj66006jjj6000j6606jjj6000000000000000000
00000000006jjj6000006jjjjj66jjjj6000j6jjjj66jjjjjj666jjj66jjjjj60000006jjj6000j6jjjj66jjjjj606jjjj60006j66jjj6000000000000000000
00000000006jjj600006jjjj660066jjj6606jjjj60066jjj6006jjj6j6jjjj6000000j6jjj6006jjj660066jjj606jjjj60000666jjj6000000000000000000
00000000006jjj60006jjj660000066jjj666jjj600006jjj6006jjj606jjjj600000006jjj606jjj600066jjjjj66jjjjj6000j66jjj6000000000000000000
00000000006jjj6006jjj60000066jjj660j6jjj600006jj6000j6jj60j6jj600000000j6jj6j6jj06006jjjjj660j6jjjjj600006jjj6000000000000000000
00000000006jjj6006jj0600666jjj66000j6jjj600006jj6000j6jj60j6jj600000000j6jj66jjj6066jjjj660000j6jjjj600006jjj6000000000000000000
00000000006jjj6006jj6066jjj66600000j6jjj600006jj6000j6jj60j6jj600000000j6j606jj066jjjj6600000006jjjjj60006jjj6000000000000000000
00000000006jjj6006jj66jjj6600000000j6jjj600006jj6000j6jj60j6jj600000000j6j606jj6jjjj6600000000006jjjjj6006jjj6000000000000000000
00000000006jjjj606jjjjj660000000000j6jjj600006jj6000j6jj60j6jj6000000006jj606jjjjj66000000000000j6jjjjj606jjj6000000000000000000
0000000000j6jjj606jjj660000000000006jjjj600006jj6000j6jj60j6jj6060000006jj60j6jj66000000000000000j6jjjj606jjj6000000000000000000
0000000000j6jjj606jjjj60000000000006jjjj600006jj6000j6jj60j6jj606600066jj600j6jj6000000000006000006jjjjj66jjj6000000000000000000
0000000000j6jjj606jjjj60000000000006jjjj600006jj60006jjj60j6jj6066666jjjj600j6jjj60000000006000000j6jjjj66jjj6000000000000000000
0000000000j6jjj6006jjjj6000000000666jjjj600006jj60006jjj60j6jj606jjjjjjjj600j6jjjj660000006600000006jjjj66jjj6000000000000000000
0000000000j6jjj60006jjjj660000666606jjjj600006j600006jjj60j6jj606jjjjjjj6000006jjjjj6000666000000006jjj606jjj6000000000000000000
0000000000j6jjj600006jjjjj6666jj6006jjjjj60006j600006jjj60j6jj606jjjjjj6000000066jjjj666jj6000000006jjj606jjj6000000000060000000
0000000000j6jjj6000006jjjjjjjjj6000066jjjj6006j600006jjj60j6jj606jjjjj6000000000j6jjjj666600000000j6jjj606jjjj600000006600000000
0000000000j6jjj6000000666666666000000066jj600j660000j6jj60j6jj606jjjj600000000000066660000000000006jjj6006jjjj60000006j600000000
0000000000j6jjj600000000000000000000000066j60j66000006jj60j6jj606jjj60000000000000000000000000000j6jjj600j6jjj6600066j6000000000
0000000000j6jjj60000000000000000000000000j6j606600000j6j60j6jj606jj6000000000000000000000000000066jjj600006jjjjj666jj60000000000
0000000000jaaaaaaaaaaaaa00000000000000000aaaaaaaaaaaaaj660j6jj606j60000aaaaaaaaaaaaa000000000066jjjj6aaaaaaaaaaaaajjj60000000000
000000000aa0000000000000aa0000000000000aa00000000000a0aa60j6jj6066000aa00000000000a0aa00000066jjjjjaa00000000000a0aa600000000000
0000000aa006jjjj6000000000aa000000000aa0000066j60000a000aa6jjj60660aa0000000006666a600aa0066jjjjjaa00000000j6jjjaj00aa0000000000
00000aa0000j6jjjj60000000000aa00000aa00000000660000a000000aajj606aa00000000000000a066600aajjj66aa0000000000j6jja0j6000aa00000000
000000000000j6jjj600000000000a00000a000000000j6000a00000600ajj606a00000000000000a00000660a66600a000000000006jja0jj60000a00000000
00000000000006jjjj60000000000a00000a00000000000000a00000606ajj606a00000000000000a00000000a00000a0000000000j6jjajj600000a00000000
000000000000006jjj60000000000a00000a0000000000000a000000606ajj60ja0000000000000a000000000a00000a00000000006jja0j6000000a00000000
00000000000000j6jjj60000000aa000000a000000000000a0000000606ajj60ja600000000000a0000000000a00000a000000000j6ja0jj6000000a00000000
000000000000000066jj60000aa00000000a000000000000a0000000606ajjj60aj60000000000a0000000000a00000a0000000006jjajj60000000a00000000
00000000000000000066j60aa0000000000a00000000000a00000000606ajjj60a66000000000a00000000000a00000a0000000j6jja0j600000000a00000000
000000000000000000006aa000000000000a0000000000a000000000606ajjjj6a6j60000000a000000000000a00000a000000j6jja066000000000a00000000
0000000000000000000aa00600000000000a0000000000a000000000606ajjjj6a06j6600000a000000000000a00000a0000066jjja600000000000a00000000
00000000000000000aa0000000000000000a000000000a0000000000006ajjj60a006jj6600a0000000000000a00000a00006jjjja0000000000000a00000000
000000000000000aa000000000000000000a00000000a00000000000006ajjj60a0006jjj6a00000000000000a00000a0006jjjja00000000000000a00000000
0000000000000aa00000000000000000000a00000000a00000000000006ajj600a00006jjjaj6600000000000a00000a666jjjj6a00000000000000a00000000
00000000000aa0000000000000000000000a0000000a000000000000006aj6000a000006ja0jjj66666660000a00666ajjjjjj6a000000000000000a00000000
000000000aa0000000000000000000000000aa0000a00000000000000aa0j60000aa000ja0jjjjjjjjjjj66aa066jjj0aajj66a00000000000000aa000000000
0000000aa00000000000000000000000000000aa00a000000000000aa00660000000aa00a066666666666aa00666666600aa00a000000000000aa00000000000
00000aaaaaaaaaaaaaaaaaaaaaaaaa0000000000aaaaaaaaaaaaaaa000000000000000aaaaaaaaaaaaaaa000000000000000aaaaaaaaaaaaaaa0000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000070000007000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000077000000000000000000000000000000000000000000000000000000000000000
66000000000000000jj0000000000001100000000000600000070000007000007710jj0600100007000000000000007777000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000080000007000000j000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000007000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000ccccccccccccccccccccccccccccccccccaabbaacccccccccccccccc000a0000000000000000000000000000000000000
000000000000000000000000000cccc1ccchhhcc1111cchhhcc1111chhhh1c111ahbbbha1111chhhhcc11118c0aa080000000000000000000000000000000000
000000000000000000000000ccc11ccchhhccc1111cchhhhc11111chhhhhc1111ahhbbha11111cchhhhcc1188caa800000000000000000000000000000000000
00000000000000000000cccc11ccchhhhcc11111cchhhhhc11111chhhhhhc11111ahhbbha111111chhhhhcc188888c0000000000000000000000000000000000
00000000000000000ccc111ccchhhhccc11111cchhhhhcc11111chhhhhh1c11111ahhbhhha111111chhhhhh881118acc00000000000000000000000000000000
0000000000000cccc111ccchhhhhcc111111cchhhhhhc111111hchhhhhhc111111ahhhhhhha111111cchhhhhhaa11aaacc000000000000000000000000000000
000000000cccc1111ccchhhhhccc111111cchhhhhhcc1111111chhhhhhhc111111ahhhbbbha11111111chhhhhhcc111111ccc000000000000000000000000000
000000ccc11111ccchhhhhhcc1111111cchhhhhhhc11111111chhhhhhh1c1111111ahhbbbhha11111111chhhhhhhcc1111111cc0000000000000000000000000
00cccc11111ccchhhhhhccc1111111cchhhhhhhhc11111111chhhhhhhhc11111111ahhhhhhhha11111111cchhhhhhhcc1111111cc00000000000000000000000
cc111111ccchhhhhhhcc11111111cchhhhhhhhcc11111111chhhhhhhhhc11111111ahhhhhhhhha11111111hchhhhhhhhcc1111111ccc00000000000000000000
11111ccchhhhhhhccc11111111cchhhhhhhhhc111111111chhhhhhhhh1c11111111ahhhhhhhhha1111111111chhhhhhhhhcc11111111cc000000000000000000
11ccchhhhhhhhcc111111111cchhhhhhhhhcc111111111chhhhhhhhhhc111111111ahhhhhhhhhha1111111111chhhhhhhhhhc111111111cc0000000000000000
cchhhhhhhhccc111111111cchhhhhhhhhhc1111111111chhhhhhhhhhhc1111111111ahhhhhhhhhha1111111111cchhhhhhhhhcc111111111ccc0000000000000
hhhhhhhhcc1111111111cchhhhhhhhhhcc1111111111chhhhhhhhhhh1c1111111111ahhhhhhhhhhha1111111111hchhhhhhhhhhcc1111111111cc00000000000
hhhhhhcc11111111111chhhhhhhhhhhc111111111111chhhhhhhhhhhc11111111111ahhhhhhhhhhha111111111111chhhhhhhhhhhcc1111111111cc000000000
hhhccc11111111111cchhhhhhhhhhhc111111111111chhhhhhhhhhhhc11111111111ahhhhhhhhhhhha111111111111cchhhhhhhhhhhcc1111111111ccc000000
hcc111111111111cchhhhhhhhhhhcc111111111111chhhhhhhhhhhh1c111111111111ahhhhhhhhhhhha111111111111hchhhhhhhhhhhhc111111111111cc0000
c111111111111cchhhhhhhhhhhhc1111111111111chhhhhhhhhhhhhc1111111111111ahhhhhhhhhhhhha1111111111111chhhhhhhhhhhhcc111111111111cc00
11111111111cchhhhhhhhhhhhcc1111111111111chhhhhhhhhhhhhhc1111111111111ahhhhhhhhhhhhha11111111111111chhhhhhhhhhhhhcc111111111111cc
111111111cchhhhhhhhhhhhhc11111111111111chhhhhhhhhhhhhh1c1111111111111ahhhhhhhhhhhhhha11111111111111cchhhhhhhhhhhhhcc111111111111
1111111cchhhhhhhhhhhhhhc11111111111111chhhhhhhhhhhhhhhc11111111111111ahhhhhhhhhhhhhhha11111111111111hchhhhhhhhhhhhhhcc1111111111
11111cchhhhhhhhhhhhhhcc11111111111111chhhhhhhhhhhhhh8hc111111111111111a8hhhhhhhhhhhhhha111111111111111chhhhhhhhhhhhhhhcc11111111
111cchhhhhhhhhhhhhhhc111111111111111chhhhhhhhhhhhhhh88c1111111111111188hhhhhhhhhhhhhhha1111111111111111cchhhhhhhhhhhhhh1c1111111
1cchhhhhhhhhhhhhhhcc1111111111111111chhhhhhhhhhhhhhhh88811111111111888ahhhhhhahhhhhhahha1111111111111111hchhhhhhhhhhhhhhhcc11111
chhhhhhhhhhhhhh8hc11111111111111111chhhhhhhhhhhhhhhhhc8888111111118881ahhhaahhhhhhhhhhaaa1111111111111111hchhhhhhhhhhhhhhhhcc111
hhhhhhhhhhhhhhh8c11111111111111111chhhhhhhhhhhhhhhhh1c1888881111888811haaahhhhhhhhhhhhhhaaa1111111111111111cchhhhhhhhhhhhhhhhcc1
hhhhhhhhhhhhhhc881111111111111111chhhhhhhhhhhhhhhhhhc111888881888881aaaahhhhhhhhhhhhhhhhhaaaaa11111111111111hchhh8hhhhhhhhhhhhhc
ccccccccccccccc88ccccccccccccccccccccccccccccccccccccccc8888888888aaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccc88cccccccccccccc
000000000000000880000000006000000000000000000000000000088888000888880aaaaaaa00000000000000aaaaa000000000000000008800000000000000
00000000000000888000000000000000000000000000000000000008888000000888800aaaaaaaaaa00000000aaaa00000000000000000008800000000000000
00000000000000888000000000000000000000000000000000000088800000006008880000aaaaaaaaaaaaaaaaaa000000000000000000088800000000000000
0000000888888888800000000000000000000000000000000000088000000000000088800000aaaaaaaaaaaaaa00000000000008000000088800000000000000
0000000000888888880000000000000000000000000000000000800000000000000000800000000aaaaaaaaaa000000000000000088888888800000000000000
000000000000088888000000000000000000000000000000000000000000000000000000000000000aaaaaa00000000000000000000888888800000000000000
000000000000000888000000000000000000000000000000000000000000000000000000000000000000aa000000000000000000000008888800000000000000
00000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000
00000000000000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008800000000000000
00000000000000000888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000j00800000000000000
000000000000000000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000j0880000000000000
00000000000000000088888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000008888800000000000
00000000000000000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888880000000000
00000000000000000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888888800000000
00000000000010000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008880000888000000
00000000000100000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008880000000000000
00000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008880000000000000
00000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008800000000000000
00000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008800000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008800000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006
__meta:title__
[tempest 2000 0.9]
by [deepthaw]
