import Foundation

var grains: [String: [String]] = [
    "Pastas And Noodles" : pastaAndNoodles,
    "Other Grains" : otherGrains,
]

var vegetable: [String : [String]] = [
    "Vegetables": vegetables
]

var fruit: [String: [String]] = [
    "Fruits": fruits
]

var proteins: [String: [String]] = [
    "Meats, Seafoods And Eggs": meatsSeafoodsAndEggs,
    "Beans, Peas And Tofu": beansPeasAndTofu,
    "Nuts And Seeds" : nutsAndSeeds
]

var dairies: [String: [String]] = [
    "Dairy": dairy
]

var other: [String: [String]] = [
    "Beverages" : beverages,
    "Alcoholic Beverages" : alcoholicBeverages,
    "Condiments and Sauce" : condimentsAndSauce,
]

var foodGroups = [grains, vegetable, fruit, proteins, dairies, other]

var pastaAndNoodles: [String]  = [

    "Spaghettoni",
    "Spaghetti",
    "Spaghettini",
    "Fedelini",
    "Vermicelloni",
    "Vermicelli",
    "Capellini",
    "Capelli D'angelo",
    "Barbina",
    "Bucatini",
    "Perciatelli",
    "Fusilli Lunghi",
    "Fusilli Bucati",
    "Pici",
    "Soba - そば",
    "Udon - うどん",
    "Cu mian - 粗麵",
    "Ziti",
    "Zitoni",
    "Spaghetti Alla Chitarra",
    "Ciriole",
    "Bavette",
    "Bavettine",
    "Fettuce",
    "Fettuccine",
    "Fettucelle",
    "Lagane",
    "Lasagne",
    "Lasagnette",
    "Lasagnotte",
    "Linguettine",
    "Linguine",
    "Mafalde",
    "Mafaldine",
    "Pappardelle",
    "Pillus",
    "Pizzoccheri",
    "Sagnarelli",
    "Scialatelli",
    "Stringozzi",
    "Tagliatelle",
    "Taglierini",
    "Trenette",
    "Tripoline",
    "Shahe Fen",
    "Biáng Biáng Noodles",
    "Calamarata",
    "Calamaretti",
    "Cannelloni",
    "Cavatappi",
    "Cellentani",
    "Chifferi",
    "Ditalini",
    "Fideuà",
    "Gomito",
    "Elicoidali",
    "Fagioloni",
    "Fusilli",
    "Garganelli",
    "Gemelli",
    "Maccheroncelli",
    "Maltagliati",
    "Manicotti",
    "Marziani",
    "Mezzani Pasta",
    "Mezze Penne",
    "Mezzi Bombardoni",
    "Mostaccioli",
    "Paccheri",
    "Pasta Al Ceppo",
    "Penne",
    "Penne Rigate",
    "Penne Lisce",
    "Penne Zita",
    "Pennette",
    "Pennoni",
    "Rigatoncini",
    "Rigatoni",
    "Sagne 'Ncannulate",
    "Spirali",
    "Spiralini",
    "Trenne",
    "Trennette",
    "Tortiglioni",
    "Tuffoli",
    "Capunti",
    "Casarecce",
    "Cavatelli",
    "Cencioni",
    "Conchiglie",
    "Conchiglioni",
    "Corzetti",
    "Creste Di Galli",
    "Croxetti",
    "Farfalle",
    "Farfalloni",
    "Fiorentine",
    "Fiori",
    "Foglie D'ulivo",
    "Gigli",
    "Gramigna",
    "Lanterne",
    "Lumache",
    "Lumaconi",
    "Maltagliati",
    "Mandala",
    "Marille",
    "Orecchiette",
    "Pipe",
    "Quadrefiore",
    "Radiatori",
    "Ricciolini",
    "Ricciutelle",
    "Rotelle",
    "Rotini",
    "Strozzapreti",
    "Torchio",
    "Trofie",
    "Gnocchi",
    "Passatelli",
    "Spätzle",
    "Acini Di Pepe",
    "Bead-like Pasta",
    "Alfabeto",
    "Anelli",
    "Anellini",
    "Couscous",
    "Conchigliette",
    "Corallini",
    "Ditali",
    "Ditalini",
    "Egg Barley",
    "Farfalline",
    "Fideos",
    "Filini",
    "Fregula",
    "Funghini",
    "Israeli Couscous",
    "Occhi Di Pernice",
    "Orzo",
    "Pastina",
    "Pearl Pasta",
    "Ptitim",
    "Quadrettini",
    "Risi",
    "Seme Di Melone",
    "Stelle",
    "Stelline",
    "Stortini",
    "Tarhana",
    "Agnolotti",
    "Cannelloni",
    "Casoncelli",
    "Casunziei",
    "Fagottini",
    "Maultasche",
    "Mezzelune",
    "Occhi Di Lupo",
    "Pelmeni",
    "Pierogi",
    "Macaroni",
    "Ravioli",
    "Sacchettini",
    "Sacchettoni",
    "Tortellini",
    "Tortelloni",
    "Ramen",
    "Whole Wheat Pasta",
]

var otherGrains: [String] = [

    "Amaranth",
    "Barley",
    "Brown Rice",
    "Brown Rice Bread",
    "Brown Rice Tortilla",
    "Buckwheat",
    "Bulgur (Cracked Wheat)",
    "Farro",
    "Flaxseed",
    "Grano",
    "Kamut® Grain",
    "Millet",
    "Oats",
    "Oat Bread",
    "Oat Cereal",
    "Oatmeal",
    "Popcorn",
    "Cerials",
    "Cereal Flakes",
    "Muesli",
    "Rolled Oats",
    "Quinoa",
    "Rice",
    "Rye",
    "Sorghum",
    "Spelt",
    "Teff",
    "Triticale",
    "Wheat Berries",
    "Cornmeal",
    "Whole Rye",
    "Pita Bread",
    "Tortillas",
    "Wild Rice",
    "White Rice",
    "Baguettes",
    "Bagels",
    "Bialys",
    "Knishes",
    "Croissants",
    "Danish",
    "Pumpernickel",
    "Rye Bread",
    "Rolls & Buns",
    "Sourdough",
    "White Bread",
    "Sliced Bread",
    "Whole Wheat Bread",
    "Multigrain Bread",
    "Cake",
    "Cupcake",
    "Chocolate Treats",
    "Cookies",
    "Brownies",
    "Muffins",
    "Scones",
    "Pies",
    "Tarts",
    "Pudding",
    "Soufflé",
    "Cornbread",
    "Corn Tortillas",
    "Couscous",
    "Flour Tortillas",
    "Grits",
    "Pitas",
    "Pretzels",
    "Naan"
]


var vegetables: [String] = [

    "Artichoke",
    "Arugula",
    "Asparagus",
    "Eggplant",
    "Amaranth",
    "Legumes",
    "Alfalfa Sprouts",
    "Bean Sprouts",
    "Soy Bean Sprouts",
    "Beet Greens",
    "Bok Choy",
    "Broccoflower",
    "Broccoli",
    "Brussels Sprouts",
    "Canned Vegetables",
    "Cabbage",
    "Calabrese",
    "Carrots",
    "Cauliflower",
    "Celery",
    "Chard",
    "Collard Greens",
    "Corn Salad",
    "Endive",
    "Fiddleheads",
    "Frisee",
    "Fennel",
    "Herbs And Spices",
    "Anise",
    "Basil",
    "Caraway",
    "Cilantro",
    "Coriander",
    "Chamomile",
    "Dill",
    "Fennel",
    "Lavender",
    "Lemon Grass",
    "Marjoram",
    "Oregano",
    "Parsley",
    "Rosemary",
    "Sage",
    "Thyme",
    "Kale",
    "Kohlrabi",
    "Lettuce",
    "Corn",
    "Mushrooms",
    "Mustard Greens",
    "Nettles",
    "New Zealand Spinach",
    "Napa Cabbage",
    "Okra",
    "Onion Family",
    "Chives",
    "Garlic",
    "Leek Allium Porrum",
    "Onion",
    "Shallot",
    "Green Onion",
    "Scallion",
    "Parsley",
    "Peppers",
    "Green Pepper",
    "Red Pepper",
    "Bell Pepper",
    "Chili Pepper",
    "Jalapeño",
    "Habanero",
    "Paprika",
    "Tabasco Pepper",
    "Cayenne Pepper",
    "Radicchio",
    "Rhubarb",
    "Root Vegetables",
    "Beet",
    "mangel-wurzel",
    "Carrot",
    "Celeriac",
    "Daikon",
    "Ginger",
    "Parsnip",
    "Rutabaga",
    "Turnip",
    "Radish",
    "Swede",
    "Rutabaga",
    "Turnip",
    "Wasabi",
    "Horseradish",
    "White Radish",
    "Salsify",
    "Skirret",
    "Spinach",
    "Topinambur",
    "Squashes",
    "Acorn Squash",
    "Butternut Squash",
    "Banana Squash",
    "Courgette",
    "Zucchini",
    "Cucumber",
    "Delicata",
    "Gem Squash",
    "Hubbard Squash",
    "Marrow",
    "Squash",
    "Patty Pans",
    "Pumpkin",
    "Spaghetti Squash",
    "Tat Soi",
    "Tomato",
    "Tubers",
    "Jicama",
    "Jerusalem Artichoke",
    "Potato",
    "Sunchokes",
    "Sweet Potato",
    "Taro",
    "Yam",
    "Turnip Greens",
    "Water Chestnut",
    "Watercress",
    "Zucchini",
    "String Beans",
    "Bamboo Shoots",
    "Snow Pea Shoots",
    "Chinese Broccoli"
]


var fruits: [String] = [

    "Apple",
    "Apricot",
    "Avocado",
    "Banana",
    "Bilberry",
    "Blackberry",
    "Blackcurrant",
    "Blueberry",
    "Boysenberry",
    "Canned Fruit",
    "Currant",
    "Cherry",
    "Cherimoya",
    "Cloudberry",
    "Coconut",
    "Cranberry",
    "Cucumber",
    "Custard Apple",
    "Damson",
    "Date",
    "Dragonfruit",
    "Durian",
    "Elderberry",
    "Feijoa",
    "Fig",
    "Goji Berry",
    "Gooseberry",
    "Grape",
    "Raisin",
    "Grapefruit",
    "Guava",
    "Honeyberry",
    "Huckleberry",
    "Jabuticaba",
    "Jackfruit",
    "Jambul",
    "Jujube",
    "Juniper Berry",
    "Kiwi",
    "Kumquat",
    "Lemon",
    "Lime",
    "Loquat",
    "Longan",
    "Lychee",
    "Mango",
    "mangosteen",
    "Marionberry",
    "Melon",
    "Cantaloupe",
    "Honeydew",
    "Watermelon",
    "Miracle Fruit",
    "Mulberry",
    "Nectarine",
    "Nance",
    "Olive",
    "Orange",
    "Blood Orange",
    "Clementine",
    "Mandarine",
    "Tangerine",
    "Papaya",
    "Passionfruit",
    "Peach",
    "Pear",
    "Persimmon",
    "Physalis",
    "Plantain",
    "Plum",
    "Prune (Dried Plum)",
    "Pineapple",
    "Plumcot",
    "Pomegranate",
    "Pomelo",
    "Quince",
    "Raspberry",
    "Salmonberry",
    "Rambutan",
    "Redcurrant",
    "Salal Berry",
    "Salak",
    "Satsuma",
    "Star Fruit",
    "Strawberry",
    "Tamarillo",
    "Tamarind",
    "Tomato",
    "Ugli Fruit",
    "Yuzu",
    "Udara"
]

var dairy: [String] = [

    "America Cheese",
    "Bleu Cheese",
    "Brie Cheese",
    "Cheddar Cheese",
    "Cheese",
    "Cottage Cheese",
    "Cream Cheese",
    "Feta",
    "Goat Cheese",
    "Mozzarella",
    "Parmesan",
    "Provolone",
    "Ricotta",
    "Firm Cheese",
    "Soft Cheese",
    "Sandwich Slices",
    "Swiss Cheese",
    "Roquefort",
    "Camembert",
    "Cotija",
    "Chèvre",
    "Emmental",
    "Gouda",
    "Goat Cheese",
    "Taleggio",
    "Parmigiano-Reggiano",
    "Manchego",
    "Monterey Jack",
    "Pepper Jack",
    "Dry Jack",
    "String Cheese",
    "Vegetarian Cheese",
    "Milk - Whole",
    "Milk - 2%",
    "Milk - 1%",
    "Milk - Low Fat",
    "Skim Milk",
    "Milk - Whole Lactose",
    "Lactose Milk 2%",
    "Lactose Milk Fat-Free",
    "Whole Lactose-Free Milk",
    "2% Lactose-Free Milk",
    "Nonfat Lactose-Free Milk",
    "Powdered (Dry) Milk",
    "Nonfat Powdered Milk",
    "Evaporated Milk",
    "Condensed Milk",
    "Skimmed Evaporated Milk",
    "Chocolate Flavored Milk",
    "Strawberry Flavored Milk",
    "Skim Milk",
    "Banana Milk",
    "Yogurt - Whole Milk",
    "Yogurt - Low Fat",
    "Yogurt - Fat-Free",
    "Fat-Free Fruit Yogurt",
    "Greek Plain Yogurt",
    "Greek Low Fat Yogurt",
    "Greek Nonfat Yogurt",
    "Drinkable Yogurt",
    "Lowfat Drinkable Yogurt",
    "Butter",
    "Butter - Salted",
    "Butter - Unsalted",
    "Margarine",
    "Block Butter",
    "Spreadable Butter",
    "Olive Spread",
    "Sunflower Spread",
    "Organic Butter & Spread ",
    "Flavored & Sweet Butter ",
    "Dairy Free Spread",
    "Baking Fat",
    "Cooking Fat",
    "Sour Cream",
    "Whipped Cream",
    "Ice Cream",
    "Gelato",
    "Popsicle",
    "Frozen Yogurt"
]


var meatsSeafoodsAndEggs: [String] = [

    "Sausage",
    "Beef",
    "Chicken",
    "Brown Eggs",
    "White Eggs",
    "Eggs",
    "Organic Eggs",
    "Free-range Eggs",
    "Cage-free Eggs",
    "Ground Turkey",
    "Ground Chicken",
    "Ham",
    "Pork",
    "Rabbit",
    "Goat",
    "Hot dogs",
    "Lunchmeat",
    "Turkey",
    "Pork",
    "Beef Steak",
    "Lamb",
    "Pork Chop",
    "Pork Cutlet",
    "Ground Beef",
    "Beef Chuck",
    "Beef Shank",
    "Beef Brisket",
    "Beef Rib",
    "Beef Short Plate",
    "Beef Flank",
    "Beef Loin",
    "Beef Sirloin",
    "Beef The round",
    "Beef Tongue",
    "Beef Neck",
    "Beef Knuckle",
    "Pork Back Ribs",
    "Pork Bacon",
    "Pork Belly",
    "Pork Steak ",
    "Pork Country-style Ribs",
    "Pork Crown Roast",
    "Pork Cubed and Sliced",
    "Ground Pork",
    "Pork Ham",
    "Pork Loin Roast",
    "Pork Pork Chops",
    "Pork Brisket",
    "Pork Sausage",
    "Pork Shoulder",
    "Pork Spareribs",
    "Pork Tenderloin",
    "Fish",
    "Tuna",
    "Crab",
    "Fish Fillets",
    "Fish Steaks",
    "Fish Whole",
    "Lobster",
    "Mussels",
    "Clams",
    "Oysters",
    "Salmon",
    "Scallops",
    "Shrimp",
    "Prepped Fish",
    "Prepped Shellfish"
]

var beansPeasAndTofu: [String] = [
    "Azuki Beans",
    "Black Beans",
    "Baked Beans",
    "Black-eyed Peas",
    "Borlotti Bean",
    "Broad Beans",
    "Canned Beans",
    "Chickpeas",
    "Green Beans",
    "Kidney Beans",
    "Lentils",
    "Lima Beans",
    "Mung Beans",
    "Navy Beans",
    "Pinto Beans",
    "Runner Beans",
    "Split Beans",
    "Soy Beans",
    "Peas",
    "Mangetout/Snap Peas",
    "Tofu"

]

var nutsAndSeeds: [String] = [
    "Almond",
    "Australian Nut",
    "Beech",
    "Black Walnut",
    "Blanched Almond",
    "Brazil Nut",
    "Butternut",
    "Candle Nut",
    "Candlenut",
    "Cashew",
    "Chestnuts",
    "Chinese Almond",
    "Chinese Chestnut",
    "Chinkapin",
    "Chufa Nut",
    "Cobnut",
    "Colocynth",
    "Country Walnut",
    "Cream Nut",
    "Cucurbita Ficifolia",
    "Earth Almond",
    "Earth Nut",
    "English Walnuts",
    "Filbert",
    "Florida Almond",
    "Gevuina Avellana",
    "Gingko Nut",
    "Hazelnut",
    "Heartnut",
    "Hickory Nut",
    "Horned Water Chestnut",
    "Indian Beech",
    "Indian Nut",
    "Japanese Walnut",
    "Java Almond",
    "Jesuit Nut",
    "Juniper Berry",
    "Kluwak Nuts",
    "Kola Nut",
    "Macadamia",
    "Malabar Chestnut",
    "Mamoncillo",
    "Maya Nut",
    "Mongongo",
    "Oak Acorns",
    "Ogbono Nut",
    "Para Nut",
    "Paradise Nut",
    "Pecan",
    "Persian Walnuts",
    "Pili Nut",
    "Pine Nut",
    "Pine Nut",
    "Pinyon",
    "Pistachio Nut",
    "Pistacia",
    "Polynesian Chestnut",
    "Queensland Nut",
    "Royal Walnuts",
    "Rush Nut",
    "Sapucaya Nut",
    "Sapucia Nut",
    "Shagbark Hickory",
    "Sliced Almonds",
    "Slivered Almond",
    "Sweet Almond",
    "Sweet Chestnut",
    "Terminalia Catappa",
    "Tiger Nut",
    "Walnut",
    "Water Caltrop",
    "White Nut",
    "White Walnut",
    "Chia Seeds",
    "Flaxseed",
    "Hemp Seeds",
    "Poppy Seed",
    "Pumpkin Seeds",
    "Sesame Seed",
    "Safflower",
    "Sunflower"
]


var beverages: [String] = [
    "Water",
    "Sprite",
    "Club Soda",
    "Soy Milk",
    "Rice Milk",
    "Almond Milk",
    "Oat Milk",
    "Flax Milk",
    "Hazenut Milk",
    "Hemp Milk",
    "Quinoa Milk",
    "Cashew Milk",
    "Coconut Milk",
    "Soy Milk",
    "Coke",
    "Pepsi",
    "Ginger Ale",
    "Orange Soda",
    "Lemonade",
    "Sport Drinks",
    "Energy Drinks",
    "Soda",
    "Sparkling Water",
    "Seltzer",
    "Iced Tea",
    "Water",
    "Protein Drinks",
    "Tonic Water",
    "Coconut Water",
    "Cold Pressed Juice",
    "Smoothies",
    "Orange Juice",
    "Tomato Juice",
    "Aloe Vera Juice",
    "Aloe Juice",
    "Sugarcane Juice",
    "Apple Juice ",
    "Coconut water",
    "Cranberry Juice",
    "Grape Juice",
    "Grapefruit Juice",
    "Kiwifruit Juice ",
    "Lemonade",
    "Lemon Juice",
    "Limeade Limes",
    "Lychee Juice",
    "Limonana",
    "Melon Juice",
    "Cantaloupe Juice",
    "Honeydew Juice",
    "Blackberries Juice",
    "Grape Juice",
    "Orange Juice",
    "Papaya Juice",
    "Pineapple Juice",
    "Passionfruit Juice",
    "Pomegranate Juice",
    "Prune Juice",
    "Raspberry Juice",
    "Strawberry Juice",
    "Winter Melon Juice",
    "Beet Juice",
    "Carrot Juice",
    "Spinach Juice",
    "Tomato Juice",
    "Guava Juice",
    "Juice",
    "Coffee",
    "Tea",
    "Ground Coffee",
    "French Roast Coffee",
    "Dark Roast Coffee",
    "Medium Roast Coffee",
    "Light Roast Coffee",
    "Organic Coffee",
    "Earl Grey Tea",
    "English Breakfast Tea",
    "Peppermint Tea",
    "Whole Bean Coffee",
    "Iced Coffee",
    "Green Tea",
    "Black Tea",
    "Hot Cocoa",
    "Lemon Tea",
    "Ginger Tea",
    "Honey Tea",
    "K-cups",
    "Espresso Capsules",
    "Detox Tea",
    "Mint Tea",
    "Herbal Tea",
    "Jasmin Tea",
    "Decaf Coffee",
    "Decaf Tea",
    "Matcha Powder",
    "Chamomile Tea"
]

var alcoholicBeverages: [String] = [

    "Beer",
    "Light Beer",
    "Root Beer",
    "Wine",
    "Red Wine",
    "White Wine",
    "Rosé Wine",
    "Cooking Wine",
    "Dessert Wine",
    "Sparkling Wine",
    "Gin",
    "Vodka",
    "Whisky",
    "Irish Whiskey",
    "Canadian Whiskey",
    "Cognac",
    "Moscato",
    "Rum",
    "Brandy",
    "Liqueurs",
    "Vermouth",
    "Bitters",
    "Mixers",
    "Tequila",
    "Mezcal",
    "Amaretto",
    "Soju",
    "Sake",
    "Irish Cream",
    "Ice Wine",
    "Margarita"
]


var condimentsAndSauce: [String] = [

    "A-1 Steak Sauce",
    "Agar",
    "Agave Nectar",
    "Apple Sauce",
    "Aspartame",
    "Baker’s Yeast",
    "Baking Soda",
    "Barbecue Sauce",
    "Barley Malt",
    "Pepper",
    "Pepper - Black",
    "Pepper - White",
    "BBQ Sauce",
    "Blackstrap Molasses",
    "Bragg’s Amino Acids",
    "Capers",
    "Chili Sauce",
    "Chipotle",
    "Chutney",
    "Cocktail Sauce",
    "Corn Syrup",
    "Cranberry Sauce",
    "Curry Sauce",
    "Dextrose",
    "Enchilada Sauce",
    "Epazote",
    "Fish Sauce",
    "Fry Sauce",
    "Garlic Powder",
    "Paprika Powder",
    "Gelatin",
    "Ginger Relish",
    "Gluten Free Condiments",
    "Glycerin, Vegetable",
    "Green Sauce",
    "Guacamole",
    "High Fructose Corn Syrup",
    "Honey",
    "Honey Mustard",
    "Hosin Sauce",
    "Hot Sauces",
    "Ketchup",
    "Lecithin",
    "Steak Sauce",
    "Lemon Juice",
    "Lime Juice",
    "Mango Sauce",
    "Maple Syrup",
    "Marmite",
    "Mayonnaise",
    "Mayonnaise, Light",
    "Mayonnaise, Vegan",
    "Mint Jelly",
    "Miso, Soy",
    "Molasses",
    "MSG",
    "Mustard",
    "Mustard, Yellow",
    "Olives",
    "Onions",
    "Orange Sauce",
    "Oyster Sauce",
    "Pectin",
    "Pesto",
    "Picante Sauce",
    "Pickles",
    "Plum Sauce",
    "Relish, Pickle",
    "Rice Syrup",
    "Salsas",
    "Salt",
    "Salt, Sea",
    "Salt, Garlic",
    "Sauerkraut",
    "Sesame Oil",
    "Soy Sauce",
    "Stevia",
    "Stir Fry Sauce",
    "Sugar, Brown,",
    "Sugar, White",
    "Sriracha Sauce",
    "Sweet and Sour Sauce",
    "Tabasco sauce",
    "Tamari",
    "Tartar Sauce",
    "Teriyaki Sauce",
    "Teriyaki Sauce",
    "Thai Peanut Sauce",
    "Vegan Condiments",
    "Vinegar",
    "Worcestershire Sauce",
    "Yeast Extract Spread",
    "Yeast, Nutritional",
    "Pasta Sauce",
    "Tomato Sauce",
    "Hummus",
    "Yogurt Dip",
    "Strawberry Jam",
    "Blueberry Jam",
    "Mixed-berry Jam"

]



