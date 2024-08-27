insert Projects select * from master.dbo.tmpProjects
insert EmployeeProjectAssignments select * from master.dbo.tmpEpa
insert WorkHours select * from master.dbo.tmpWorkHours

use hourglass

delete from Countries where ;

Select count(*), co.CountryName from Clients cl
left join Countries co on co.CountryID = cl.CountryID
group by CountryName
union 
select count(*), co.CountryName from Offices o
left join Countries co on co.CountryID = o.CountryID
group by CountryName


--testing zone--

Update Contracts set ContractTypeID = 
	(select ContractTypeID from ContractTypes where ContractTypeName = 'Fixed Price') 
	where ContractTypeID = 
	(select ContractTypeID from ContractTypes where ContractTypeName = 'Time and Materials')

Update Projects Set ManagerID = 
(select ManagerID from ContractTypes where ContractTypeName = 'Fixed Price')
 where ManagerID = 
 (select ContractTypeID from ContractTypes where ContractTypeName = 'Fixed Price');

 

update EmployeeProjectAssignments set EndDate = '2017-08-01 00:00:00' 
where EmpID = (select EmpID from Employees where FirstName = 'Mark' AND LastName = 'Jones')
AND ProjectID = (select ProjectID from Projects where ProjectName = 'DT Work Order - Customization');

select * from EmployeeProjectAssignments

 Update Projects Set ManagerID = 
 (select EmpID from Employees where FirstName = 'Matthew' AND LastName = 'Smith')
 where ManagerID = (select EmpID from Employees where FirstName = 'Paul' AND LastName = 'Davis');

select cl.CountryID, cl.ClientName from clients cl 
union
select o.CountryID, o.OfficeName from offices o

delete from Countries where CountryID in (
	select c.CountryID from Countries c full outer join (
	select count(*) as Ammount, (CountryID) from 
		(select cl.CountryID, cl.ClientName from clients cl 
			union
			select o.CountryID, o.OfficeName from offices o
		) as hasCountry group by CountryID
	) as cc on c.CountryID = cc.CountryID
	where Ammount IS NULL
)

select * from Countries
Group by CountryID
canada 2, thailand 7, panama 9