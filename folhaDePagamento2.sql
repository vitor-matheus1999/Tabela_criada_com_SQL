CREATE DATABASE BDfolhaDePagamento
DROP DATABASE BDfolhaDePagamento

USE BDfolhaDePagamento

CREATE TABLE TBcontatoSocios
(
	id_contato_Socio INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Socio INT NOT NULL, 
	tipo_Contato VARCHAR(40) NOT NULL,
	descricao_Contato VARCHAR (50) NOT NULL,
	CONSTRAINT fk_id_Socio FOREIGN KEY(id_Socio) REFERENCES TBsocios(id_Socios)
);


CREATE TABLE TBsocios
(
	id_Socios INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Empresa INT NOT NULL,
	tipo_socio VARCHAR(60) NOT NULL,
	nome VARCHAR(50),
	tipo_Registro_Receita_Federal VARCHAR(50) NOT NULL,
	descricao_Registro_Receita_Federal VARCHAR(25) NOT NULL,
	CONSTRAINT fk_id_Empresa FOREIGN KEY(id_Empresa) REFERENCES TBempresa(id_Empresa)
);


CREATE TABLE TBadministradores
(
	id_Administradores INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Empresa INT NOT NULL,
	id_Funcionario INT NOT NULL,
	CONSTRAINT fk_id_Empresa_ADM FOREIGN KEY(id_Empresa) REFERENCES TBempresa(id_Empresa),
	CONSTRAINT fk_id_Funcionario FOREIGN KEY(id_Funcionario) REFERENCES TBfuncionario(id_Funcionario)
);

CREATE TABLE TBcontatoEmpresa
(
	id_Contato_Empresa INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Empresa INT NOT NULL,
	tipo_Contato VARCHAR(40) NOT NULL,
	descricao_Contato VARCHAR (50) NOT NULL,
	CONSTRAINT fk_id_Empresa_Contato FOREIGN KEY(id_Empresa) REFERENCES TBempresa(id_Empresa)
);

CREATE TABLE TBempresa
(
	id_Empresa INT identity(1,1) PRIMARY KEY NOT NULL,
	nome_Empresarial_Fantasia VARCHAR(100) NOT NULL,
	CNAE VARCHAR (14) NOT NULL,
	CNPJ VARCHAR(14) NOT NULL,
	situacao_Cadastral VARCHAR(10) NOT NULL,
	natureza_Juridica VARCHAR(50) NOT NULL,
	data_Abertura DATE NOT NULL,
	atividades_Economicas VARCHAR(200) NOT NULL,
);


CREATE TABLE TBcontatoFuncionario
(
	id_Contato_Funcionario INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Funcionario INT NOT NULL ,
	tipo_Contato_Funcionario VARCHAR(40) NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	CONSTRAINT fk_id_Funcionario_Contato FOREIGN KEY(id_Funcionario) REFERENCES TBfuncionario(id_Funcionario)
);

CREATE TABLE TBfuncionario
(
	id_Funcionario INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Setor INT NOT NULL ,
	nome_Funcionario VARCHAR(60) NOT NULL,
	sexo VARCHAR(2) NOT NULL,
	cpf_Funcionario VARCHAR(14) NOT NULL,
	horas_Nao_Trabalhadas FLOAT NOT NULL,
	horas_Extras FLOAT NOT NULL 
);

CREATE TABLE TBenderecoFuncionario
(
	id_Endereco_Funcionario INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Funcionario INT NOT NULL,
	rua VARCHAR(60) NOT NULL,
	numero_moradia VARCHAR(20)NOT NULL,
	bairro VARCHAR(60) NOT NULL ,
	cep_residencia VARCHAR(9) NOT NULL,
	cidade VARCHAR(40) NOT NULL,
	CONSTRAINT fk_id_Funcionario_Endereco FOREIGN KEY (id_Funcionario) REFERENCES TBfuncionario(id_Funcionario)
);

CREATE TABLE TBenderecoEmpresa
(
	id_Endereco_Empresa INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Empresa INT NOT NULL,
	rua VARCHAR(60) NOT NULL,
	numero_Empresa VARCHAR(20)NOT NULL,
	bairro VARCHAR(60) NOT NULL ,
	cep_Empresa VARCHAR(8) NOT NULL,
	cidade VARCHAR(40) NOT NULL,
	CONSTRAINT fk_id_Empresa_Endereco FOREIGN KEY (id_Empresa) REFERENCES TBempresa(id_Empresa)
);

CREATE TABLE TBsetor
(
	id_Setor INT identity(1,1) PRIMARY KEY NOT NULL,
	id_Empresa INT NOT NULL,
	id_Salario INT NOT NULL,
	hierarquia VARCHAR (60) NOT NULL,
	funcao_setor VARCHAR(60) NOT NULL,
	periodo_Trabalho VARCHAR(10) NOT NULL,
	carga_Horaria TIME NOT NULL,
	CONSTRAINT fk_id_Salario FOREIGN KEY(id_Salario) REFERENCES TBsalario(id_Salario),
	CONSTRAINT fk_id_Empresa_Setor FOREIGN KEY(id_Empresa) REFERENCES TBempresa(id_Empresa)
);

CREATE TABLE TBsalario
(
	id_Salario INT identity(1,1) PRIMARY KEY NOT NULL,
	id_empresa INT,
	salario_Bruto DECIMAL (12,2) NOT NULL,
	salario_Liquido DECIMAL (12,2) NOT NULL,
	desconto_FGTS VARCHAR(3) NOT NULL,
	desconto_INSS FLOAT NOT NULL,
	desconto_Vale_Transporte FLOAT NOT NULL,
	desconto_Vale_Alimentacao FLOAT ,
	salario_Ganho_Em_Horas DECIMAL (12,2) NOT NULL,
	salario_Diario DECIMAL(12,2) NOT NULL
	CONSTRAINT fk_Empresa FOREIGN KEY (id_Empresa) REFERENCES TBempresa(id_Empresa)
);



/*Empresa*/
INSERT INTO TBenderecoEmpresa (id_Empresa, rua,numero_Empresa,bairro,cep_Empresa,cidade) VALUES ( 1	,'Rua das Flores',	'123', 'Jardim Primavera',	'2345-678', 'SÃO PAULO');
INSERT INTO TBenderecoEmpresa (id_Empresa, rua,numero_Empresa,bairro,cep_Empresa,cidade) VALUES (2,	'Avenida Central',	'456',	'Centro Histórico'	,'9876-432' ,'RIO DE JANEIRO');

INSERT INTO TBempresa(nome_Empresarial_Fantasia,CNAE,CNPJ,situacao_Cadastral,natureza_Juridica,data_Abertura,atividades_Economicas) VALUES('GlobalTraders','1234-5/ABCD' , '12345678000190','ATIVA','EIRELI','10-05-2023','Serviços de consultoria em marketing digital');
INSERT INTO TBempresa(nome_Empresarial_Fantasia,CNAE,CNPJ,situacao_Cadastral,natureza_Juridica,data_Abertura,atividades_Economicas) VALUES('SkyHighTech',	'5678-9/EFGH',	 '11222333000144',	'ATIVA',	'Ltda',	'11-05-2023'	, 'Serviços de desenvolvimento de software');

INSERT INTO TBcontatoEmpresa (id_Empresa, tipo_Contato, descricao_Contato) VALUES(1,	'telefone-fixo',	'(11)26251798');
INSERT INTO TBcontatoEmpresa (id_Empresa, tipo_Contato, descricao_Contato) VALUES(1,	'E-mail',	'email.empresa@empresa.com.br');
INSERT INTO TBcontatoEmpresa (id_Empresa, tipo_Contato, descricao_Contato) VALUES(2,	'telefone-Celular',	'(11)984651238');
INSERT INTO TBcontatoEmpresa (id_Empresa, tipo_Contato, descricao_Contato) VALUES(2,	'LinkedIn',	'https://www.linkedin.com/in/nome-empresa');

/*Sócios*/
INSERT INTO TBsocios (id_empresa,tipo_socio,nome,tipo_Registro_Receita_Federal,descricao_Registro_Receita_Federal) VALUES(1,	'Socio-Fundador',	'Antonio Conselheiro',	'CNPJ',	'67.890.123/0001-76');
INSERT INTO TBsocios (id_empresa,tipo_socio,nome,tipo_Registro_Receita_Federal,descricao_Registro_Receita_Federal) VALUES(1,	'Socio-Quotista',	'Mariana Bonvarri',	'CNPJ', '34.567.890/0001-21');
INSERT INTO TBsocios (id_empresa,tipo_socio,nome,tipo_Registro_Receita_Federal,descricao_Registro_Receita_Federal) VALUES(2,	'Sócio-Fundador',	'Lydia Fagundes Teles', 	'CNPJ',	'78.901.234/0001-09');
INSERT INTO TBsocios (id_empresa,tipo_socio,nome,tipo_Registro_Receita_Federal,descricao_Registro_Receita_Federal) VALUES(2,	'Socio-Quotista',	'Clarice Lispector' ,	'CPF',	'123.456.789-00');

INSERT INTO TBcontatoSocios (id_Socio,tipo_Contato,descricao_Contato) VALUES(1,	'Telefone-Celular',	'(11)99876-5432');
INSERT INTO TBcontatoSocios (id_Socio,tipo_Contato,descricao_Contato) VALUES(2,	'Email-Empresarial',	'mariana.empresa@email.empresa.com');
INSERT INTO TBcontatoSocios (id_Socio,tipo_Contato,descricao_Contato) VALUES(3,	'Telefone-Empresarial',	'(55)4567-8901');
INSERT INTO TBcontatoSocios (id_Socio,tipo_Contato,descricao_Contato) VALUES(4,	'Email-Pessoal',	'clarice.lispector@email.com');

/*Salários*/

INSERT INTO TBsalario (id_empresa,salario_Bruto,salario_Liquido,desconto_FGTS,desconto_INSS,desconto_Vale_Alimentacao,desconto_Vale_Transporte,salario_Ganho_Em_Horas,salario_Diario)VALUES(1,	3500.00,	2520.00,	'SIM',	12,	6,	10,	19.88,	159.09);
INSERT INTO TBsalario (id_empresa,salario_Bruto,salario_Liquido,desconto_FGTS,desconto_INSS,desconto_Vale_Alimentacao,desconto_Vale_Transporte,salario_Ganho_Em_Horas,salario_Diario)VALUES(1,	4800.00,	3264.00,	'SIM',	14,	6,	12,	27.27,	218.18);
INSERT INTO TBsalario (id_empresa,salario_Bruto,salario_Liquido,desconto_FGTS,desconto_INSS,desconto_Vale_Alimentacao,desconto_Vale_Transporte,salario_Ganho_Em_Horas,salario_Diario)VALUES(2,	6200.00,	4340.00,	'SIM',	14,	6,	10,	35.22,	281.81);
INSERT INTO TBsalario (id_empresa,salario_Bruto,salario_Liquido,desconto_FGTS,desconto_INSS,desconto_Vale_Alimentacao,desconto_Vale_Transporte,salario_Ganho_Em_Horas,salario_Diario)VALUES(2,	5000.00,	3450.00,	'SIM',	14,	6,	11,	28.4,	227.27);
INSERT INTO TBsalario (id_empresa,salario_Bruto,salario_Liquido,desconto_FGTS,desconto_INSS,desconto_Vale_Alimentacao,desconto_Vale_Transporte,salario_Ganho_Em_Horas,salario_Diario)VALUES(1,	1500.00,	1455.00,	'NÃO',	0,  3,  0,	11.36,	68.18);

/*Setor*/

INSERT INTO TBsetor (id_Empresa,id_Salario,hierarquia,funcao_setor,periodo_Trabalho,carga_Horaria)VALUES(1,	1,	'Junior',	'Analista de Dados','M/T', '8:00:00');
INSERT INTO TBsetor (id_Empresa,id_Salario,hierarquia,funcao_setor,periodo_Trabalho,carga_Horaria)VALUES(1,	2,	'Senior',	'Recursos Humanos',	'T/N',	'8:00:00');
INSERT INTO TBsetor (id_Empresa,id_Salario,hierarquia,funcao_setor,periodo_Trabalho,carga_Horaria)VALUES(2,	3,	'Pleno',	'Técnico de informática', 'M/T', '8:00:00');
INSERT INTO TBsetor (id_Empresa,id_Salario,hierarquia,funcao_setor,periodo_Trabalho,carga_Horaria)VALUES(2,	4,	'Senior',	'Recursos Humanos',	'M/T',	'8:00:00');
INSERT INTO TBsetor (id_Empresa,id_Salario,hierarquia,funcao_setor,periodo_Trabalho,carga_Horaria)VALUES(1,	5,	'Estágio','Analista de Dados',	'M/T',	'6:00:00');

/*Funcionário*/

INSERT INTO TBfuncionario (id_Setor,nome_Funcionario,sexo,cpf_Funcionario,horas_Nao_Trabalhadas,horas_Extras) VALUES(1,	'João da Silva',	'F',	'123.456.789-00',	2,	1);
INSERT INTO TBfuncionario (id_Setor,nome_Funcionario,sexo,cpf_Funcionario,horas_Nao_Trabalhadas,horas_Extras) VALUES(2,	'Maria Souza',	'M',	'987.654.321-01',	2,	2);
INSERT INTO TBfuncionario (id_Setor,nome_Funcionario,sexo,cpf_Funcionario,horas_Nao_Trabalhadas,horas_Extras) VALUES(3,	'Pedro Oliveira',	'F',	'555.666.777-02',	0,	0);
INSERT INTO TBfuncionario (id_Setor,nome_Funcionario,sexo,cpf_Funcionario,horas_Nao_Trabalhadas,horas_Extras) VALUES(4,	'Ana Santos',	'M',	'999.888.777-03',	0,	0);
INSERT INTO TBfuncionario (id_Setor,nome_Funcionario,sexo,cpf_Funcionario,horas_Nao_Trabalhadas,horas_Extras) VALUES(5,	'Lucas Pereira',	'NE',	'111.222.333-04',	0,	2);

INSERT INTO TBenderecoFuncionario (id_Funcionario,rua,numero_moradia,bairro,cep_residencia,cidade) VALUES(1	,'Rua dos Sonhos',	'123',	'Felicidade',	'12345-678',	'SÃO PAULO');
INSERT INTO TBenderecoFuncionario (id_Funcionario,rua,numero_moradia,bairro,cep_residencia,cidade) VALUES(2,	'Avenida das Flores',	'456',	'Primavera',	'98765-432'	,'SÃO PAULO');
INSERT INTO TBenderecoFuncionario (id_Funcionario,rua,numero_moradia,bairro,cep_residencia,cidade) VALUES(3,	'Rua do Sol',	'789',	'Veraneio', 	'54321-876',	'SÃO PAULO');
INSERT INTO TBenderecoFuncionario (id_Funcionario,rua,numero_moradia,bairro,cep_residencia,cidade) VALUES(4,	'Praça da Liberdade', 	'321',	'Centro',	'24680-135',	'SÃO PAULO');
INSERT INTO TBenderecoFuncionario (id_Funcionario,rua,numero_moradia,bairro,cep_residencia,cidade) VALUES(5,	'Alameda dos Sonhos', 	'654',	'Esperança',	'87654-321',	'SÃO PAULO');

INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(1,	'Telefone-Celular',	'(11)91234-5678');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(1,	'Telefone-Celular',	'(11)91234-5689');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(1,	'Email-Empresarial',	'j.silvaofficial@email.empresa.com');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(1,	'Email-Pessoal',	'joaosilva123@email.com');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(1,	'Instagram',	'joaosilva.oficial');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(2,	'Email-Pessoal',	'souzamaria82@email.com');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(2,	'Telefone-Celular',	'(21)98765-4321');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(2,	'Telefone-Celular',	'(21)98765-4322');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(3,	'Twitter',	'mariasouza.art');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(4,	'Email-Empresarial',	'santosanaofficial@email.empresa.com');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(4,	'Instagram',	'ana.santos.travel');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(5,	'Telefone-Residencial',	'(11)2345-6789');
INSERT INTO TBcontatoFuncionario(id_Funcionario,tipo_Contato_Funcionario,descricao)VALUES(5,	'Email-Empresarial',	'pereiraofficial@email.empresa.com');

/*Administradores*/

INSERT INTO TBadministradores (id_Empresa,id_Funcionario)VALUES(1,2);
INSERT INTO TBadministradores (id_Empresa,id_Funcionario)VALUES(2,3);

---------------------------------------------------------------------------------------
/*Backup FULL*/

BACKUP DATABASE BDfolhaDePagamento TO DISK = 'E:\sql server\folhaDePagamento.BAK' WITH INIT;

RESTORE HEADERONLY FROM DISK = 'E:\sql server\folhaDePagamento.BAK';

RESTORE DATABASE BDfolhaDePagamento FROM DISK = 'E:\sql server\folhaDePagamento.BAK' WITH FILE = 1 , RECOVERY;

---------------------------------------------------------------------------------------

SELECT sexo,COUNT(sexo) AS Total FROM TBfuncionario GROUP BY(sexo) ORDER BY(Total);

SELECT COUNT(*) AS TotalFuncionarios FROM TBfuncionario; 

SELECT id_funcionario,  COUNT(tipo_Contato_Funcionario) AS QuantidadeContatoTelefone FROM TBcontatoFuncionario WHERE tipo_Contato_Funcionario LIKE 'Telefone%' GROUP BY(id_funcionario) ;

----------------------------------------------------------------------------------------

SELECT func.id_Funcionario,func.nome_Funcionario,func.cpf_Funcionario, emp.id_Empresa FROM TBfuncionario AS func INNER JOIN TBempresa AS emp ON func.id_Funcionario=emp.id_Empresa;