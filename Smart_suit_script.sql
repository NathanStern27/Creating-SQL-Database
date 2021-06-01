USE Master
go

IF EXISTS(select * from sys.databases where name='Smart_Suit_Pty_Ltd')
DROP DATABASE Smart_Suit_Pty_Ltd
GO

CREATE database [Smart_Suit_Pty_Ltd]
go


------- Smart_Suit_Pty_Ltd -------

USE Smart_Suit_Pty_Ltd
go

------ Branches table -------
Create Table Branches(
Branch_ID		int identity (1,1) NOT NULL constraint Br_pk Primary key,
Branch_name		Varchar(25) NOT NULL,
)

------ Supplier table -------
Create Table Supplier(
Supplier_ID		int identity (1,1) NOT NULL constraint Sup_pk Primary key,
Company_Name	Varchar(100) NOT NULL,
Contact_Name	Varchar(100),
Contact_Number	Varchar(20) unique (Contact_Number) check (Contact_Number like '00%'),
Sup_email		Varchar(50) unique (Sup_email) check (Sup_email like '%@%.%'),
Sup_Address		Varchar(100),
City			Varchar(100),
Country			Varchar(100)
)

------ Employee table -------
Create Table Employees(
Emp_ID			int identity (1,1) NOT NULL constraint emp_pk Primary key,
First_Name		Varchar(25) NOT NULL,
Surname			Varchar(25) NOT NULL,
Gender			Varchar(1) check (Gender in ('M', 'F')),
Emp_email		Varchar(25) unique (Emp_email) check (Emp_email like '%@smartsuit.com'),
Phone_Number	Varchar(10) unique (Phone_Number),
Home_Address	Varchar(50) unique (Home_Address),
City			Varchar(20),
Birthdate		datetime,
Hiredate		datetime,
Branch_ID		int NOT NULL constraint brA_fk FOREIGN KEY (Branch_ID) references Branches (Branch_ID) 
)

------ Customer table -------
Create Table Customer(
Customer_ID		int identity (1,1) NOT NULL constraint Cust_pk Primary key,
Customer_Number	Varchar(10) NOT NULL,
Company_Name	Varchar(100),
Contact_Name	Varchar(20),
Contact_Number	Varchar(100), 
Cust_email		Varchar(100),
Cust_Address	Varchar(100),
City			Varchar(20),
Type_of_Cust	Varchar(100)
)

------ Orders table -------
Create Table Orders(
Order_ID		int identity (1,1) NOT NULL constraint Ord_pk Primary key,
Order_Number	Varchar (20),
Customer_ID		int NOT NULL constraint cust_fk FOREIGN KEY (Customer_ID) references Customer (Customer_ID),
Emp_ID			int NOT NULL constraint emp_fk FOREIGN KEY (Emp_ID) references Employees (Emp_ID), 
Branch_ID		int NOT NULL constraint brC_fk FOREIGN KEY (Branch_ID) references Branches (Branch_ID),
Order_date		Varchar (50) NOT NULL,
Return_date		Varchar (50)
)

------ Products table -------
Create Table Products(
Product_ID		int identity (1,1) NOT NULL constraint Prod_pk Primary key,
Product_Name	Varchar(100) NOT NULL,
Supplier_ID		int NOT NULL constraint Sup_fk FOREIGN KEY (Supplier_ID) references Supplier (Supplier_ID),
Product_Design	Varchar(100), 
Unit_price		int,
Units_in_Stock	int,
Units_ordered	int,
Size			Varchar(5) check (Size in ('S','M','L','XL','XXL')),
Colour			Varchar(100),
discontinued	Varchar(1) check (discontinued in ('Y', 'N')),
Branch_ID		int NOT NULL constraint brB_fk FOREIGN KEY (Branch_ID) references Branches (Branch_ID) 
)

------ Order details table -------
Create Table Order_Details(
Order_ID		int constraint orderID_fk FOREIGN KEY (Order_ID) references Orders (Order_ID) on delete cascade,
Product_ID		int NOT NULL constraint prod_fk FOREIGN KEY (Product_ID) references Products (Product_ID),
Unit_price		float,
Quantity		int,
Discount		float
)

------ Insert Branches Table ------
insert into Branches (Branch_name)
values	('Tel Aviv'),
		('Jerusalem'),
		('Haifa'),
		('Beer Sheva'),
		('Ashkelon'),
		('Ashdod')

------ Insert Employees Table ------
insert into Employees
values	('Yossi', 'Dayan', 'M', 'yossid@smartsuit.com', '0536095987', '6 Bar ilan street', 'Netanya', '1970-05-01', '2007-04-01', 1),
		('Efrat', 'Ziegler', 'F', 'efratz@smartsuit.com', '0514841169', '33 Kadesh Boulevard', 'Beit Shemesh', '1990-12-20', '2010-04-01', 2),
		('Yonatan', 'Razel', 'M', 'yonatanr@smartsuit.com', '0505984781', '26 Bar Kokva street', 'Beer Sheva', '1994-05-15', '2013-06-30', 4),
		('Yaakov', 'Shewkey', 'M', 'yaakovs@smartsuit.com', '0558783654', '84 Jerusalem street', 'Haifa', '1970-05-01', '2014-07-01', 3),
		('Ofer', 'Dinur', 'M', 'oferd@smartsuit.com', '0525858745', '4 Hapninim street', 'Tel Aviv', '1984-07-07', '2016-11-01', 1),
		('Rikva', 'Forte', 'F', 'rikvaf@smartsuit.com', '0514784793', '1 Haavoda street', 'Ashdod', '1992-05-16', '2013-02-01', 6),
		('Rinat', 'Wagner', 'F', 'rinatw@smartsuit.com', '0526478913', '89 Eli Cohen street', 'Ashdod', '1970-11-13', '2012-03-01', 6),
		('Ori', 'Elbaz', 'F', 'orie@smartsuit.com', '0501287694', '122 Hapalmah street', 'Ashkelon', '1979-08-22', '2018-04-01', 5),
		('Shmuel', 'Nunu', 'M', 'shmueln@smartsuit.com', '0547812478', '210 Herzl street', 'Jerusalem', '1974-11-30', '2014-06-01', 2),
		('Melanie', 'Gamshi', 'F', 'melanieg@smartsuit.com', '0514693824', '44 Nisan Ave', 'Tel Aviv', '1972-02-01', '2013-05-01', 1),
		('Alon', 'Dayan', 'M', 'alond@smartsuit.com', '0513968457', '65 Haaliyah street', 'Ashkelon', '1985-03-10', '2014-06-30', 5),
		('Oren', 'Hodes', 'M', 'orenh@smartsuit.com', '0558963239', '20 Arye Tager street', 'Jerusalem', '1977-05-31', '2009-07-01', 2),
		('Naama', 'Shaked', 'F', 'naamas@smartsuit.com', '0536989104', '19 Milka street', 'Haifa', '1996-06-20', '2010-12-01', 3),
		('Hadasa', 'Bennet', 'F', 'hadasab@smartsuit.com', '0500142834', '37 Elat street', 'Tel Aviv', '1988-04-30', '2009-11-15', 1),
		('Danielle', 'Rothschild', 'M', 'danieller@smartsuit.com', '0547396582', '16 Bareket street', 'Beer Sheva', '1991-06-11', '2010-04-01', 4),
		('Ronen', 'Elbar', 'M', 'ronene@smartsuit.com', '0536478514', '4 Hogla street', 'Tel Aviv', '1977-07-07', '2011-04-01', 1),
		('Adnan', 'Levy', 'M', 'adnanl@smartsuit.com', '0536932001', '9 Sorek street', 'Jerusalem', '1988-08-08', '2012-03-01', 2),
		('Inon', 'Cohen', 'M', 'inonc@smartsuit.com', '0501478514', '73 Karmeli street', 'Beer Sheva', '1973-04-09', '2018-04-30', 4),
		('Naor', 'Mor Nosef', 'M', 'naorn@smartsuit.com', '0521396947', '32 Ort street', 'Ashkelon', '1975-08-18', '2017-09-01', 5),
		('Ran', 'Bar', 'M', 'ranb@smartsuit.com', '0512100368', '31 Hillel street', 'Ashdod', '1986-12-16', '2011-08-01', 6),
		('Eyal', 'Glick', 'M', 'eyalg@smartsuit.com', '0524768885', '76 Sarig street', 'Jerusalem', '1989-06-20', '2019-05-01', 2),
		('Benjamin', 'Silverman', 'M', 'benjamins@smartsuit.com', '0547871110', '89 Nof yam street', 'Beer Sheva', '1987-03-22', '2015-04-01', 4),
		('Avi', 'Goshen', 'M', 'avig@smartsuit.com', '0536984151', '2 Hagalil street', 'Tel Aviv', '1997-12-04', '2012-02-01', 1),
		('Sharon', 'Krief', 'F', 'sharonk@smartsuit.com', '0512547852', '54 Zvi Segal street', 'Beer Sheva', '1994-01-15', '2013-10-01', 4),
		('Ari', 'Friedman', 'M', 'arif@smartsuit.com', '0536989471', '77 Yitshak Rabin street', 'Haifa', '1998-09-20', '2018-08-01', 3),
		('Natalie', 'Fligg', 'F', 'natalief@smartsuit.com', '0514874582', '40 Menahem Begin street', 'Tel Aviv', '1988-07-15', '2016-10-01', 1)


------ Insert Supplier Table ------
insert into	Supplier
values	('Dutch east suppliers', 'Gerlof', '003164912648','gerlof@dutcheastsuppliers.co.nl', '15 van gogh avenue', 'Amsterdam', 'Netherlands'),
		('Shanghai Yiyu Industrial Co.', 'Maggie', '008691458236584','maggies@shanghaiint.com', '753 Xiu lang street', 'Shanghai', 'China'),
		('Yanghi Thailands suits', 'Wanda', '006648133548', 'wanda@yanghisuits.co.th', '55 Yukumando road', 'Bangkok', 'Thailand'),
		('Nepal global suits', 'Bhavesh', '0099715433694', 'bhavesh@nepalglobalsuits.com', '4 Zinghou street', 'Kathmandu', 'Nepal'),
		('Worldwide suits 4u Ltd.', 'Linghu', '006641169341', 'Linghu@worldwidesuits4u.co.th', '103 Eeranding road', 'Bangkok','Thailand'),
		('Mens suits Industrial Co.', 'Sophie', '008625493658741','sophie@menssuits.com', '753 zinghou Boulevard', 'Shanghai', 'China'),
		('Wholesuits International.', 'Greta', '008641141548154','greta@wholesuitsint.com', '401 Xiu Avenue', 'Shanghai', 'China'),
		('Firsclothing International.', 'Kathleen', '008613777111305','Kathleen.xu@163.com', 'Shanshan rd 228', 'Ningbo', 'China')

------ Insert Customer Table ------
insert into Customer
values	('1001', '', 'Vika Mandelov' ,' 0536485212', 'vika@cgsolutions.com','','','Private'),
		('1002', 'Supersal', 'Sergi Ichikovitz','0536965874','sergii@supersal.co.il','18 Haavoda street', 'Tel Aviv', 'Business'),
		('1003', 'Victory', 'Kobe Raz','0514785963','kobe@victory.co.il','55 Haaskel street', 'Tel Aviv', 'Business'),
		('1004', 'Elbar', 'David Orenstein','0521478596','davido@elbar.co.il','154 Hisdranut street', 'Haifa', 'Business'),
		('1005', 'Superfarm', 'Benzi Burstein','0536985471','benzib@superfarm.co.il','66 Bar Kochva street', 'Tel Aviv', 'Business'),
		('1006', 'Ministry of Justice', 'Kobe Raz','0503625874','kobe@supersal.co.il','65 Simcha Holtzberg street', 'Jersulam', 'Public'),
		('1007', '', 'Yehezkel Steinberg','0514789635','issyeh@hotmail.com','39 Kadesh street', 'Ashkelon', 'Private'),
		('1008', 'Superbeauty', 'Ahuva Nunu','0554712585','ahuva@superbeauty.co.il','55 Eztel street', 'Tel aviv', 'Business'),
		('1009', 'Rami Levy', 'Yoel Metzer','0500025001','yoelm@ramilevy.co.il','1 Aliyah street', 'Haifa', 'Business'),
		('1010', 'Cellcom', 'Jacques Shwartz','0501411202','jacquess@cellcom.co.il','103 Haofakim street', 'Ashdod', 'Business'),
		('1011', 'Partner', 'Keren-Or Zacharis','0530069854','kerenz@partner.co.il','88 Vegas street', 'Tel Aviv', 'Business'),
		('1012', 'Hot Mobile', 'Monique Lawrence','0536920015','moniquel@hotmobile.co.il','74 Otzma street', 'Beer Sheva', 'Business'),
		('1013', 'Rolandi', 'Jonathan Cassini','0536985471','jonathanc@rolandi.co.il','31 Balfour Boulevard', 'Tel Aviv', 'Business'),
		('1014', 'Hisrad Hapanim Haifa', 'Dima Gurvaiech','05124897521','dimag@supersal.co.il','10 Hazani street', 'Haifa', 'Public'),
		('1015', 'Cg Solutions', 'Yaakov Weiss','0532648521','yweiss@cgsolutions.co.il','41 Wynberg street', 'Petah Tikva', 'Business'),
		('1016', 'Werkmans Attorneys', 'Ephraim Ifgeni','0512487931','ephraimi@werksmans.co.il','217 Golani street', 'Tel Aviv', 'Business'),
		('1017', 'Egged Transport', 'Pinni Zaude','0514863254','pinniz@egged.co.il','31 Natan Sheransky Avenue', 'Rehovot', 'Business'),
		('1018', 'Golan Telecoms', 'Michael Katz','0541700369','michaelk@golantelecoms.co.il','55 Yitzak Rabin street', 'Haifa', 'Business'),
		('1019', 'Bezeq', 'Jeremy Wolff','0541258639','jeremy@bezeq.co.il','66 Yonatan Netanyahu street', 'Jerusalem', 'Business'),
		('1020', 'Friedland Attornies & Conveyancers', 'Victor Einstein','05123654010','victor@friedlandatt.co.il','84 Eskol street', 'Tel Aviv', 'Business'),
		('1021', 'Oren Shabat Notaries & Attorneys', 'Oren Shabat','0512693654','oren@orenshabat.co.il','72 Nof Yam street', 'Kiryat Bialik', 'Business'),
		('1022', 'Renprop', 'John Holding','0513696354','john@renprop.co.il','15 Bryan Place street', 'Jerusalem', 'Business'),
		('1023', 'Compeg Services', 'Clive Ginsburg','0522123695','cliveg@compegservices.co.il','61 Albert Einstein street', 'Yaffo', 'Business'),
		('1024', 'Hazit', 'Itamar Cohen','0503212147','itamarc@hazit.co.il','3 Moshe Dayan street', 'Bnei Brak', 'Business'),
		('1025', 'Daayan solutions', 'Sapira Weizmann','0536965841','sapriaw@daayansol.co.il','55 Menashe Boulevard', 'Jerusalem', 'Business'),
		('1026', '', 'Oren Bennet','0536985641','orenbenni@bezeq.co.il','3 Bar Nosef Avenue', 'Ashkelon', 'Private'),
		('1027', '', 'Rami Cohen','0545878930','ramithecohen@gmail.com','55 Kiryati street', 'Jerusalem', 'Private'),
		('1028', '', 'Benjamin Netanyahu','0536987451','kobe@supersal.co.il','18 Sheva street', 'Beer Sheva', 'Business'),
		('1029', 'Oren Meshi Bakeries', 'Oren Meshi','0536914003','orenm@orenmeshi.co.il','59 Atniel street', 'Ashdod', 'Business'),
		('1030', 'Osher v-osher', 'Yona Buzaglo','0514936501','yonab@osher.co.il','31 Oded street', 'Ashdod', 'Business'),
		('1031', 'Macdonalds', 'Peretz Bernstein','0536300014','peretz@macdonalds.co.il','47 Havradim street', 'Haifa', 'Business'),
		('1032', 'Burger Ranch', 'Adam Yekutiel','0514203693','adamy@burgerranch.co.il','55 Weizmann street', 'Tel Aviv', 'Business'),
		('1033', 'Israel Railways', 'Shlomo Cohen','0536932015','shlomoc@israelrailways.co.il','105 Ofira Navon street', 'Ramat Gan', 'Public'),
		('1034', 'Davidy Centres', 'Elad Kinsler','0512484301','elad@davidycentres.co.il','39 Hatsanhanim street', 'Rishon Letzion', 'Business'),
		('1035', 'Afridar', 'Einat Shulman','0536260154','einats@afridar.co.il','32 Kola Kavod Avenue', 'Rehovot', 'Business'),
		('1036', 'Nano Technologies', 'Moshe Ben Zvi','0532323691','mosheb@nanotech.co.il',' 2 Sappir street', 'Ashkelon', 'Business'),
		('1037', '', 'Eyal Vardy','0531693250','eyalv@gmail.com','133 Barnea Boulevard', 'Ashdod', 'Private'),
		('1038', '', 'Shani Friedman','0545458585','shanif1984@gmail.com','177 Bar Ilan street', 'Haifa', 'Private'),
		('1039', '', 'Ilan Danziger','0521717360','igunner01@gmail.com','3 Nofesh street', 'Karmiel', 'Private'),
		('1040', '', 'Joshua Litvin','0536952318','Joshualit@hotmail.com','55 Ramat Gan street', 'Tel Aviv', 'Private'),
		('1041', '', 'Shane Zweed','0531548412','shanezweed@yahoo.co.uk','169 Yerushaliyim street', 'Ashkelon', 'Private'),
		('1042', '', 'Doron Haskel','0513693250','doronhasi@gmail.com','19 Hapanin street', 'Jerusalem', 'Private'),
		('1043', 'Yango', 'Tyron Waters','0503632154','tyron@yango.co.il','183 Victory Boulevard', 'Tel Aviv', 'Business'),
		('1044', 'Gett', 'Herzl Geffen','0536458210','Herzlg@gett.co.il','18 Haavoda street', 'Ashkelon', 'Business'),
		('1045', 'ACE DEPO', 'Ari Treger','0532697410','arit@ace-depo.co.il','145 Roslin street', 'Beer Sheva', 'Business')

------ Insert Products Table ------		
insert into	Products
values	('Burberry', 2, 'slim fit', '650', '25', '', 'L', 'light grey', 'N', 2),
		('Gucci', 3, 'Winter suit','800', '0','30','M','Navy blue', 'N', 1),
		('Brioni', 8, 'Striped suit','710', '5','20','S','Navy blue', 'N', 3),
		('Saint Laurent', 1, 'Black suit','3','30','','L','Black', 'N', 4),
		('Givenchy', 3, 'Italian suit','910', '40','','XL','White', 'Y', 3),
		('Prada', 2, 'Double Brested','650', '17','10','M','Navy blue', 'N', 2),
		('Valentino', 6, 'Burgundy','700', '0','40','M','Maroon', 'N', 2),
		('Dsquared2', 4, 'Plaid','800', '5','30','L','Black', 'N', 2),
		('Kingsman', 3, '3 Piece suit','850', '10','40','L','light grey', 'N', 4),
		('Suitsupply', 5, 'Striped suit','840', '3','25','L','Navy blue', 'N', 1),
		('Paul Smith', 8, 'Italian suit','810', '30','','L','Maroon', 'Y', 1),
		('Tom Ford', 8, 'Double Brested','800', '28','','XL','Navy blue', 'Y', 2),
		('Hugo Boss', 7, 'Burgundy','780', '12','','S','Navy blue', 'N', 1),
		('Acne Studios', 5, 'Black suit','660', '6','30','M','Black', 'N', 3),
		('Ralph Lauren Purple Label', 1, 'Winter suit','910', '32','','M','Black', 'Y', 3),
		('Reiss', 2, 'Winter suit','700', '23','','S','light grey', 'Y', 4),
		('Thom Browne', 6, 'Plaid','600', '0','40','L','Navy blue', 'N', 2),
		('Dunhill', 5, 'Burgundy','750', '8','25','L','Maroon', 'N', 2),
		('Canali', 4, 'Double Brested','800', '0','20','XL','Navy blue', 'N', 4),
		('Hackett', 4, '3 Piece suit','700', '15','0','XL','light grey', 'Y', 3),
		('Kiton', 2, 'Winter suit','850', '25','0','M','Navy blue', 'Y', 1),
		('Rhodes and Beckett', 7, 'Winter suit','770', '21','','M','Navy blue', 'Y', 1),
		('Tom Ford', 6, 'Italian suit','780', '3','40','L','Dark blue', 'Y', 1),
		('Prada', 5, 'Winter suit','940', '9','25','M','light grey', 'N', 2),
		('Dolce & Gabbana', 5, 'Striped suit','990', '16','','S','Navy blue', 'Y', 4),
		('Dunhill', 2, 'Burgundy','780', '12','','S','Dark blue', 'Y', 3),
		('Suitsupply', 1, 'Winter suit','990', '41','','L','Dark Brown', 'Y', 2),
		('Dolce & Gabbana', 1, 'Striped suit','910', '2','30','M','Navy blue', 'N', 1),
		('Henry Bucks', 4, 'Winter suit','860', '15','','M','Dark blue', 'N', 4),
		('Richard James', 4, 'Black suit','890', '3','25','M','Black', 'N', 3),
		('Dolce & Gabbana', 2, 'Winter suit','740', '0','40','XL','Navy blue', 'N', 1),
		('Stefano Ricci', 5, 'Winter suit','690', '35','','M','light grey', 'Y', 3),
		('Dolce & Gabbana', 6, 'Italian suit','710', '0','30','L','Navy blue', 'N', 2),
		('Gucci', 8, 'Winter suit','720', '4','30','L','Maroon', 'Y', 1),
		('Dolce & Gabbana', 4, 'Double Brested','740', '15','','L','light grey', 'N', 3),
		('Gieves & Hawkes', 3, 'Double Brested','760', '12','','L','Navy blue', 'N', 2),
		('Burberry', 1, 'Winter suit','900', '6','25','L','Maroon', 'N', 3),
		('Dolce & Gabbana', 2, 'slim fit','880', '40','','M','White', 'Y', 4),
		('Joe Black', 4, 'slim fit','870', '25','','M','Black', 'Y', 4),
		('Ralph Lauren Purple Label', 7, 'slim suit','690', '15','','XL','Dark Brown', 'Y', 4),
		('Dolce & Gabbana', 7, 'Burgundy','990', '7','20','S','Navy blue', 'N', 1),
		('P. Johnson', 8, 'Striped suit','840', '3','30','S','Maroon', 'N', 1)

------ Insert Orders Table ------	
insert into	Orders
values	('10001',32, 20, 5, '2020-02-01', '2020-03-01'),
		('10002',15, 19, 4, '2020-02-16', '2020-03-16'),
		('10003',20, 15, 3, '2020-03-12', '2020-04-12'),
		('10004',41, 16, 5, '2020-02-05', '2020-03-05'),
		('10005',2, 2, 1, '2020-01-15', '2020-02-15'),
		('10006',3, 3, 1, '2020-04-01', '2020-05-01'),
		('10007',4, 18, 6, '2020-01-12', '2020-02-12'),
		('10008',17,  9, 6, '2020-03-22', '2020-04-22'),
		('10009',22, 7, 5, '2020-04-04', '2020-05-04'),
		('10010',15, 17, 6, '2020-03-06', '2020-04-06'),
		('10011',13, 12, 4, '2020-02-29', '2020-03-30'),
		('10012',6, 1, 1, '2020-02-22', '2020-03-22'),
		('10013',35, 5, 2, '2020-03-16', '2020-04-16'),
		('10014',14, 6, 2, '2020-04-02', '2020-05-02'),
		('10015',29, 9, 2, '2020-04-06', '2020-05-06'),
		('10016',28, 18, 3, '2020-04-04', '2020-05-04'),
		('10017',43, 16, 4, '2020-02-12', '2020-03-12'),
		('10018',41, 15, 1, '2020-03-24', '2020-04-24'),
		('10019',25, 13, 6, '2020-03-29', '2020-04-30'),
		('10020',27, 17, 5, '2020-03-17', '2020-04-17'),
		('10021',9, 15, 5, '2020-02-19', '2020-03-19'),
		('10022',18, 3, 4, '2020-01-30', '2020-02-29'),
		('10023',11, 4, 5, '2020-01-31', '2020-02-29'),
		('10024',10, 17, 5, '2020-02-24', '2020-03-24'),
		('10025',33, 17, 4, '2020-03-26', '2020-04-26'),
		('10026',39, 16, 3, '2020-02-02', '2020-03-30'),
		('10027',2, 8, 1, '2020-04-07', '2020-05-07'),
		('10028',6, 9, 1, '2020-03-12', '2020-04-12'),
		('10029',44, 7, 4, '2020-03-13', '2020-04-13'),
		('10030',38, 1, 4, '2020-03-17', '2020-04-17'),
		('10031',37, 3, 6, '2020-02-24', '2020-03-24'),
		('10032',31, 19, 6, '2020-02-25', '2020-03-25'),
		('10033',20, 17, 5, '2020-01-20', '2020-02-20'),
		('10034',19, 7, 4, '2020-03-15', '2020-04-15'),
		('10035',36, 11, 1, '2020-03-19', '2020-03-19'),
		('10036',35, 13, 2, '2020-02-18', '2020-03-18'),
		('10037',8, 18, 1, '2020-03-20', '2020-04-20'),
		('10038',13, 20, 3, '2020-03-19', '2020-04-19'),
		('10039',33, 19, 5, '2020-03-12', '2020-04-12'),
		('10040',11, 13, 4, '2020-04-02', '2020-04-30'),
		('10041',15, 14, 5, '2020-04-03', '2020-04-30'),
		('10042',16, 16, 6, '2020-02-11', '2020-03-11'),
		('10043',1, 17, 3, '2020-01-27', '2020-02-27'),
		('10044',3, 4, 5, '2020-02-16', '2020-03-16'),
		('10045',14, 6, 2, '2020-03-19', '2020-04-19'),
		('10046',22, 9, 1, '2020-03-23', '2020-04-23'),
		('10047',34, 8, 6, '2020-03-31', '2020-04-30'),
		('10048',36, 13, 2, '2020-04-01', '2020-04-30'),
		('10049',38, 10, 1, '2020-04-06', '2020-05-06'),
		('10050',40, 10, 3, '2020-02-01', '2020-02-30'),
		('10051',39, 17, 6, '2020-01-24', '2020-02-24'),
		('10052',25, 1, 3, '2020-02-15', '2020-03-15'),
		('10053',24, 6, 2, '2020-03-14', '2020-04-14'),
		('10054',28, 16, 4, '2020-03-18', '2020-04-18'),
		('10055',15, 14, 6, '2020-01-21', '2020-02-21'),
		('10056',14, 15, 5, '2020-04-10', '2020-05-10'),
		('10057',6, 19, 4, '2020-04-05', '2020-05-05'),
		('10058',2, 9, 5, '2020-03-27', '2020-04-30'),
		('10059',3, 8, 1, '2020-02-19', '2020-03-20'),
		('10060',41, 7, 5, '2020-03-21', '2020-04-21'),
		('10061',43, 7, 3, '2020-01-10', '2020-02-10'),
		('10062',38, 14, 6, '2020-03-30', '2020-04-30'),
		('10063',24, 11, 4, '2020-03-28', '2020-04-30'),
		('10064',21, 10, 4, '2020-04-10', '2020-05-10'),
		('10065',16, 6, 2, '2020-04-11', '2020-05-11'),
		('10066',44, 8, 1, '2020-04-12', '2020-05-12'),
		('10067',40, 4, 5, '2020-04-11', '2020-05-12'),
		('10068',15, 2, 5, '2020-04-16', '2020-05-16'),
		('10069',12, 6, 5, '2020-04-15', '2020-05-15'),
		('10070',9, 9, 5, '2020-04-16', '2020-05-16'),
		('10071',8, 16, 5, '2020-04-14', '2020-05-14')

------ Insert OrdersDetails Table ------	
insert into	Order_Details
values	(1,3,'1021','5',''),
		(2,7,'1021','1',''),
		(3,20,'1021','15','150'),
		(4,19,'1021','4',''),
		(5,16,'1021','6',''),
		(6,33,'1021','7',''),
		(7,34,'1021','9',''),
		(8,40,'1021','11','110'),
		(9,39,'1021','5',''),
		(10,31,'1021','9',''),
		(11,33,'1021','6',''),
		(12,32,'1021','1',''),
		(13,36,'1021','2',''),
		(14,23,'1021','1',''),
		(15,13,'1021','4',''),
		(16,6,'1021','5',''),
		(17,8,'1021','20','260'),
		(18,3,'1021','15','150'),
		(19,9,'1021','19','180'),
		(20,11,'1021','30','340'),
		(21,19,'1021','10',''),
		(22,35,'1021','4',''),
		(23,41,'1021','7',''),
		(24,40,'1021','4',''),
		(25,2,'1021','8',''),
		(26,4,'1021','9',''),
		(27,5,'1021','4',''),
		(28,7,'1021','4',''),
		(29,9,'1021','2',''),
		(30,12,'1021','2',''),
		(31,11,'1021','5',''),
		(32,10,'1021','8',''),
		(33,30,'1021','5',''),
		(34,39,'1021','1',''),
		(35,9,'1021','5',''),
		(36,8,'1021','2',''),
		(37,16,'1021','6',''),
		(38,15,'1021','1',''),
		(39,14,'1021','2',''),
		(40,19,'1021','5',''),
		(41,26,'1021','4',''),
		(42,25,'1021','5',''),
		(43,39,'1021','8',''),
		(44,24,'1021','7',''),
		(45,15,'1021','5',''),
		(46,3,'1021','5',''),
		(47,3,'1021','5',''),
		(48,1,'1021','5',''),
		(49,6,'1021','5',''),
		(50,7,'1021','5','')


select *
from Customer

select *
from Products

select *
from Supplier

select *
from Orders

select *
from Order_Details

select *
from Employees

select *
from Branches

