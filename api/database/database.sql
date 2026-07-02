-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS habboinn_db;
USE habboinn_db;

-- 2. CRIAÇÃO DA TABELA DE CLIENTES
-- Guarda os dados de quem está navegando e reservando
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id_cliente)
);

-- 3. CRIAÇÃO DA TABELA DE QUARTOS
-- Armazena os 6 quartos fixos do hotel temático
CREATE TABLE IF NOT EXISTS quartos (
    id_quarto INT AUTO_INCREMENT,
    nome_quarto VARCHAR(100) NOT NULL,
    tipo ENUM('Padrão', 'Suíte') NOT NULL, -- Atende ao RF02 (Filtro de categoria)
    preco_cambios INT NOT NULL,            -- Moeda temática do projeto
    avaliacao DECIMAL(2,1) NOT NULL,       -- Nota do quarto (ex: 4.5)
    PRIMARY KEY (id_quarto)
);

-- 4. CRIAÇÃO DA TABELA DE RESERVAS (Tabela Intermediária / Relacionamento)
-- Vincula o cliente ao quarto e define o período (RF03 e RF04)
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva INT AUTO_INCREMENT,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    -- status_reserva ajuda no RNF03 (controle de quartos travados/abandonados/confirmados)
    status_reserva VARCHAR(20) NOT NULL DEFAULT 'Confirmada', 
    id_cliente INT NOT NULL,
    id_quarto INT NOT NULL,
    PRIMARY KEY (id_reserva),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto) ON DELETE CASCADE
);

-- ==========================================
-- INSERÇÃO DE DADOS DE TESTE (POPULAR O BANCO)
-- ==========================================

-- Inserindo Clientes Iniciais
INSERT INTO clientes (nome_usuario, email) VALUES 
('HackerPixel', 'pixel@habbo.com'),
('BobBaiano', 'bob@hotel.com'),
('LadyGagaRetro', 'gaga@pixel.com');

-- Inserindo os 6 Quartos Fixos do Projeto (Respeitando a regra do seu escopo)
INSERT INTO quartos (nome_quarto, tipo, preco_cambios, avaliacao) VALUES 
('Quarto Pixel Inicial', 'Padrão', 15, 4.2),
('Suíte Executiva Habbo', 'Suíte', 45, 4.9),
('Lounge Retrô Confort', 'Padrão', 20, 4.5),
('Suíte Presidencial de Blocos', 'Suíte', 70, 5.0),
('Quarto Vintage Econômico', 'Padrão', 12, 3.8),
('Estúdio Cyber Neon', 'Suíte', 35, 4.6);

-- Inserindo Reservas de Exemplo (Para testar a Área de Visualização - RF05)
INSERT INTO reservas (data_checkin, data_checkout, status_reserva, id_cliente, id_quarto) VALUES 
('2026-07-10', '2026-07-15', 'Confirmada', 1, 2),
('2026-07-20', '2026-07-22', 'Pendente', 2, 1); -- 'Pendente' simula o quarto bloqueado temporariamente
