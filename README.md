# Dynamix

A gem that takes a JSON string and dynamically creates a class structure.

Example format:

[
	{
		"name" : "Car",
		"attributes" : [
			"color",
			"make",
			"model"
		]
	},
	{ 
		"name" : "Animal",
		"attributes" : [
			"color"
		],
		"references" : [
			{ 
				"name" : "favorite_car",
				"reference_type" : "Car"
			},
			{
				"name" : "least_favorite_car",
				"reference_type" : "Car"
			}
		]
	}
]