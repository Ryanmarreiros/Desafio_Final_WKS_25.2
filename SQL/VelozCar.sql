CREATE SCHEMA VelozCar;
USE VelozCar;

CREATE TABLE Cliente (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Idade INT NOT NULL,
    Data_cadastro DATE NOT NULL
);

CREATE TABLE Veiculos (
    Placa VARCHAR(7) PRIMARY KEY,
    Status_veiculo VARCHAR(50) NOT NULL,
    Valor_da_diaria DECIMAL(10, 2) NOT NULL,
    Ano INT NOT NULL,
    Marca VARCHAR(100) NOT NULL,
    Modelo VARCHAR(100) NOT NULL,
    Cor VARCHAR(50) NOT NULL
);

CREATE TABLE Pagamento (
    Codigo_pagamento INT PRIMARY KEY,
    Data_pagamento DATE NOT NULL,
    Valor_pago DECIMAL(10, 2) NOT NULL,
    Forma_de_pagamento VARCHAR(50) NOT NULL,
    Tipo_aluguel VARCHAR(50) NOT NULL,
    Seguro_incluso BOOLEAN NOT NULL
);

CREATE TABLE Manutencao (
    Codigo_manutencao INT PRIMARY KEY,
    Data_manutencao DATE NOT NULL,
    Descricao TEXT NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Tipo_manutencao VARCHAR(100) NOT NULL,
    Responsavel VARCHAR(255) NOT NULL
);

CREATE TABLE Aluguel (
    Codigo_aluguel INT PRIMARY KEY,
    Data_inicio DATE NOT NULL,
    Data_fim DATE NOT NULL,
    Quilometragem_inicial DECIMAL(10, 2) NOT NULL,
    Quilometragem_final DECIMAL(10, 2) NOT NULL,
    Status_aluguel VARCHAR(50) NOT NULL,
    Valor_total DECIMAL(10, 2) NOT NULL,
    fk_Cliente_CPF VARCHAR(11) NOT NULL,
    FOREIGN KEY (fk_Cliente_CPF) REFERENCES Cliente(CPF)
);

CREATE TABLE Realiza (
    fk_Aluguel_Codigo_aluguel INT,
    fk_Pagamento_Codigo_pagamento INT,
    PRIMARY KEY (fk_Aluguel_Codigo_aluguel, fk_Pagamento_Codigo_pagamento),
    FOREIGN KEY (fk_Aluguel_Codigo_aluguel) REFERENCES Aluguel(Codigo_aluguel),
    FOREIGN KEY (fk_Pagamento_Codigo_pagamento) REFERENCES Pagamento(Codigo_pagamento)
);

CREATE TABLE Contem (
    fk_Manutencao_Codigo_manutencao INT,
    fk_Veiculos_Placa VARCHAR(7),
    PRIMARY KEY (fk_Manutencao_Codigo_manutencao, fk_Veiculos_Placa),
    FOREIGN KEY (fk_Manutencao_Codigo_manutencao) REFERENCES Manutencao(Codigo_manutencao),
    FOREIGN KEY (fk_Veiculos_Placa) REFERENCES Veiculos(Placa)
);

CREATE TABLE Compra (
    fk_Pagamento_Codigo_pagamento INT,
    fk_Veiculos_Placa VARCHAR(7),
    PRIMARY KEY (fk_Pagamento_Codigo_pagamento, fk_Veiculos_Placa),
    FOREIGN KEY (fk_Pagamento_Codigo_pagamento) REFERENCES Pagamento(Codigo_pagamento),
    FOREIGN KEY (fk_Veiculos_Placa) REFERENCES Veiculos(Placa)
);

INSERT INTO Cliente (CPF, Nome, Email, Telefone, Endereco, Idade, Data_cadastro) VALUES
('12345678900', 'Bruno Almeida', 'bruno@email.com', '98888-1010', 'Av. Central, 101', 30, '2025-01-12'),
('23456789011', 'Camila Rocha', 'camila@email.com', '98888-2020', 'Rua Flor, 202', 41, '2025-01-18'),
('34567890122', 'Diego Martins', 'diego@email.com', '98888-3030', 'Av. Brasil, 303', 27, '2025-02-03'),
('45678901233', 'Patrícia Gomes', 'patricia@email.com', '98888-4040', 'Rua Sol, 404', 52, '2025-02-25'),
('56789012344', 'Felipe Araújo', 'felipe@email.com', '98888-5050', 'Rua Mar, 505', 24, '2025-03-08'),
('67890123455', 'Renata Melo', 'renata@email.com', '98888-6060', 'Av. Norte, 606', 32, '2025-03-14'),
('78901234566', 'André Barbosa', 'andre@email.com', '98888-7070', 'Rua Sul, 707', 44, '2025-04-02'),
('89012345677', 'Sofia Fernandes', 'sofia@email.com', '98888-8080', 'Rua Leste, 808', 28, '2025-04-20'),
('90123456788', 'Gabriel Castro', 'gabriel@email.com', '98888-9090', 'Av. Oeste, 909', 39, '2025-05-08');

INSERT INTO Aluguel (Codigo_aluguel, Data_inicio, Data_fim, Quilometragem_inicial, Quilometragem_final, Status_aluguel, Valor_total, fk_Cliente_CPF) VALUES
(10, '2025-09-02', '2025-09-06', 500, 1100, 'Finalizado', 600.00, '12345678900'),
(11, '2025-09-04', '2025-09-09', 1500, 2300, 'Em andamento', 750.00, '23456789011'),
(12, '2025-09-05', '2025-09-11', 400, 950, 'Finalizado', 550.00, '34567890122'),
(13, '2025-09-06', '2025-09-08', 600, 780, 'Finalizado', 280.00, '45678901233'),
(14, '2025-09-07', '2025-09-13', 1000, 1700, 'Em andamento', 650.00, '56789012344'),
(15, '2025-09-08', '2025-09-15', 900, 1500, 'Em andamento', 700.00, '67890123455'),
(16, '2025-09-09', '2025-09-14', 350, 800, 'Finalizado', 320.00, '78901234566'),
(17, '2025-09-10', '2025-09-17', 200, 600, 'Em andamento', 380.00, '89012345677'),
(18, '2025-09-11', '2025-09-18', 100, 700, 'Em andamento', 420.00, '90123456788');

INSERT INTO Pagamento (Codigo_pagamento, Data_pagamento, Valor_pago, Forma_de_pagamento, Tipo_aluguel, Seguro_incluso) VALUES
(10, '2025-09-06', 600.00, 'Pix', 'Diária', TRUE),
(11, '2025-09-11', 750.00, 'Cartão', 'Mensal', TRUE),
(12, '2025-09-07', 550.00, 'Boleto', 'Diária', FALSE),
(13, '2025-09-08', 280.00, 'Cartão', 'Diária', TRUE),
(14, '2025-09-13', 650.00, 'Pix', 'Mensal', FALSE),
(15, '2025-09-15', 700.00, 'Boleto', 'Diária', TRUE),
(16, '2025-09-14', 320.00, 'Cartão', 'Diária', TRUE),
(17, '2025-09-17', 380.00, 'Pix', 'Diária', FALSE),
(18, '2025-09-18', 420.00, 'Cartão', 'Mensal', TRUE);

INSERT INTO Manutencao (Codigo_manutencao, Data_manutencao, Descricao, Valor, Tipo_manutencao, Responsavel) VALUES
(9, '2025-09-02', 'Alinhamento e balanceamento', 180.00, 'Preventiva', 'Oficina X'),
(10, '2025-09-03', 'Troca de bateria', 600.00, 'Corretiva', 'Oficina Y'),
(11, '2025-09-06', 'Revisão elétrica', 1100.00, 'Preventiva', 'Oficina Z'),
(12, '2025-09-08', 'Troca de amortecedores', 800.00, 'Corretiva', 'Oficina X'),
(13, '2025-09-10', 'Troca de óleo sintético', 300.00, 'Preventiva', 'Oficina Y'),
(14, '2025-09-12', 'Troca de correia dentada', 1400.00, 'Corretiva', 'Oficina Z'),
(15, '2025-09-13', 'Revisão da suspensão', 450.00, 'Preventiva', 'Oficina X'),
(16, '2025-09-14', 'Conserto do câmbio', 900.00, 'Corretiva', 'Oficina Y');

INSERT INTO Veiculos (Placa, Status_veiculo, Valor_da_diaria, Ano, Marca, Modelo, Cor) VALUES
('AAA-111', 'Disponível', 160.00, 2022, 'Chevrolet', 'Tracker', 'Branco'),
('BBB-222', 'Alugado', 210.00, 2021, 'Hyundai', 'HB20', 'Prata'),
('CCC-333', 'Manutenção', 190.00, 2020, 'Ford', 'Fiesta', 'Vermelho'),
('DDD-444', 'Disponível', 260.00, 2023, 'Toyota', 'Yaris', 'Cinza'),
('EEE-555', 'Alugado', 130.00, 2019, 'Renault', 'Logan', 'Azul'),
('FFF-666', 'Disponível', 310.00, 2024, 'Honda', 'HR-V', 'Preto'),
('GGG-777', 'Alugado', 230.00, 2022, 'Volkswagen', 'Polo', 'Branco'),
('HHH-888', 'Disponível', 150.00, 2021, 'Nissan', 'March', 'Amarelo'),
('III-999', 'Manutenção', 290.00, 2023, 'Kia', 'Sportage', 'Verde');



SELECT AVG(Valor_total) AS ValorMedioAluguel
FROM Aluguel;

SELECT Tipo_manutencao, SUM(Valor) AS CustoTotal
FROM Manutencao
GROUP BY Tipo_manutencao;

SELECT Status_veiculo, COUNT(*) AS TotalVeiculos
FROM Veiculos
GROUP BY Status_veiculo;

SELECT
    V.Placa,
    V.Marca,
    V.Modelo,
    M.Tipo_manutencao,
    M.Data_manutencao
FROM Veiculos AS V
LEFT JOIN Contem AS C
ON V.Placa = C.fk_Veiculos_Placa
LEFT JOIN Manutencao AS M
ON C.fk_Manutencao_Codigo_manutencao = M.Codigo_manutencao;

SELECT
    C.Nome AS NomeCliente,
    A.Codigo_aluguel,
    A.Data_inicio,
    A.Valor_total
FROM Cliente AS C
INNER JOIN Aluguel AS A
ON C.CPF = A.fk_Cliente_CPF;

UPDATE Cliente
SET Email = 'thiago.novo@email.com', Idade = 41
WHERE CPF = '34567890122';

UPDATE Cliente
SET Email = 'camila.novo@email.com', Idade = 42
WHERE CPF = '23456789011';

SELECT * FROM Aluguel;
SELECT * FROM Pagamento;
SELECT * FROM Cliente;
select * from Manutencao;
SELECT * FROM Veiculos;
