
Use [Portfolio Project]
Select * from CovidDeath Order By 3,4

Use [Portfolio Project]
Select location,date,population,total_cases,new_cases,total_deaths from CovidDeath Order by 1,2

--Total Cases vs Total Deaths

Select location,date,population,total_cases,total_deaths,((CAST(total_deaths as int))*1.0)/(CAST(total_cases as int))*100 as DeathPerct 
from CovidDeath 
where  location = 'India'
order by 1,2

--Total Cases vs Population
Select location,date,population,total_cases,total_deaths,((CAST(total_cases as int))*1.0)/(population)*100 as InfectedPerct 
from CovidDeath 
--where  location = 'India'
order by 1,2

--Countries with highest infection rate
Select location,population,Max(total_cases) as HighestInfection,Max(((CAST(total_cases as int))*1.0)/(population)*100) as InfectedPerct
from CovidDeath
where total_cases is not null
Group by location,population
Order by InfectedPerct desc

--Countries with highest death rate
Select location,population,Max(total_deaths) as HighestDeaths,Max(((CAST(total_deaths as int))*1.0)/(population)*100) as DeathPerct
from CovidDeath
where total_deaths is not null
--and location not in ('Europe','European Union','South America','Africa','North America','High Income','Low Income','Low Income','Lower middle Income','Oceania')
and continent is not null
Group by location,population
Order by DeathPerct desc

--Continent data
Select location,Max(total_deaths) as HighestDeaths,Max(((CAST(total_deaths as int))*1.0)/(population)*100) as DeathPerct
from CovidDeath
where total_deaths is not null
--and location not in ('Europe','European Union','South America','Africa','North America','High Income','Low Income','Low Income','Lower middle Income','Oceania')
and continent is null
and location not in('European Union','High Income','Low income','Lower middle income')
Group by location
Order by DeathPerct desc

--continent & Countries
Select continent,location,Max(total_deaths) as HighestDeaths,Max(((CAST(total_deaths as int))*1.0)/(population)*100) as DeathPerct
from CovidDeath
where total_deaths is not null
--and location not in ('Europe','European Union','South America','Africa','North America','High Income','Low Income','Low Income','Lower middle Income','Oceania')
and continent is not null
and location not in('European Union','High Income','Low income','Lower middle income')
Group by location,continent
Order by DeathPerct desc

--Global Data
Select date,sum(new_cases) as NewCases,sum(new_deaths) as Deaths,(sum(new_deaths)/nullif(sum(new_cases),0))*100 as DeathPercentage
from CovidDeath
where new_cases is not null
and continent is not null
Group by date
order by  date

Select sum(population) as Worldpopulation, sum(new_cases) as NewCases,sum(new_deaths) as Deaths,(sum(new_deaths)/nullif(sum(new_cases),0))*100 as DeathPercentage
from CovidDeath
where continent is not null
and continent not in('European Union','High Income','Low income','Lower middle income')


Select Top 100 * from [Portfolio Project]..CovidDeath 
Select Top 100 * from [Portfolio Project]..CovidVaccinations 


--Join CovidDeath & CovidVaccinations
Select * from [Portfolio Project]..CovidDeath dea
join [Portfolio Project]..CovidVaccinations vacc
on dea.location = vacc.location
and dea.date = vacc.date
order by 3,4

--Total Population vs Vaccinations

Select dea.Continent,dea.location,dea.date,dea.population, vacc.new_vaccinations
,SUM(Convert(int,vacc.new_vaccinations))OVER(Partition by dea.location Order by dea.location,dea.date)
as RollingVaccinationnumber
from [Portfolio Project]..CovidDeath dea
join [Portfolio Project]..CovidVaccinations vacc
on dea.location=vacc.location
and dea.date=vacc.date
where dea.continent is not null
order by 2,3


--CTE
With PopVsVacc(Continent,Location,date,population,new_vaccinations,RollingVaccinationnumber)
as 
(
Select dea.Continent,dea.location,dea.date,dea.population, vacc.new_vaccinations
,SUM(Convert(int,vacc.new_vaccinations))OVER(Partition by dea.location Order by dea.location,dea.date)
as RollingVaccinationnumber
from [Portfolio Project]..CovidDeath dea
join [Portfolio Project]..CovidVaccinations vacc
on dea.location=vacc.location
and dea.date=vacc.date
where dea.continent is not null
)
Select *,(RollingVaccinationnumber/population)*100 from PopVsVacc

--Temp Table
Drop Table if exists #populationpercentvaccinated
Create Table #populationpercentvaccinated
(
continent  nvarchar(255),
location nvarchar(255),
date datetime,
population bigint,
new_vaccinations bigint,
RollingVaccinationnumber bigint,
)
Insert into #populationpercentvaccinated
Select dea.Continent,dea.location,dea.date,dea.population, vacc.new_vaccinations
,SUM(Convert(bigint,vacc.new_vaccinations))OVER(Partition by dea.location Order by dea.location,dea.date)
as RollingVaccinationnumber
from [Portfolio Project]..CovidDeath dea
join [Portfolio Project]..CovidVaccinations vacc
on dea.location=vacc.location
and dea.date=vacc.date
where dea.continent is not null

Select *,(RollingVaccinationnumber*1.0/population)*100 from #populationpercentvaccinated

--Creating a view
Create view Vaccinatedpopulation as
Select dea.Continent,dea.location,dea.date,dea.population, vacc.new_vaccinations
,SUM(Convert(bigint,vacc.new_vaccinations))OVER(Partition by dea.location Order by dea.location,dea.date)
as RollingVaccinationnumber
from [Portfolio Project]..CovidDeath dea
join [Portfolio Project]..CovidVaccinations vacc
on dea.location=vacc.location
and dea.date=vacc.date
where dea.continent is not null
Select *,(RollingVaccinationnumber*1.0/population)*100 from Vaccinatedpopulation








