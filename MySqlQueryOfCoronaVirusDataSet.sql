
Select *
From PortfolioProject..CovidDeaths
Order By 3,4

Select *
From PortfolioProject..CovidVaccination
Order By 3,4



Select Location, date , total_cases , new_cases ,total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

--Total Cases and Total Deaths

Select Location, date , total_cases , total_deaths, (total_deaths/total_cases)*100 DeathPercentage
From PortfolioProject..CovidDeaths
Where Location like '%Tur%'
order by 1,2


--Total Cases vs Population
--percentage of population get Covid

Select Location , date , Population ,total_cases , (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where Location like '%States%'
order by 1,2



--Countries with highest infection rate compared to population.

Select Location , Population , MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentOfPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location , Population
order by PercentOfPopulationInfected desc

--Countries with highest death count per population

Select Location , MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Group by Location 
order by TotalDeathCount desc

Select *
From PortfolioProject..CovidDeaths
where continent is not null

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


Select location , MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null
Group by location
order by TotalDeathCount desc


--Global Numbers

Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2



Select *
From PortfolioProject..CovidVaccination


Select location , date , total_tests , positive_rate
From PortfolioProject..CovidVaccination
where total_tests is not null and positive_rate is not null
Group By location
order by 1,2

Select *
from PortfolioProject..CovidDeaths

Select *
from PortfolioProject..CovidVaccination

Select *
From PortfolioProject..CovidDeaths deaths
join PortfolioProject..CovidVaccination vaccination
	on deaths.location = vaccination.location
	and deaths.date = vaccination.date


Select dea.continent ,dea.location , dea.date ,dea.population , vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


Select dea.continent , dea.location , dea.date , dea.population , vac.new_vaccinations
, SUM(Convert(int,vac.new_vaccinations )) OVER (Partition by dea.Location order by dea.location , dea.date) as new_vac_over_part
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--Common Table Expression

With Diseased_Vaccinated (Continent , Location , Date, Population ,people_vaccinated ,positive_rate)
as
(
Select dea.continent , dea.location , dea.date , dea.population ,vac.people_vaccinated , vac.positive_rate
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and vac.people_vaccinated is not null and vac.positive_rate is not null
)
Select * 
From Diseased_Vaccinated


