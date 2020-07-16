LoadPackage("mysmallgrps");

### 
###


msg.testAllEnumeration := function(from,to)
local todo, i, my, gap;
   todo:=Filtered([from..to], x->MySmallGroupIsAvailable(x) and (x<2001 or ForAll(Collected(FactorsInt(x)),i->i[2]<3)));;
   for i in todo do Display(i); my:=MyNumberOfGroups(i); gap:=NumberSmallGroups(i);
      if not my = gap then
         Error("ERROR at order ",i,"\n");
      fi;
   od;
   return true;
end;

getRandomPerm := function(G)
local H, gens, K;
    H := Image(IsomorphismPermGroup(G));
    repeat
       gens := List([1..Size(GeneratorsOfGroup(G))+3],x->Random(H));
       K := Group(gens);
    until Size(K) = Size(G);
    return K;
end;

getRandomPc := function(G)

local pcgs,H,ns,N,el,hom,Q,i,rel,els;
   if not IsPcGroup(G) then Error("need pc group as input"); fi;
   els  := [];
   H    := G;
   rel  := [];
   repeat
      ns  := Filtered(MaximalSubgroupClassReps(H),x-> IsNormal(H,x) and
              Size(x)<Size(H) and IsPrimeInt(Size(H)/Size(x)));
      N   := Random(ns);
      hom := NaturalHomomorphismByNormalSubgroup(H,N);
      el  := MinimalGeneratingSet(Image(hom))[1];
      el  := el^Random(Filtered([1..Order(el)],i-> Gcd(i,Order(el))=1));
      if not Order(el) mod Size(Image(hom))=0 then Error("mhmm"); fi;
      Add(els,PreImagesRepresentative(hom,el));
      Add(rel,Size(Image(hom)));
      H   := N;
   until Size(H)=1;
   pcgs := PcgsByPcSequence(FamilyObj(els[1]),els);
   return GroupByPcgs(pcgs);
end;



testId := function(n)
local nr, gap, my, i, copies,  gapid, new;

repeat
   n := n+1;
   if MySmallGroupIsAvailable(n) then
      nr  := MyNumberOfGroups(n);
      gap := SmallGroupsAvailable(n);
      Print("start ",nr," groups of size ",n,"\n");

      my := List([1..nr],x->MySmallGroup(n,x));
      for i in [1..nr] do
          copies := List([1..5],x->getRandomPerm(my[i]));
	  if not ForAll(copies,x->MyIdSmallGroup(x)=[n,i]) then Error("my ID perm", [n,i]); fi;
      od;
      Display(" ... my stuff correct");

    ## can compare with gap library?
      if gap then
          gapid := List(my,IdSmallGroup);
	  if not Size(gapid) = NumberSmallGroups(n) then Error("gap nr"); fi;
	  if not IsDuplicateFreeList(gapid) then Error("gap id"); fi;
          new := List([1..nr],x->MyIdSmallGroup(SmallGroup(n,x)));
	  if not IsDuplicateFreeList(new) then Error("my id"); fi;
	  Display(" ... gap comparison ok");
      fi;

   fi;
until false;
return true;
end;

testIdPc := function(n)
local nr, gap, my, i, copies, gapid, new;

repeat
   n := n+1;
   if MySmallGroupIsAvailable(n) then
      nr  := MyNumberOfGroups(n);
      gap := SmallGroupsAvailable(n);
      Print("start ",nr," groups of size ",n,"\n");

      my := List([1..nr],x->MySmallGroup(n,x));
      for i in [1..nr] do
          copies := List([1..5],x->getRandomPc(my[i]));
	  if not ForAll(copies,x->MyIdSmallGroup(x)=[n,i]) then Error("my ID pc", [n,i]); fi;
      od;
      Display(" ... my stuff correct");

    ## can compare with gap library?
      if gap then
          gapid := List(my,IdSmallGroup);
	  if not Size(gapid) = NumberSmallGroups(n) then Error("gap nr"); fi;
	  if not IsDuplicateFreeList(gapid) then Error("gap id"); fi;
          new := List([1..nr],x->MyIdSmallGroup(SmallGroup(n,x)));
	  if not IsDuplicateFreeList(new) then Error("my id"); fi;
	  Display(" ... gap comparison ok");
      fi;

   fi;
until false;
return true;
end;