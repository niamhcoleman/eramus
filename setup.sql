CREATE DATABASE IF NOT EXISTS desapi;

USE desapi;

#Alex start
CREATE TABLE IF NOT EXISTS `desapi`.`diaryentry` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `meal` int(11) NOT NULL,
  `image_path` varchar(1000) NOT NULL,
  `entry_date` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `iso_datetime` varchar(500) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`entry_id`));


CREATE TABLE IF NOT EXISTS `desapi`.`ingredient` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `quantity` varchar(500) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`ingredient_id`));

CREATE TABLE IF NOT EXISTS `desapi`.`recipe` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `cooking_time_hrs` varchar(50) NOT NULL,
  `cooking_time_min` varchar(50) NOT NULL,
  `shared` tinyint(1) NOT NULL,
  `meal` int(11) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`recipe_id`));

CREATE TABLE IF NOT EXISTS `desapi`.`recipestep` (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `step_number` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`step_id`));

/*Peter start */; 
CREATE TABLE IF NOT EXISTS `info` (
  `id` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOCK TABLES `info` WRITE;
INSERT INTO `info` VALUES (1,'Getting Coeliac Disease'),(2,'Foods To Avoid'),(3,'Good Foods'),(4,'Symptoms'),(5,'Health'),(6,'Genetics'),(7,'Coeliac as a Disease'),(8,'Tips for Eating Out');
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `info_content` (
  `info_title_id` int(11) NOT NULL,
  `info_point` varchar(120) NOT NULL,
  PRIMARY KEY (`info_title_id`,`info_point`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOCK TABLES `info_content` WRITE;
INSERT INTO `info_content` VALUES (1,'A person can become intolerant to gluten at any age'),(1,'An intolerance to gluten can develop at any time'),(1,'Coeliac disease is incurable'),(1,'Coeliac disease often runs in families'),(1,'Research shows that coeliac disease is strongly associated with a number of genetic mutations'),(2,'Bread'),(2,'Cereal'),(2,'Most seasonings and spices'),(2,'Pasta'),(2,'Pizza'),(3,'Fruit and vegetables'),(3,'Gluten-free flours, including rice, corn, soy and potato'),(3,'Meat and fish (although not breaded or battered)'),(3,'Most dairy products, such as cheese, butter and milk'),(3,'Potatoes'),(3,'Rice and rice noodles'),(4,'Anaemia ( breathlessness and an irregular heartbeat, caused by a lack of iron in the blood)'),(4,'Bloating'),(4,'Indigestion'),(4,'Loss of appetite'),(4,'Mild abdominal (stomach) pain'),(4,'Occasional changes in bowel habit, such as episodes of mild diarrhoea or constipation'),(4,'Some loss of hair (alopecia, usually only affects adults)'),(4,'Tingling and numbness in your hands and feet (neuropathy)'),(4,'Vomiting (usually only affects children)'),(5,'A GIP test can determine if you have ingested gluten'),(5,'However, in coeliac disease, the damage and inflammation to the lining of your gut flattens the villi'),(5,'If you have coeliac disease, eating gluten results in damage to your intestines'),(5,'Never ingesting gluten is the only way to not experience the symptoms of Coeliac disease'),(5,'The surface of the gut lining is usually covered with millions of tiny tube-shaped growths called villi'),(5,'Villi increase the surface area of your gut and help it to digest food more effectively'),(5,'Which reduces their ability to help with digestion'),(5,'Women are 3 times more likely to develop Coeliac disease'),(6,'Coeliac disease is not contagious'),(6,'Coeliac disease often runs in families'),(6,'Genes are responsible for the development of the immune system, and may be passed down through a family'),(6,'If you have an identical twin with coeliac disease, there is an 85% chance that you will also develop the condition'),(6,'The risk of developing coeliac disease if you have a close relative with it is approximately 10%'),(7,' Coeliac disease is considered to be more prevalent in people with autoimmune conditions'),(7,'An autoimmune disease is a condition in which your immune system mistakenly attacks your body'),(7,'Coeliac disease is an auto-immune disease'),(7,'Other autoimmune diseases are type 1 diabetes and Rheumatoid arthritis'),(8,'Be very specific in your questions about each item'),(8,'Confirm your order before eating'),(8,'Have your food prepared on a clean cooking surface, with clean utensils'),(8,'Medic alert bracelets help give credibility to the seriousness of your diet restrictions'),(8,'Time your meal either before or after the busiest meal time'),(8,'You may need to ask extensive questions about the foods and preparation'),(8,'You will have more time and easier access to the people who can help you');
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `quiz_answers` (
  `quiz_question_id` int(11) NOT NULL,
  `answer` varchar(100) NOT NULL,
  PRIMARY KEY (`quiz_question_id`,`answer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


LOCK TABLES `quiz_answers` WRITE;
INSERT INTO `quiz_answers` VALUES (1,'Antibiotics'),(1,'Snake Oil'),(1,'There is no cure'),(2,'Fever'),(2,'Indigestion'),(2,'Jaundice'),(3,'Bread'),(3,'Carrots'),(3,'Chicken'),(4,'1'),(4,'14'),(4,'Any Age'),(5,'Both are Equal'),(5,'Men'),(5,'Women'),(6,'No'),(6,'Yes'),(7,'Dont ingest gluten'),(7,'Stop eating'),(7,'Take exercise'),(8,'15%'),(8,'30%'),(8,'85%'),(9,'Early'),(9,'Late'),(9,'Rush Hour'),(10,'Both'),(10,'Clean Cooking Surface'),(10,'Clean Utensils'),(11,'Confirm your Order'),(11,'Forget your Order'),(11,'Go on their Break'),(12,'A Lifestyle'),(12,'A Virus'),(12,'An Autoimmune Disease'),(13,'Attacks Itself'),(13,'Gets Stronger'),(13,'Stops Working'),(14,'Influenza'),(14,'Measles'),(14,'Type 1 Diabetes');
UNLOCK TABLES;


CREATE TABLE IF NOT EXISTS `quiz_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(80) NOT NULL,
  `correct` varchar(80) NOT NULL,
  `category` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

LOCK TABLES `quiz_questions` WRITE;
INSERT INTO `quiz_questions` VALUES (1,'What is the cure for coeliac disease?','There is no cure','Getting Coeliac Disease'),(2,'Which of these is a sympton of gluten ingestion?','Indigestion','Symptoms'),(3,'Which of these foods contain gluten?','Bread','Foods To Avoid'),(4,'What age do you have to be to develop Coeliacs disease?','Any Age','Getting Coeliac Disease'),(5,'Which gender is more likely to develop Coeliacs disease?','Women','Health'),(6,'Do fruit and vegetables contain gluten?','No','Good Foods'),(7,'How does a Coeliac stop experiencing Coeliac symptoms','Dont ingest gluten','Good Foods'),(8,'If your identical twin has Coeliac Disease, what are the chances you\'ll get it?','85%','Genetics'),(9,'What is the worst time to go to a restaurant?','Rush Hour','Tips for Eating Out'),(10,'What needs to be clean when the chef prepares food?','Both','Tips for Eating Out'),(11,'What should you ask the waiter to do after they take your order?','Confirm your Order','Tips for Eating Out'),(12,'Coeliac Disease is...','An Autoimmune Disease','Coeliac as a Disease'),(13,'An autoimmune disease is when the body\'s immune system..','Attacks Itself','Coeliac as a Disease'),(14,'Which is another autoimmune disease?','Type 1 Diabetes','Coeliac as a Disease');
UNLOCK TABLES;


/*Niamh Start - Symptom Tracker*/
CREATE TABLE IF NOT EXISTS 'users' (
	`user_id` INT(6),
	`user_name` VARCHAR(10),
	`user_email` VARCHAR(50) UNIQUE,
	`user_password` VARCHAR(50),
	 PRIMARY KEY (`user_id`)
)

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'John Doe','example@example.com','password');
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS 'symptoms' (
	`sym_id` INT(6) UNIQUE,
	`sym_name` VARCHAR(20) UNIQUE,
	`sym_desc` VARCHAR(100),
	PRIMARY KEY (`sym_id`)
)

LOCK TABLES `symptoms` WRITE;
INSERT INTO `symptoms` VALUES (1,'Acne','acne description'),(2,'Vomit','vomit description'),(3,'Bloat','bloat description'),(4,'Indigestion','indigestion description');
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS 'emotions' (
	`emo_id` INT(6),
	`emo_name` VARCHAR(20) UNIQUE,
	PRIMARY KEY (`emo_id`)
)

LOCK TABLES `emotions` WRITE;
INSERT INTO `emotions` VALUES (1,'unhappy'),(2,'okay'),(3,'happy');
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS 'entries' (
	`user_id` INT(6),
	`entry_id` INT(6) AUTO_INCREMENT,
	`entry_date` DATE,
	`entry_tod` VARCHAR(10),
	`symptom_entry_id` INT(6),
	`entry_emo_id` INT(6),
	`notes` VARCHAR (25),
	PRIMARY KEY (`entry_id`)
)

CREATE TABLE IF NOT EXISTS 'symptomentry' (
	`sym_entry_id` INT(6),
	`symptom_entry_sev` INT (6),
	`sym_id` INT(6)
)
/*Niamh End - Symptom Tracker*/





