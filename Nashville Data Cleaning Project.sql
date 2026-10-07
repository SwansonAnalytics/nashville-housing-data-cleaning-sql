-- Cleaning Data in SQL Query

Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull;

Select SaleDateConverted, convert(Date,SaleDate)
FROM Nashville_Housing.dbo.NashvilleHousingFull;

Update NashvilleHousingFull
Set SaleDate = Convert(Date,SaleDate)

Alter Table NashvilleHousingFull 
Add SaleDateConverted Date

Update NashvilleHousingFull
Set SaleDateConverted = Convert(Date,SaleDate)


-- Populate Property Address data 

Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull
--where PropertyAddress is Null
Order by ParcelID 

Select a.ParcelID,a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing.dbo.NashvilleHousingFull a
Join Nashville_Housing.dbo.NashvilleHousingFull b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is Null 


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashville_Housing.dbo.NashvilleHousingFull a
Join Nashville_Housing.dbo.NashvilleHousingFull b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is Null 



-- Breaking out Address Into Individual Columns (Address, City, State)


Select PropertyAddress
FROM Nashville_Housing.dbo.NashvilleHousingFull
--where PropertyAddress is Null
--Order by ParcelID 

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM Nashville_Housing.dbo.NashvilleHousingFull


Alter Table NashvilleHousingFull 
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousingFull
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


Alter Table NashvilleHousingFull 
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousingFull
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))



Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull



Select OwnerAddress
FROM Nashville_Housing.dbo.NashvilleHousingFull

Select 
PARSENAME(Replace(OwnerAddress,',', '.') ,3)
,PARSENAME(Replace(OwnerAddress,',', '.') ,2)
,PARSENAME(Replace(OwnerAddress,',', '.') ,1)
FROM Nashville_Housing.dbo.NashvilleHousingFull


Alter Table NashvilleHousingFull 
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousingFull
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',', '.') ,3)


Alter Table NashvilleHousingFull 
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousingFull
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',', '.') ,2)

Alter Table NashvilleHousingFull 
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousingFull
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',', '.') ,1)


Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull



-- Change Y and N to Yes and No In (Sold as Vacant) Field 


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM Nashville_Housing.dbo.NashvilleHousingFull
Group By SoldAsVacant
Order By 2



Select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes' 
	When SoldAsVacant = 'N' Then 'No' 
	Else SoldAsVacant
	End
FROM Nashville_Housing.dbo.NashvilleHousingFull


Update NashvilleHousingFull
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes' 
	When SoldAsVacant = 'N' Then 'No' 
	Else SoldAsVacant
	End



-- Remove Duplicates 

With RowNumCTE As(
Select *,
	ROW_NUMBER() Over (
	Partition by ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			Order By 
				UniqueID
				) row_num

FROM Nashville_Housing.dbo.NashvilleHousingFull
--Order By ParcelID
)
Select * 
From RowNumCTE 
Where row_num > 1
Order By PropertyAddress


Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull


-- Delete Unused Columns 


Select *
FROM Nashville_Housing.dbo.NashvilleHousingFull

Alter Table Nashville_Housing.dbo.NashvilleHousingFull
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table Nashville_Housing.dbo.NashvilleHousingFull
Drop Column SaleDate
