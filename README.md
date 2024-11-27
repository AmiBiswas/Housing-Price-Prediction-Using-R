# Housing-Price-Prediction-Using-R
Housing price prediction involves forecasting the future prices of residential properties using various data-driven techniques. This process is crucial for stakeholders such as real estate investors, buyers, sellers, and financial institutions. Accurate predictions can inform investment decisions, pricing strategies, and market analysis.



price bedrooms bathrooms sqft_living sqft_lot floors waterfront view condition sqft_above sqft_basement yr_built yr_renovated street city statezip
It looks like you have a dataset with various features that can be used for housing price prediction. Each column represents an attribute of a house, such as the number of bedrooms, bathrooms, square footage, lot size, number of floors, whether it has a waterfront, view quality, condition, square footage above ground, square footage of the basement, year built, year renovated, street address, city, and state zip code.



Using These Features for Housing Price Prediction
Data Cleaning and Preprocessing:
Ensure there are no missing values.
Normalize and scale the numerical features.
Encode categorical features such as waterfront, view, condition, street, city, and statezip.

Feature Engineering:
Create new features based on existing ones if needed (e.g., age of the house, renovation status).
Handle outliers and anomalies in the data.
Model Building:

Split the data into training and testing sets.
Choose a machine learning model such as linear regression, decision trees, random forests, or neural networks.
Train the model on the training set and validate it on the testing set.

Model Evaluation:
Evaluate the model using metrics such as Mean Absolute Error (MAE), Root Mean Squared Error (RMSE), and R-squared.
Fine-tune the model parameters to improve accuracy.




Gradient Boosting model and Support Vector Machine Model(SVM) model is deployed:

#SVM - Mean Squared Error: 16988466288 
#SVM - R-squared: 0.6406572 

#Gradient Boosting - Mean Squared Error: 23964266841 
#Gradient Boosting - R-squared: 0.6111212

# So we choose SVM as MSE is smaller & R square is higher to 64%.;
