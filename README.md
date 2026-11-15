# PDV-Delphi-ADO-SQLServer
Um projeto PDV simples para portifólio.

Um PDV com sincronização ao banco de dados SQL.
Ele usa apenas duas tabelas "Estoque" e "Vendas".

Estrutura das tabelas:
CREATE TABLE VENDAS (
	codigo          INT IDENTITY(1,1) PRIMARY KEY,
	forma_pagamento VARCHAR(15)   NOT NULL,
	valor_compra    DECIMAL(10,2) NOT NULL,
	cliente         VARCHAR(150)  NOT NULL,
	cupom_fiscal    VARCHAR(MAX)  NOT NULL,
	data_venda      DATETIME      NOT NULL,
	troco           DECIMAL(10,2) NOT NULL
)

CREATE TABLE estoque (
	codigo       INT IDENTITY(1,1) PRIMARY KEY,
	descricao    VARCHAR(100)  NOT NULL,
	valor        DECIMAL(10,2),
	quantidade   DECIMAL(10,3),
	tipo_produto CHAR(2)       NOT NULL
)

Foi usado o método de conexão com componentes ADO devido às limitações do Delphi Community Edition.
