// ===========================================
// GLOVES SHOP - MongoDB Initialization
// ===========================================

// CATALOGUE DATABASE
db = db.getSiblingDB('catalogue');

db.products.drop();

db.products.insertMany([
    {
        sku: "GLOVE-001",
        name: "Winter Thermal Gloves",
        description: "Premium insulated gloves designed for extreme cold weather.",
        price: 29.99,
        instock: 150,
        categories: ["Winter", "Outdoor"],
        image: "/images/winter-thermal.jpg"
    },
    {
        sku: "GLOVE-002",
        name: "Leather Driving Gloves",
        description: "Classic Italian leather driving gloves with knuckle holes.",
        price: 49.99,
        instock: 75,
        categories: ["Driving", "Fashion"],
        image: "/images/leather-driving.jpg"
    },
    {
        sku: "GLOVE-003",
        name: "Touchscreen Winter Gloves",
        description: "Conductive fingertips work with all touchscreen devices.",
        price: 24.99,
        instock: 200,
        categories: ["Winter", "Tech"],
        image: "/images/touchscreen.jpg"
    },
    {
        sku: "GLOVE-004",
        name: "Gardening Gloves",
        description: "Durable protection for outdoor gardening. Thorn-resistant.",
        price: 15.99,
        instock: 300,
        categories: ["Work", "Outdoor"],
        image: "/images/gardening.jpg"
    },
    {
        sku: "GLOVE-005",
        name: "Boxing Training Gloves",
        description: "Professional grade 14oz training gloves with wrist support.",
        price: 59.99,
        instock: 50,
        categories: ["Sports", "Training"],
        image: "/images/boxing.jpg"
    },
    {
        sku: "GLOVE-006",
        name: "Nitrile Disposable Gloves",
        description: "Pack of 100 powder-free nitrile gloves. Medical grade.",
        price: 19.99,
        instock: 500,
        categories: ["Medical", "Work"],
        image: "/images/nitrile.jpg"
    },
    {
        sku: "GLOVE-007",
        name: "Cycling Gloves",
        description: "Padded palm cycling gloves with gel inserts.",
        price: 22.99,
        instock: 120,
        categories: ["Sports", "Cycling"],
        image: "/images/cycling.jpg"
    },
    {
        sku: "GLOVE-008",
        name: "Welding Gloves",
        description: "Heavy duty heat-resistant leather gloves for welding.",
        price: 34.99,
        instock: 80,
        categories: ["Work", "Industrial"],
        image: "/images/welding.jpg"
    }
]);

db.products.createIndex({ name: "text", description: "text" });
print("Catalogue: " + db.products.countDocuments() + " products");

// USERS DATABASE
db = db.getSiblingDB('users');

db.users.drop();

db.users.insertMany([
    { name: "user", password: "password", email: "user@glovesshop.com" },
    { name: "demo", password: "demo123", email: "demo@glovesshop.com" },
    { name: "heeta", password: "heeta2024", email: "heeta@glovesshop.com" }
]);

db.users.createIndex({ name: 1 }, { unique: true });
print("Users: " + db.users.countDocuments() + " users");

// ORDERS COLLECTION
db.orders.drop();
print("=== MongoDB Initialization Complete ===");