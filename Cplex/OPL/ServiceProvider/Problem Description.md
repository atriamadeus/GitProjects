
## Location Selection Problem:

A company sells and services copy machines to customers in 11 cities throughout the country. 
The company wants to set up service centers in three of these cities. After the company chooses the
location of the service centers, it must assign customers in each city to cone of the service centers. 
For example, if it decides to locate a service center in New York and then assigns its Boston customers 
to the New York service center, a service representative from New York will travel from Boston when services are required there.
The distances (in miles) between the cities are provided, also the estimated annual numbers of trips to the various customers
are given. Maximum three service providers can be selected.
What should thew company do to minimize the total annual distance traveled by its service representative? 

Objective: To develop a linear model, using binary variables, that determines the locations of service centers 
and then assigns customers to these service centers to minimize the total annual distance traveled.



There are two files: 

ServiceProvider.mod  : It contains the model

ServiceProvider.dat  : It contains the data for the model

The following constraints are used to achieve the objective function:
1. Only One Service Provider is assigned to a Customer
2. Maximum three service providers can be selected
3. Only Customer can be assigned to one Service Provider
4. Total number of customers served by all Providers is 11


The customers are located at:Boston,Chicago,Dallas,Denver,LosAngeles,Miami,NewYork,Phoenix,Pittsburgh,SanFrancisco,Seattle
Providers can be selected from Boston,Chicago,Dallas,Denver,LosAngeles,Miami,NewYork,Phoenix,Pittsburgh,SanFrancisco,Seattle

Annual visits needed to customers at different cities are mentioned below:
Boston	885
Chicago	760
Dallas	1124
Denver	708
Los Angeles	1224
Miami	1152
New York	1560
Phoenix	1222
Pittsburgh	856
San Francisco	1443
Seattle	612


 Distance between two cities is given by:
 	
 	Boston	Chicago	Dallas	Denver	Los Angeles	Miami	New York	Phoenix	Pittsburgh	San Francisco	Seattle
Boston	      0	  983	     1815	  1991	3036	 1539	   213	    2664	  792	          2385	      2612
Chicago	     983	0	       1205	1050	2112	1390	840	1729	457	2212	2052
Dallas	1815	1205	0	801	1425	1332	1604	1027	1237	1765	2404
Denver	1991	1050	801	0	1174	2041	1780	836	1411	1765	1373
Los Angeles	3036	2112	1425	1174	0	2757	2825	398	2456	403	1909
Miami	1539	1390	1332	2041	2757	0	1258	2359	1250	3097	3389
New York	213	840	1604	1780	2825	1258	0	2442	386	3036	2900
Phoenix	2664	1729	1027	836	398	2359	2442	0	2073	800	1482
Pittsburgh	792	457	1237	1411	2456	1250	386	2073	0	2653	2517
San Francisco	2385	2212	1765	1765	403	3097	3036	800	2653	0	817
Seattle	2612	2052	2404	1373	1909	3389	2900	1482	2517	817	0
 
