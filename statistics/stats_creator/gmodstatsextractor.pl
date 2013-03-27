start(In, Outfile) :- 
    consult(In),
    open(Outfile, write, Out),
	bagof(Rel,Sen^Pos^Head^Morph^(w(Sen,Pos,Word,'ne',Rel,Head,Morph), atom_concat(_,s,Word)),List),length(List,Length),
	bagof(a,member(gmod,List),List2),length(List2,GMOD),
    Length > 1,
	write(Out,'gmod_ne('),
    writeq(Out,Word),
    write(Out,','), 
    writeq(Out,GMOD), 
    write(Out,','), 
    writeq(Out,Length),
    write(Out,').'),
    nl(Out),
    fail.