# CS506_project

### Description of Project ###

As a young student finding your first off-campus housing is quite a daunting challenge and with Warren Towers under renovation, we take this opportunity to analyze and inform on the transparency and accountability of off-campus student housing. Through this project, we seek to first find a cluster of locations with dense student populations to allow us to study the condition under which students are allowed to pursue their education. The project will progress under a collaborative environment with the Inspectional Services Department to restore and clarify housing violation data, develop tools to identify problematic landlords, and integrate data across city departments. 

### Goal of Porject ###

Under the BuSpark ensign, this projects seeks to be rich in information extraction, pattern recogniztion, and, most importatnly, a helpful tool in guiding students to make more informative decsions on housing contracts. 



### Midterm Report ###

This project came with questions and goals that we are trying to solve using data given. Out of 5 main questions, we have successfully processed data, and create visualizations for 2 of the main questions. The questions include: 

- What are the trends regarding student housing across the city, by district, e.g. what % of the rental housing is taken up by students for each district and how has this changed over time?
- What are the housing conditions for students living off-campus? (e.g. how many students per unit) Is the unit managed by a “bad landlord’ (e.g. how many building violations have student housing)

The datasets that this midterm report is going to focus on include: 
- Student Housing Survey (2016-2024) (https://docs.google.com/spreadsheets/d/11X4VvywkSodvvTk5kkQH7gtNPGovCgBq/edit?gid=1139465182#gid=1139465182)
- Building and Violation Data (https://data.boston.gov/dataset/building-and-property-violations1/resource/800a2663-1d6a-46e7-9356-bedb70f5332c)
- Boston Latitude and Longitude Map provided by MassGIS (publicly available at https://massgis.maps.arcgis.com/apps/View/index.html?appid=530eb45188934e23a8703399fd37bf0f)


### Data Collection ###

All of the data used in this report came from this document. https://docs.google.com/document/d/1bo8HOm5KWv1h1UqtTZ7QCV4YYtyfKhN9KFHLL5j0MJo/edit?tab=t.0. Most of the  the data is provided by Analyze Boston, the City of Boston's open data hub. The rest of the data is found publicly online at Master Address Database Data MassGIS (https://massgis.maps.arcgis.com/apps/View/index.html?appid=530eb45188934e23a8703399fd37bf0f)

### Data Processing ###

a. Cleaning and integration: Student Housing Survey and Building Violation Data

  1. Data Cleaning: Dropped rows that are not needed.
  
  2. Address Normalization: We standardized address entries ( street names, zip codes) to merge the Student Housing Survey with the Building and Violation Data. The goal is to combine both data and run K-means clustering algorithm.
 
  3. The student dataset had confusing column names like '6a. street #' and '6b. street name'. These were renamed for clarity: street_number,street_name, street_suffix, unit_number, zip_code
 
  4. Data Merging: After cleaning, the Student Housing Survey was linked to the Building and Violation Data based on address. This step allowed us to explore how many students occupied a given unit and how many violations were registered against the property.
 
  5. Data grouping: We grouped both datasets by simple address key (using street number, streetname, and zip_code, concatenated with spaces) to count:
      - student_count: how many students reported each address
      - violation_count: how many violations were tied to each address
  6. Data Filtering: We wanted to focus on problematic housing, so we filter the data by housing that has more than 0 violations.

b. Cleaning and integration: MassGIS and Student Housing Survey (2016-2024)

  1. Data cleaning and filtering: We dropped colunns that are not needed in Student Housing Survey (Missing addresses, Nan values, etc). We filter out data by name and street number in order to filter out the data by district) <img width="247" alt="Screenshot 2025-03-30 at 6 52 46 PM" src="https://github.com/user-attachments/assets/81e02290-ba5a-4688-a440-b4e7fc12e4ac" />

  2. Address Normalization: We standardized address entries (street names, zip codes, city, etc.) within Student Housing Survey since the addresses are sometimes not the same.

  3. The address that were given were ranges of data. One part of the filtering process we did was to add another column (actual_address) where that column represents exactly one address making it easier to do location based analysis.
    


### Data Analysis ###

a. Analysis for What are the housing conditions for students living off-campus? (e.g. how many students per unit Is the unit managed by a “bad landlord’ e.g. how many building violations have student housing)
  
  1. Clustering: K-Means algorithm was applied with k = 5 (5 clusters), Features used: latitude, longitude, and ZIP code (normalized). The resulting clusters were plotted using a scatter plot of longitude vs latitude, color-coded by cluster. The results of the clustering can be seen below.
  
  <img width="765" alt="Screenshot 2025-03-30 at 5 08 15 PM" src="https://github.com/user-attachments/assets/01a49b6f-f033-4f0e-a396-14fcffb3afd4" />

  2. Result and Interpretation:
     The clustering output revealed five distinct geographic regions where matched student and violation addresses are concentrated. Each color in the scatter plot represents a different cluster:

     - Cluster 0 (Blue): A relatively dispersed cluster centered around the middle region. This may represent a central urban zone with a diverse mix of matched addresses.

     - Cluster 1 (Orange):A very small and localized cluster. It may represent a particular housing complex or facility with concentrated matched violations.

     - Cluster 2 (Green):A tight grouping in the northwest. Indicates a neighborhood or district with a high density of student-related violations. Possibly a student residential area.

     - Cluster 3 (Red):A larger and well-formed cluster in the southern portion of the map. Suggests another major region of interest, likely with many matched cases.

     - Cluster 4 (Purple):A dense cluster in the northeast region. This may be associated with student-managed housing or large apartment buildings.
     
     The clustering visulization has not included the map of Boston neighborhood (that will be one of our next steps).

b. Analysis for trends regarding student housing across the city, by district
     1.  Groups the DataFrame by ward and year, then counts the number of rows in each group (.size()). This count (student_units) effectively shows how many student rentals exist for each ward in each year.
     2. Trends over time: Iterates over each unique ward and plots a time series of student-occupied rentals (the student_units count) vs. year giving us the visuals to how students trends changes every year.
  <img width="706" alt="Screenshot 2025-03-30 at 8 13 26 PM" src="https://github.com/user-attachments/assets/345c2540-4737-493d-b80a-ef3fbac0895f" />

      
  <img width="724" alt="Screenshot 2025-03-30 at 8 13 32 PM" src="https://github.com/user-attachments/assets/9cab910b-1167-4436-9553-1e051ad64040" />

  


### Preliminary Results ###


a. Results for Base question 2. 
  1. Distinct "Neighborhoods": Because we are clustering on latitude and longitude, the most obvious takeaway is that location is a primary driver of the clustering. This suggests that properties in each region may share similar characteristics—whether that’s proximity to campus, property age, or landlord ownership patterns. 

  2. Hotspots: Within the graph, cluster 2 and 4 are very closely dense with moderate to high number of violations and are considered hotspots. By searching up the coordinates, we were able to figure out that the two hotspot locations lie in Suffolk University (purple cluster) and Boston University (green cluster). This indicates that there exists a correlation between dense number of students and the number of violations. (More students dense together creates high ammount of violations).

  3. Coldspots: There are clusters on the graph that are less dense with less violations unlike cluster 2 and cluster 4. By looking at the latitude and longitude, it correlates with an area in Boston that are mostly residential (with some mix of student housing). Going along with point b, these points on the map show that there are less violations in areas where there are less student housing and more residential (further away from university). 

b. Results for Base question 1.
  1. From the Bar graph that is shown above, we can see a clear increase in students moving into rentals in Ward 21. When looking up Ward 21, we see that it's location is the Boston University area (see picture below). Given this analysis we are able to conclude that the rise of students is due to the nearby university (BU). The correlation does follow the hypothesis that neighborhoods in close proximity to universities have a far greater concentration of student renters.
     - Similarly, Wards 5 and 4, are amongst other popular areas that Boston University students would live in.
     - Several wards register below 500 student-occupied rentals in 2023 (Wards 2, 6, 12, 13, 15, etc.). This implies that these areas may not host many university campuses or may offer housing that’s less appealing—or less accessible—to students. We believe this areas to have potential for growth (if universities expand, etc.) Monitoring how these wards change over time, we could indicate trends such as improving public transportation routes.
  <img width="904" alt="Screenshot 2025-03-30 at 8 19 58 PM" src="https://github.com/user-attachments/assets/c0c715aa-bd95-4690-a081-7ce00441078a" /> (image found on (https://www.cityofboston.gov/maps/pdfs/ward_and_precincts.pdf)

  2. Another trend that we discovered can be seen on the line graph above. Looking at the line graph, we see that there is a dip in student housing from the years 2019-2020. This directly aligns with the COVID-19 Pandemic where students were not as present during this time. Given the results, we are able to see how much of an effect students have on the properties around Universities. 


### Next Steps ###

1. Clustering Next Steps:
   a. Analyze the types of violations within each cluster.

   b. Map clusters to real-world neighborhoods using GIS.

   c. Determine if violations correlate with academic terms of students or not.
2. Base Question 1 potential next steps
   a. Analyze year to year fluctuations: Some wards exhibit gradual year to year growth, while others show more erratic changes. This might be tied to housing regulations, enrollment surges, or major campus initiatives. We can look into the years to futher explain our dataset.
   b. Predictive Modeling: Use past (historical) trends to predict future occupancy levels in each ward. We could also run regression analysis to see relationships between student occupancy and other factors like demographic, property value, etc.
   
   


