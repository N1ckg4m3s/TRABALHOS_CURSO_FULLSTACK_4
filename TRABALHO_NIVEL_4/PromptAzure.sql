//	** CREATE 
CREATE TABLE Drivers ( DriverID INT PRIMARY KEY, Nome VARCHAR(100), CNH VARCHAR(20), Endereço VARCHAR(200), Contato VARCHAR(50) );
CREATE TABLE Clients ( ClientID INT PRIMARY KEY, Nome VARCHAR(100), Empresa VARCHAR(100), Endereço VARCHAR(200), Contato VARCHAR(50) )
CREATE TABLE Orders ( OrderID INT PRIMARY KEY, ClientID INT, DriverID INT, DetalhesPedido TEXT, DataEntrega DATE, Status VARCHAR(50), FOREIGN KEY (ClientID) REFERENCES Clients(ClientID), FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) )

//	** INSERT
// Drivers
INSERT INTO Drivers (DriverID, Nome, CNH, Endereço, Contato) VALUES (1, "Nome Pessoa", "000000000000", "Endereco", "11987654321")
INSERT INTO Drivers (DriverID, Nome, CNH, Endereço, Contato) VALUES (2, "Nome Pessoa 2", "000000000001", "Endereco,24", "11987654300")

// Clients
INSERT INTO Clients ( ClientID, Nome, Empresa, Endereço, Contato) VALUES (1, "Pessoa Empresa", "Empresa", "Endereco", "11987654321")
INSERT INTO Clients ( ClientID, Nome, Empresa, Endereço, Contato) VALUES (2, "Pessoa Empresa 2","Empresa 2", "Endereco", "11987654300")

// Orders
INSERT INTO Orders (OrderID, ClientID, DriverID, DetalhesPedido, DataEntrega, Status) VALUES (1, 1, 2, "Detalhes”, "2024-04-30", "Em Andamento")
INSERT INTO Orders (OrderID, ClientID, DriverID, DetalhesPedido, DataEntrega, Status) VALUES (2, 2, 1, "Detalhes”, "2024-05-05", "Em Andamento")

//	** READ
SELECT * FROM Drivers;
SELECT * FROM Clients;
SELECT * FROM Orders;

//	** UPDATE
UPDATE Orders SET Status = "Entregue" WHERE OrderID = 1

//	** DELETE
DELETE FROM Orders WHERE OrderID = 1
