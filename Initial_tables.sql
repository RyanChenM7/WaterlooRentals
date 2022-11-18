-- these are all queries generated by the RentalsDB python file to initialize
-- and fill our tables with sample data.
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL, 
    username VARCHAR(500), 
    password VARCHAR(500), 
    fname VARCHAR(100), 
    lname VARCHAR(100), 
    phone VARCHAR(20), 
    email VARCHAR(500), 
    PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS listings (
    id INT NOT NULL, 
    user_id INT NOT NULL, 
    address VARCHAR(1000), 
    city VARCHAR(300), 
    province VARCHAR(300), 
    rooms INT, 
    bathrooms INT, 
    feet INT, 
    heating INT, 
    water INT, 
    hydro INT, 
    type VARCHAR(300), 
    parking INT, 
    price INT, 
    months INT, 
    comment VARCHAR(2000), 
    PRIMARY KEY (id, user_id), 
    FOREIGN KEY (user_id) REFERENCES users(id));

-- INSERT sample data
INSERT INTO users VALUES ('1', 'test1', 'password1', 'Joe', 'Bad', '5493029283', 'joe@gmail.com');
INSERT INTO users VALUES ('2', 'test2', 'password2', 'Steve', 'Pai', '5190981234', 'steve@yahoo.com');
INSERT INTO users VALUES ('3', 'test3', 'password3', 'Robert', 'Li', '1234567890', 'robert@gmail.com');
INSERT INTO users VALUES ('4', 'test4', 'password4', 'Dido', 'Hagano', '2264441896', 'dhagano@gmail.com');
INSERT INTO users VALUES ('5', 'test5', 'password5', 'Jadyn', 'Candela', '2264750261', ' jcandela@hotmail.com');
INSERT INTO users VALUES ('6', 'test6', 'password6', 'Antonio', 'Erika', '5197657847', ' erika_antonio@outlook.com');
INSERT INTO users VALUES ('7', 'test7', 'password7', 'Kamil', 'Steph', '6472064708', 'StephKamil@gmail.com');
INSERT INTO users VALUES ('8', 'test8', 'password8', 'Ana', 'Sigrid', '9059761022', 'SigridA@hotmail.com');
INSERT INTO users VALUES ('9', 'test9', 'password9', 'Lucia', 'Shel', '2898471495', 'Lucia@gmail.com');
INSERT INTO users VALUES ('10', 'test10', 'password10', 'Fannar', 'Ghulam', '4372037654', 'Fannar@gmail.com');
INSERT INTO users VALUES ('11', 'test11', 'password11', 'Bhavana', 'Milka', '5199415346', 'Bhavana@gmail.com');
INSERT INTO users VALUES ('12', 'test12', 'password12', 'Plato', 'Erranum', '2265571202', 'Plato@gmail.com');
INSERT INTO users VALUES ('13', 'test13', 'password13', 'Torston', 'Heard', '5196409346', 'Torston@gmail.com');
INSERT INTO users VALUES ('14', 'test14', 'password14', 'Juda', 'Damyan', '2891637159', 'Juda@gmail.com');
INSERT INTO users VALUES ('15', 'test15', 'password15', 'Cristen', 'Naveen', '4379224906', 'Cristen@gmail.com');
INSERT INTO users VALUES ('16', 'test16', 'password16', 'Rosanna', 'Haytham', '5199708161', 'Rosanna@gmail.com');
INSERT INTO users VALUES ('17', 'test17', 'password17', 'Julia', 'Smith', '2267253549', 'Julia@gmail.com');
INSERT INTO users VALUES ('18', 'test18', 'password18', 'Tajana', 'Almat', '2264888729', 'Tajana@gmail.com');
INSERT INTO users VALUES ('19', 'test19', 'password19', 'Lenart', 'Helge', '5197847478', 'Lenart@gmail.com');
INSERT INTO users VALUES ('20', 'test20', 'password20', 'Basmath', 'Ludo', '4168985488', 'Basmath@gmail.com');
INSERT INTO listings VALUES ('0', '0', '422 Hazel Street', 'Waterloo', 'Ontario', '1', '1', '700', '1', '1', '1', 'Apartment', '1', '1800', '4', 'Good place to live');
INSERT INTO listings VALUES ('1', '1', '261 Lester Street', 'Waterloo', 'Ontario', '5', '2', '1100', '1', '1', '1', 'Shared room', '1', '495', '8', 'Best for single students');
INSERT INTO listings VALUES ('2', '1', '275 Larch Street', 'Waterloo', 'Ontario', '1', '1', '750', '1', '1', '1', 'Condo', '0', '2000', '4', 'Short-term lease only!');
INSERT INTO listings VALUES ('3', '1', '520 Parkside Drive', 'Waterloo', 'Ontario', '2', '1', '900', '1', '1', '0', 'Apartment', '1', '1800', '12', 'Long-term lease only!');
INSERT INTO listings VALUES ('4', '2', '250 Albert Street', 'Waterloo', 'Ontario', '1', '1', '695', '0', '0', '0', 'Condo', '0', '1800', '4', 'N/A');
INSERT INTO listings VALUES ('5', '3', '161 University Avenue East', 'Waterloo', 'Ontario', '2', '1', '800', '1', '1', '0', 'Condo', '1', '1905', '8', 'Close to universities');
INSERT INTO listings VALUES ('6', '3', '415 Keats Way', 'Waterloo', 'Ontario', '2', '1', '637', '1', '1', '1', 'Apartment', '0', '2250', '12', '');
INSERT INTO listings VALUES ('7', '4', '261 Lester Street', 'Waterloo', 'Ontario', '4', '2', '1226', '0', '1', '1', 'Condo', '1', '3150', '4', 'Includes heating, water, hi-speed WIFI and underground parking!');
INSERT INTO listings VALUES ('8', '5', '271 Lester Street', 'Waterloo', 'Ontario', '2', '2', '751', '0', '0', '1', 'Apartment', '0', '1495', '12', 'Residents enjoy the many amenities including convenience, parking, modern security systems, community events and attentive, friendly staff! Many of our suites are unique with an array of stylish features such as: ceramic tiles, new appliances, private balconies and much more!');
INSERT INTO listings VALUES ('9', '6', '1 Columbia St. W', 'Waterloo', 'Ontario', '1', '1', '400', '1', '0', '1', 'Condo', '0', '770', '8', 'This luxury student community includes a spacious kitchen area and living space, ensuite bathrooms and lots of storage space! A mix of laminate and tile flooring finishes compliment the stylish kitchen amenities including modern granite countertops & chic fixtures. These fully-furnished apartments include 5-bedrooms and individual bathrooms. Known for its sweeping views, floor to ceiling windows and modern paint pallet throughout, the MARQ at 1 Columbia Street is one of the most sought-after places to live in Waterloo!');
INSERT INTO listings VALUES ('10', '6', '1 Columbia St. W', 'Waterloo', 'Ontario', '1', '1', '450', '1', '0', '1', 'Condo', '0', '795', '8', 'This luxury student community includes a spacious kitchen area and living space, ensuite bathrooms and lots of storage space! A mix of laminate and tile flooring finishes compliment the stylish kitchen amenities including modern granite countertops & chic fixtures. These fully-furnished apartments include 5-bedrooms and individual bathrooms. Known for its sweeping views, floor to ceiling windows and modern paint pallet throughout, the MARQ at 1 Columbia Street is one of the most sought-after places to live in Waterloo!');
INSERT INTO listings VALUES ('11', '7', '316 King Street North', 'Waterloo', 'Ontario', '1', '1', '300', '0', '1', '1', 'Shared room', '1', '950', '4', 'Amenities Included: Fitness rooms, Games room, Onsite laundry facility, The MARQ Residence life programs â€“ regular resident events');
INSERT INTO listings VALUES ('12', '8', '140 Lincoln Road', 'Waterloo', 'Ontario', '1', '1', '1000', '1', '0', '1', 'Apartment', '1', '1875', '4', 'Well maintained buildings in Waterloo. Within walking distance to schools and shopping including 24hr shopping at Sobeys, Shoppers Drugmart and others. Outdoor swimming pool, billiard room, party room, exercise room. Located next to the Moser Springer Park, and the Waterloo Transit bus route. Indoor parking!') ;
INSERT INTO listings VALUES ('13', '9', '57 Union Street', 'Waterloo', 'Ontario', '1', '1', '656', '1', '1', '1', 'Condo', '0', '1650', '8', 'Located near Kitchener-Waterloo Hospital and downtown Waterloo, Metropolitan Towers features shopping and schools only steps away from the front door as well as many local dining options. 57 Union Street East is located within walking distance of public transit including the new LRT, close to Waterloo Town Square, Walmart and Sobeys, Banks, and Parks!');
INSERT INTO listings VALUES ('14', '10', '529 Sunnydale Place', 'Waterloo', 'Ontario', '3', '2', '1450', '1', '1', '1', 'Apartment', '0', '2600', '16', 'This luxurious three-level town-home is located in Lakeshore Village, and offers a host of amenities. These large, fully renovated town-homes offer storage space, finished basements, 2 washrooms, stainless steel appliances, dishwasher, roomy kitchen and in unit washer and dryer, and many additional upgrades. The property boasts a playground, indoor parking and much more! We are minutes from parks, shopping, schools and much more!');
INSERT INTO listings VALUES ('15', '11', '736 Old Albert Street', 'Waterloo', 'Ontario', '1', '1', '1000', '1', '1', '1', 'Apartment', '1', '1875', '12', 'SPACIOUS ONE AND TWO BEDROOM APARTMENTS');
INSERT INTO listings VALUES ('16', '11', '736 Old Albert Street', 'Waterloo', 'Ontario', '2', '1', '546', '1', '1', '1', 'Apartment', '1', '1600', '12', 'SPACIOUS ONE AND TWO BEDROOM APARTMENTS');
INSERT INTO listings VALUES ('17', '11', '736 Old Albert Street', 'Waterloo', 'Ontario', '2', '1', '848', '1', '1', '1', 'Apartment', '0', '2250', '12', 'SPACIOUS ONE AND TWO BEDROOM APARTMENTS');
INSERT INTO listings VALUES ('18', '12', '345 King Street North', 'Waterloo', 'Ontario', '1', '1', '500', '1', '1', '1', 'Shared room', '1', '685', '4', 'Located close to both Laurier University and University of Waterloo - this location is perfect for all students. The property offers fully furnished bedrooms and free Hi-speed WIFI. Come as a pair, individually, or as a group. Save the travel time to the property and meet us on Skype, Facetime, or Whatsapp.');
INSERT INTO listings VALUES ('19', '12', '345 King Street North', 'Waterloo', 'Ontario', '1', '1', '512', '1', '1', '1', 'Shared room', '0', '710', '4', 'Located close to both Laurier University and University of Waterloo - this location is perfect for all students. The property offers fully furnished bedrooms and free Hi-speed WIFI. Come as a pair, individually, or as a group. Save the travel time to the property and meet us on Skype, Facetime, or Whatsapp.');
INSERT INTO listings VALUES ('20', '13', '168 King St. North', 'Waterloo', 'Ontario', '1', '1', '432', '1', '1', '1', 'Condo', '1', '799', '8', '');
INSERT INTO listings VALUES ('21', '14', '300 Regina Street North', 'Waterloo', 'Ontario', '1', '1', '690', '1', '1', '1', 'Apartment', '1', '1715', '12', "If you feel like you are going on an epic adventure to find your new home good news you don't have to worry about all the hassles of finding student housing. 300 Regina Street is close to the University of Waterloo, Wilfred Laurier University, grocery stores, restaurants, parks, community centres and public transit! Our renovated suites are bright and modern and some of the biggest in Waterloo, making them great for entertaining, group studying, or just hanging out. They are open concept and the private balconies offer great city and university views. Rent alone or share with friends, all students welcome!");