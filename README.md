# README

======================================================
Happy Shop is an e-commerce retailer specializing in beauty products. They want to have a simple product catalog filterable by categories on their website. They prefer an API driven approach for the backend as they want similar features in a native mobile app down the road. So you are tasked to build API endpoints for the product catalog and a simple front-end for the web.

Models 
Product 
○ Attributes: 
	■ name, string. 
	■ sold_out, boolean 
	■ category, string. 
		Eg. makeup, tools, brushes 
	■ under_sale, boolean. 
	■ price, integer. 
		Eg. 1000 ($10), 2500 ($25) 
	■ sale_price, integer. 
		Eg. 1000 ($10), 2500 ($25) 
	■ sale_text, string. 
		Eg. 50% OFF, 30% OFF 
 
API endpoints 
	For the scope of this task, we will use a brand new Rails project with 1 or more models. 
	 
	● Products 
		○ Returns multiple products with attributes for each product. 
		○ It should be able to accept mandatory and/or optional parameters to: 
			■ Filter products based on specific categories or price 
			■ Sorting products based on price 
			■ Paginate products 
			■ Combinations of above 

	● Product 
		○ Returns data for a single product with its attributes. 
 

 
Front-end 
	Use a client side MVC framework of your choice to create a Single Page Application (SPA) that interfaces with the API. You are expected to create 
	● Listing of all products, including a product “card” that follows the mocks in ​here  
	● Simple filter by category, by price range options using the API. You are free to define what the price ranges are. 
	● A dropdown to sort products by price using the API 
	● A paginator to paginate results using the API 
	● A simple product details page once you click on a product 
	● Use a state / store to handle and manage the state of the application 
	● Use a router or similar technique to manage history so to not need refreshes on view change 
	● Brownie points for using VueJS 


-------------------------------------------------------------------------
Problem Solutions

Model

Product 
○ Attributes: 
	■ name, string. 
	■ sold_out, boolean 
	■ category, string. 
		Eg. makeup, tools, brushes 
	■ under_sale, boolean. 
	■ price, integer. 
		Eg. 1000 ($10), 2500 ($25) 
	■ sale_price, integer. 
		Eg. 1000 ($10), 2500 ($25) 
	■ sale_text, string. 
		Eg. 50% OFF, 30% OFF 

category, string. 
		Eg. makeup, tools, brushes 
	■ 

 
API endpoints 
	For the scope of this task, we will use a brand new Rails project with 1 or more models. 
	 
	● Products 
		○ Returns multiple products with attributes for each product. 
		○ It should be able to accept mandatory and/or optional parameters to: 
			■ Filter products based on specific categories or price 
			■ Sorting products based on price 
			■ Paginate products 
			■ Combinations of above 

	● Product 
		○ Returns data for a single product with its attributes. 

		api/v1/product/:id
			■ name 
			■ sold_out 
			■ category 
				Eg. makeup, tools, brushes 
			■ under_sale, boolean. 
			■ price, integer. 
				Eg. 1000 ($10), 2500 ($25) 
			■ sale_price, integer. 
				Eg. 1000 ($10), 2500 ($25) 
			■ sale_text, string. 
			
========================================================================================
* Ruby version : 2.4.3

* Rails version : 5.1.4

* Api Documentation
	Generate api document using raml2html
	Raml2html v 1.0
	ex : raml2html api_document.raml > api_document.html

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
