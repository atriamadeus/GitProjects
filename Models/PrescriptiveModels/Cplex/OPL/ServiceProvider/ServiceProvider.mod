/*********************************************
 * OPL 12.8.0.0 Model
 * Author: atrim
 * Creation Date: Jun 18, 2018 at 11:05:57 AM
 *********************************************/
{string} Customers= ...;
{string} Providers= ...;
int Visits[Customers]= ...;
int Distance[Providers][Customers]= ...;


dvar boolean open[Providers];
dvar boolean assign[Providers][Customers];

minimize  
  sum( c in Customers)
    Visits[c]*sum(p in Providers, c in Customers)
     Distance[p][c]*assign[p][c] + 
  sum(p in Providers)
    open[p];  
     
subject to{
   forall(p in Providers,c in Customers )
     constrOneOnlySelectedProviderIsAssigned:
     assign[p][c] <= open[p];

   constrtwoMaxThreeProviders:
   sum(p in Providers)
     open[p]<=3;
   
   forall( c in Customers)
     ConstrThreeOnlyOnceCustomerToOneProvider:
     sum( p in Providers)
       assign[p][c]==1;
   
   constrFourTotalCustomersServedByAllProviders:
   sum(c in Customers, p in Providers)
     assign[c][p] == 11;
}


dexpr int TotalDistance = sum (p in Providers ,c in Customers) 
                      Visits[c]*Distance[p][c]*assign[p][c];




execute DISPLAY_RESULTS{
  writeln("Open=",open);
  writeln("Assign =",assign);
  writeln(" Total Distance =",TotalDistance);
}
     


