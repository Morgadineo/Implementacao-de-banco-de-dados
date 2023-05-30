-- Drops
DROP DATABASE IF EXISTS voe_bem;
DROP USER IF EXISTS morgado;

-- Criação do usuário e do banco de dados
CREATE USER morgado WITH password '123' SUPERUSER;

CREATE DATABASE voe_bem
	OWNER morgado
	TEMPLATE template0
	ENCODING 'UTF8'
	LC_COLLATE 'pt_BR.UTF-8'
	LC_CTYPE 'pt_BR.UTF-8'
	ALLOW_CONNECTIONS true;

-- Comentário do banco de dados
COMMENT ON DATABASE voe_bem 	IS 'Banco de dados da Transportes Voe Bem';

\c 'dbname=voe_bem user=morgado password=123';

CREATE SCHEMA companhia AUTHORIZATION morgado;

ALTER USER morgado SET SEARCH_PATH TO companhia, "$user", public;
SET search_path TO companhia, '$user', public;




CREATE TABLE base_manutencao (
                id_base_manutencao 			INTEGER NOT NULL,
                nome_base_manutencao 			VARCHAR(50),
                telefone		 		VARCHAR NOT NULL,
                nome_responsavel_base_manutencao 	VARCHAR(50),
                horario_de_funcionamento 		TIMESTAMP NOT NULL,
                capacidade 				INTEGER,
                CONSTRAINT base_manutencao_pk PRIMARY KEY (id_base_manutencao)
);
COMMENT ON TABLE base_manutencao 					IS 'Tabela de bases de manutenção.';
COMMENT ON COLUMN base_manutencao.id_base_manutencao 			IS 'Id da base de manutenção. (PK da tabela base_manutencao)';
COMMENT ON COLUMN base_manutencao.nome_base_manutencao 			IS 'Nome da base de manutenção.';
COMMENT ON COLUMN base_manutencao.telefone 				IS 'Telefone(s) da base de manutenção.';
COMMENT ON COLUMN base_manutencao.nome_responsavel_base_manutencao 	IS 'Nome do responsável da base de manutenção.';
COMMENT ON COLUMN base_manutencao.horario_de_funcionamento 		IS 'Horário de funcionamento da base de manutenção.';
COMMENT ON COLUMN base_manutencao.capacidade 				IS 'Capacidade de armazenamento da base de manutenção.';


CREATE TABLE base_domestica (
                id_base_domestica 			NUMERIC NOT NULL,
                nome_base_domestica 			VARCHAR(50),
                pessoa_responsavel_base_domestica 	VARCHAR,
                capacidade_max 				NUMERIC(3),
                horario_funcionamento_base_domestica 	TIMESTAMP,
                CONSTRAINT base_domestica_pk PRIMARY KEY (id_base_domestica)
);
COMMENT ON TABLE base_domestica 					IS 'Tabela de bases domésticas.';
COMMENT ON COLUMN base_domestica.id_base_domestica 			IS 'Id da base doméstica. (PK da tabela base_domestica).';
COMMENT ON COLUMN base_domestica.nome_base_domestica 			IS 'Nome da base doméstica.';
COMMENT ON COLUMN base_domestica.pessoa_responsavel_base_domestica 	IS 'Pessoa responsável pela base doméstica.';
COMMENT ON COLUMN base_domestica.capacidade_max 			IS 'Capacidade máxima da base doméstica.';
COMMENT ON COLUMN base_domestica.horario_funcionamento_base_domestica 	IS 'Horário de funcionamento da base doméstica.';


CREATE TABLE comissarios (
                id_comissario 		NUMERIC NOT NULL,
                nome 			VARCHAR(50),
                endereco 		VARCHAR(200),
                telefone 		VARCHAR NOT NULL,
                email 			VARCHAR(60) NOT NULL,
                nacionalidade 		VARCHAR(30),
                cargo 			VARCHAR(30),
                salario 		NUMERIC(8,2),
                data_de_admissao 	DATE,
                idiomas 		VARCHAR,
                id_base_domestica 	NUMERIC,
                CONSTRAINT comissarios_pk PRIMARY KEY (id_comissario)
);
COMMENT ON TABLE comissarios 				IS 'Tabela de comissários.';
COMMENT ON COLUMN comissarios.id_comissario 		IS 'Id do comissário. (PK da tabela)';
COMMENT ON COLUMN comissarios.nome 			IS 'Nome do comissário.';
COMMENT ON COLUMN comissarios.endereco 			IS 'Endereço completo do comissário.';
COMMENT ON COLUMN comissarios.telefone 			IS 'Telefone(s) do comissário.';
COMMENT ON COLUMN comissarios.email 			IS 'E-mail do comissário.';
COMMENT ON COLUMN comissarios.nacionalidade 		IS 'Nacionalidade do comissário.';
COMMENT ON COLUMN comissarios.cargo 			IS 'Cargo do comissário.';
COMMENT ON COLUMN comissarios.salario 			IS 'Salário do comissário.';
COMMENT ON COLUMN comissarios.data_de_admissao 		IS 'Data de admissão do comissário.';
COMMENT ON COLUMN comissarios.idiomas 			IS 'Idiomas falados pelo comissário.';
COMMENT ON COLUMN comissarios.id_base_domestica 	IS 'Id da base doméstica do comissário.';


CREATE TABLE avioes (
                id_aviao 		NUMERIC NOT NULL,
                nome_aviao 		VARCHAR(100),
                modelo_aviao 		VARCHAR(25),
                ano_de_fabricao 	INTEGER,
                fabricante 		VARCHAR(30),
                classes 		VARCHAR(20),
                capacidade 		INTEGER,
                base_manuteno 		NUMERIC,
                id_base_manutencao 	INTEGER NOT NULL,
                CONSTRAINT avioes_pk PRIMARY KEY (id_aviao)
);
COMMENT ON TABLE avioes 			IS 'Tabela de avioes';
COMMENT ON COLUMN avioes.id_aviao 		IS 'Id do avião. (PK da tabela aviões).';
COMMENT ON COLUMN avioes.nome_aviao 		IS 'Nome do avião.';
COMMENT ON COLUMN avioes.modelo_aviao 		IS 'Modelo do avião.';
COMMENT ON COLUMN avioes.ano_de_fabricao 	IS 'Ano de fabricação do avião.';
COMMENT ON COLUMN avioes.fabricante 		IS 'Fabricante do avião.';
COMMENT ON COLUMN avioes.classes 		IS 'Classes do avião.';
COMMENT ON COLUMN avioes.capacidade 		IS 'Capacidade do avião.';
COMMENT ON COLUMN avioes.base_manuteno 		IS 'Base de manutenção do avião.';
COMMENT ON COLUMN avioes.id_base_manutencao 	IS 'Id da base de manutenção. (PK da tabela base_manutencao)';


CREATE TABLE voos (
                id_voo 			INTEGER NOT NULL,
                data_prevista 		DATE,
                local_de_saida 		VARCHAR(255),
                hora_de_chegada 	TIMESTAMP,
                numero_escala 		INTEGER,
                local_de_destino 	VARCHAR(255),
                qtde_pilotos 		NUMERIC NOT NULL,
                qtde_comissarios 	VARCHAR NOT NULL,
                aviao 			VARCHAR NOT NULL,
                id_aviao 		NUMERIC NOT NULL,
                CONSTRAINT voos_pk PRIMARY KEY (id_voo)
);
COMMENT ON COLUMN voos.id_voo 			IS 'Id do vôo. (PK da tabela voos)';
COMMENT ON COLUMN voos.data_prevista 		IS 'Data prevista do vôo.';
COMMENT ON COLUMN voos.local_de_saida 		IS 'Local de saída do vôo.';
COMMENT ON COLUMN voos.hora_de_chegada 		IS 'Hora de chegada prevista do vôo.';
COMMENT ON COLUMN voos.numero_escala 		IS 'Numero de escala do vôo.';
COMMENT ON COLUMN voos.local_de_destino 	IS 'Local de destino do vôo.';
COMMENT ON COLUMN voos.qtde_pilotos 		IS 'Quantidade de pilotos no vôo. (1, 3)';
COMMENT ON COLUMN voos.qtde_comissarios 	IS 'Quantidade de comissário no vôo. (1, 20)';
COMMENT ON COLUMN voos.aviao 			IS 'Avião utilizado no vôo.';
COMMENT ON COLUMN voos.id_aviao 		IS 'Id do avião. (PK da tabela aviões).';


CREATE TABLE pilotos (
                id_piloto		NUMERIC NOT NULL,
                nome 			VARCHAR(50),
                endereco 		VARCHAR(200),
                telefone 		VARCHAR NOT NULL,
                email 			VARCHAR(60) NOT NULL,
                nacionalidade 		VARCHAR(30),
                cargo 			VARCHAR(30),
                salario 		NUMERIC(8,2),
                data_de_admissao 	DATE,
                idiomas 		VARCHAR,
                horas_de_voo 		NUMERIC(5),
                numero_breve 		NUMERIC(8),
                modelos_de_aviao 	VARCHAR,
                id_base_domestica 	NUMERIC,
                id_voo 			INTEGER,
                CONSTRAINT pilotos_pk PRIMARY KEY (id_piloto)
);
COMMENT ON TABLE pilotos 			IS 'Tabela de pilotos.';
COMMENT ON COLUMN pilotos.id_piloto 		IS 'Id do piloto. (PK da tabela)';
COMMENT ON COLUMN pilotos.nome 			IS 'Nome do piloto.';
COMMENT ON COLUMN pilotos.endereco 		IS 'Endereço completo do piloto.';
COMMENT ON COLUMN pilotos.telefone 		IS 'Telefone(s) do piloto.';
COMMENT ON COLUMN pilotos.email 		IS 'E-mail do piloto.';
COMMENT ON COLUMN pilotos.nacionalidade 	IS 'Nacionalidade do piloto.';
COMMENT ON COLUMN pilotos.cargo 		IS 'Cargo do piloto.';
COMMENT ON COLUMN pilotos.salario 		IS 'Salário do piloto.';
COMMENT ON COLUMN pilotos.data_de_admissao 	IS 'Data de admissão do piloto.';
COMMENT ON COLUMN pilotos.idiomas 		IS 'Idiomas falados pelo piloto.';
COMMENT ON COLUMN pilotos.horas_de_voo 		IS 'Horas de vôo do piloto.';
COMMENT ON COLUMN pilotos.numero_breve 		IS 'Número do brevê do piloto.';
COMMENT ON COLUMN pilotos.modelos_de_aviao 	IS 'Modelos de avião que o piloto pode pilotar.';
COMMENT ON COLUMN pilotos.id_base_domestica 	IS 'Id da base doméstica do piloto.';
COMMENT ON COLUMN pilotos.id_voo 		IS 'Id do vôo. (PK da tabela voos)';


ALTER TABLE avioes ADD CONSTRAINT base_manutencao_avioes_fk
FOREIGN KEY (id_base_manutencao)
REFERENCES base_manutencao (id_base_manutencao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pilotos ADD CONSTRAINT base_domestica_pilotos_fk
FOREIGN KEY (id_base_domestica)
REFERENCES base_domestica (id_base_domestica)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE comissarios ADD CONSTRAINT base_domestica_comissarios_fk
FOREIGN KEY (id_base_domestica)
REFERENCES base_domestica (id_base_domestica)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE voos ADD CONSTRAINT avioes_voos_fk
FOREIGN KEY (id_aviao)
REFERENCES avioes (id_aviao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pilotos ADD CONSTRAINT voos_pilotos_fk
FOREIGN KEY (id_voo)
REFERENCES voos (id_voo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
