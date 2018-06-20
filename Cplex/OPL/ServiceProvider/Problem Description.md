
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
