/**/
/*Criando o schema*/
CREATE SCHEMA escola_online;
USE escola_online ;

/**Tables*/

/*Tabela plano*/
CREATE TABLE plano (
  idPlano INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave Primaria',
  nomePlano VARCHAR(15) COMMENT 'Nome do Plano',
  dataInicio DATE COMMENT 'Data de início do plano',
  dataTermino DATE COMMENT 'Data de termino do plano'
  );

/*Tabela curso*/
CREATE TABLE curso (
  idCurso INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  nomeCurso TEXT COMMENT 'Nome do curso',
  dataCadastro DATE COMMENT 'Data de cadastramento do curso no sistema',
  ultimaAtualizacao DATE COMMENT 'Data da última atualização do curso'
);

/*Tabela aula*/
CREATE TABLE aula (
  idAula INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idCurso INT COMMENT 'Chave extrangeira da tabela Curso',
  titulo VARCHAR(45) COMMENT 'Título da aula',
  pontos INT COMMENT 'Valor da aula em pontos',
  status ENUM('INCONCLUIDO', 'CONCLUIDO') NULL,
  FOREIGN KEY (idCurso) REFERENCES curso (idCurso) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela aluno*/
CREATE TABLE aluno (
  idAluno INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idPlano INT COMMENT 'Chave extrangeira da tabela Plano',
  nomeAluno VARCHAR(100) COMMENT 'Nome do aluno',
  emailAluno VARCHAR(100) COMMENT 'Email do aluno',
  cpf VARCHAR(45) COMMENT 'Cpf do aluno',
  senha VARCHAR(200) COMMENT 'Senha do aluno',
  imagem VARCHAR(200) COMMENT 'Caminho da imágem de perfi do aluno',
  pontuacao INT COMMENT 'Pontos de participação do aluno',
  dataEntrada DATE COMMENT 'Data de entrada do aluno',
  FOREIGN KEY (idPlano) REFERENCES plano (idPlano) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela aluno_aula*/
CREATE TABLE aluno_aula (
  idAula INT NOT NULL COMMENT 'Chave extrangeira da tabela aula',
  idAluno INT NOT NULL COMMENT 'Chave extrangeira da tabela aluno',
  FOREIGN KEY (idAula) REFERENCES aula (idAula) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idAluno) REFERENCES aluno (idAluno) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela carreira*/
CREATE TABLE carreira (
  idCarreira INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primaria da tabela',
  nomeCarreira VARCHAR(100) NULL COMMENT 'Nome da carreira'
  );
  
/*Tabela curso_carreira*/
CREATE TABLE curso_carreira (
  idCarreira INT NOT NULL COMMENT 'Chave extrangeira da tabela carreira',
  idCurso INT NOT NULL COMMENT 'Chave extrangeira da tabela curso',
  FOREIGN KEY (idCurso) REFERENCES curso (idCurso) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idCarreira) REFERENCES carreira (idCarreira) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela professor*/
CREATE TABLE professor (
  idProfessor INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  nomeProfessor VARCHAR(100) NULL COMMENT 'Nome do professor',
  emailProfessor VARCHAR(100) NULL COMMENT 'Email do professor',
  senha VARCHAR(200) NULL COMMENT 'Senha do professor',
  cpf VARCHAR(20) NULL COMMENT 'Cpf do professor'
  );
  
/*Tabela forum*/
CREATE TABLE forum (
  idForum INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idAula INT NOT NULL COMMENT 'Chave extrangeira da tabela aula',
  idAluno INT NOT NULL COMMENT 'Chave extrangeira da tabela aluno',
  pergunta TEXT NULL COMMENT 'Texto da pergunta',
  dataPostagem DATETIME NULL COMMENT 'Data da postágem',
  status ENUM('ABERTO', 'RESOLVIDA') NULL COMMENT 'Status da pergunta',
  FOREIGN KEY (idAula) REFERENCES aula (idAula) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idAluno) REFERENCES aluno (idAluno) ON DELETE NO ACTION ON UPDATE NO ACTION
);


/*Tabela pagamento*/
CREATE TABLE pagamento (
  idPagamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave Primária',
  idAluno INT NOT NULL COMMENT 'Chave Extrangeira da Tabela Aluno',
  idPlano INT NOT NULL COMMENT 'Chave Extrangeira da Tabela Plano',
  numCartao VARCHAR(45) COMMENT 'Número do Cartão',
  nomeTitular VARCHAR(50) COMMENT 'Nome completo do titular',
  vencimentoDia VARCHAR(2) COMMENT 'Dia do vencimento  do cartão',
  vencimentoMes VARCHAR(2) COMMENT 'Mês do vencimento  do cartão',
  vencimentoAno VARCHAR(2) COMMENT 'Ano de vencimento do cartão',
  dataCompra DATETIME COMMENT 'Data da compra',
  parcelas INT(2) COMMENT 'Quantidade de parcelas',
  FOREIGN KEY (idAluno) REFERENCES aluno (idAluno) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idPlano) REFERENCES plano (idPlano) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela respostas*/
CREATE TABLE respostas (
  idResposta INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idForum INT NOT NULL COMMENT 'Chave extrangeira da tabela Forum',
  idAluno INT NULL COMMENT 'Chave extrangeira da tabela aluno',
  idProfessor INT NULL COMMENT 'Chave extrangeira da tabela professor',
  textoResposta TEXT COMMENT 'Conteúdo da resposta',
  dataResposta DATETIME COMMENT 'Data da resposta',
  status ENUM('certa', 'errada') NULL COMMENT 'Resultado se é ou não a resposta correta da questão',
  FOREIGN KEY (idForum) REFERENCES forum (idForum) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idAluno) REFERENCES aluno (idAluno) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idProfessor) REFERENCES professor (idProfessor) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela professor_curso*/
CREATE TABLE professor_curso (
  idProfessor INT NOT NULL,
  idCurso INT NOT NULL,
  FOREIGN KEY (idProfessor) REFERENCES professor (idProfessor) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (idCurso) REFERENCES curso (idCurso) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela parcelas*/
CREATE TABLE parcelas (
  idParcelas INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idPagamento INT NOT NULL,
  parcelaNum INT NOT NULL,
  valor DECIMAL(6,2) NULL COMMENT 'Valor da parcela',
  vencimentoData DATE NULL COMMENT 'Data de vencimento da parcela',
  status ENUM('A_PAGAR', 'QUITADO', 'ATRASADO') NULL COMMENT 'Status do pagamento da parcela',
  FOREIGN KEY (idPagamento) REFERENCES pagamento (idPagamento) ON DELETE NO ACTION ON UPDATE NO ACTION
);
            
/*Tabela topico*/
CREATE TABLE topico (
  idTopico INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idAula INT NOT NULL,
  titulo VARCHAR(50) COMMENT 'Título do tópico',
  video VARCHAR(200) COMMENT 'Endereço do vídeo',
  trancricao TEXT COMMENT 'Trancrição do vídeo',
  observacao TEXT,
  pontos INT COMMENT 'Valor do tópico por pontos',
  status ENUM('INCONCLUIDO', 'CONCLUIDO') NULL,
  FOREIGN KEY (idAula) REFERENCES aula (idAula) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela exercicio*/
CREATE TABLE exercicio (
  idExercicio INT NOT NULL PRIMARY KEY  AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  idTopico INT NOT NULL COMMENT 'Chave extrangeira da tabela topico',
  questao TEXT NULL COMMENT 'Texto da questão',
  alternativaCorreta INT NULL COMMENT 'O id da alternativa correta',
  pontos INT NULL COMMENT 'Valor da questão em pontos',
  FOREIGN KEY (idTopico) REFERENCES topico (idTopico) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*Tabela alternativa*/
CREATE TABLE alternativa (
  idAlternativa INT NOT NULL PRIMARY KEY  AUTO_INCREMENT COMMENT 'Chave primária da tabela',
  texto TEXT NULL COMMENT 'Texto da alternativa',
  idExercicio INT NOT NULL COMMENT 'Chave extrangeira da tabela exercicio',
  FOREIGN KEY (idExercicio) REFERENCES exercicio (idExercicio) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/**inserts*/

/*Insert curso*/
INSERT INTO plano(nomePlano,dataInicio,dataTermino) VALUE('Basico','2020-01-01','2020-3-01');
INSERT INTO plano(nomePlano,dataInicio,dataTermino) VALUE('Intermediario','2020-01-01','2020-6-01');
INSERT INTO plano(nomePlano,dataInicio,dataTermino) VALUE('Avançado','2020-01-01','2020-12-01');

/*Insert curso*/
INSERT INTO curso(nomeCurso,dataCadastro,ultimaAtualizacao) VALUES('Logica Básica','2020-09-01','2020-10-01');
INSERT INTO curso(nomeCurso,dataCadastro,ultimaAtualizacao) VALUES('Orientação a Objetos','2020-09-01','2020-10-01');
INSERT INTO curso(nomeCurso,dataCadastro,ultimaAtualizacao) VALUES('Tipo de Listas','2020-09-01','2020-10-01');
INSERT INTO curso(nomeCurso,dataCadastro,ultimaAtualizacao) VALUES('Trabalhando com Exceções','2020-09-01','2020-10-01');
INSERT INTO curso(nomeCurso,dataCadastro,ultimaAtualizacao) VALUES('Criando Thread','2020-09-01','2020-10-01');

/*Insert aula*/
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 1, "Introdução", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 1, "Historia", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 1, "Evolução", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 1, "Mão na massa", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 5, "Herança e Polimorfismo", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 2, "Interface", 2);
INSERT INTO aula(idCurso,titulo,pontos) VALUES ( 2, "Sobrescrevendo Métodos", 2);

/*aluno*/
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 1, 'Fafa de Belem', 'fafa@gmail.com', '11231223312', sha('14523'),"#","20034","2019-01-01");
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 1, 'Reginaldo Rossi', 'reg@gmail.com', '13123123212', sha('34125'),"#","3462","2019-01-01");
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 2, 'Mc Marcinho', 'marc@gmail.com', '12312123123', sha('14523'),"#","211","2019-01-01");
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 2, 'Zeca Pagodinho', 'ze@gmail.com', '12231231231', sha('31245'),"#","0","2019-01-01");
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 3, 'Axl Rose', 'rose@gmail.com', '12312312231', sha('12345'),"#","8765443","2019-01-01");
INSERT INTO aluno(idPlano,nomeAluno,emailAluno,CPF,senha,imagem,pontuacao,dataEntrada) 
VALUES( 3, 'Pepê e Nenêm', 'pene@gmail.com', '33312333331', sha('BCD45'),"#","2356","2019-01-01");


/*Insert aluno_aula*/
INSERT INTO aluno_aula(idAula, idAluno) VALUES(1,1);
INSERT INTO aluno_aula(idAula, idAluno) VALUES(4,2);
INSERT INTO aluno_aula(idAula, idAluno) VALUES(1,3);
INSERT INTO aluno_aula(idAula, idAluno) VALUES(5,4);
INSERT INTO aluno_aula(idAula, idAluno) VALUES(2,4);
INSERT INTO aluno_aula(idAula, idAluno) VALUES(1,5);

/*Insert carreira*/
INSERT INTO carreira(nomeCarreira) VALUE("Desenvolvedor Java I");
INSERT INTO carreira(nomeCarreira) VALUE("Desenvolvedor Java II");

/*Inser curso_carreira*/
INSERT INTO curso_carreira(idCarreira,idCurso) VALUES(1,1);
INSERT INTO curso_carreira(idCarreira,idCurso) VALUES(1,2);
INSERT INTO curso_carreira(idCarreira,idCurso) VALUES(2,3);
INSERT INTO curso_carreira(idCarreira,idCurso) VALUES(2,4);
INSERT INTO curso_carreira(idCarreira,idCurso) VALUES(2,5);

/*Insert professor*/
INSERT INTO professor(nomeProfessor,emailProfessor,senha,cpf) VALUES ('Zé Ramalho', 'ze@gmail.com', sha('12345'),'12312312312');
INSERT INTO professor(nomeProfessor,emailProfessor,senha,cpf) VALUES ('Jô Soares', 'jo@gmail.com', sha('55555'),'88888888888');

/*Insert forum*/
INSERT INTO forum(idAula,idAluno,pergunta,dataPostagem,status) 
VALUES (1,1,"Como instalar o JDK?","2020-02-01 12:31:33", 'ABERTO');
INSERT INTO forum(idAula,idAluno,pergunta,dataPostagem,status) 
VALUES (1,2,"Não conosigo fazer o Helo World?","2020-07-04 13:40:02", "ABERTO");
INSERT INTO forum(idAula,idAluno,pergunta,dataPostagem,status) 
VALUES (1,3,"Como pegar os dados da lista?","2020-01-07 10:20:09", "RESOLVIDA");
INSERT INTO forum(idAula,idAluno,pergunta,dataPostagem,status) 
VALUES (1,4,"O que é Map?","2020-03-05 10:20:00", "RESOLVIDA");
INSERT INTO forum(idAula,idAluno,pergunta,dataPostagem,status) 
VALUES (1,5,"Como iterar na lista?","2020-02-02 11:02:33", "RESOLVIDA");

/*Insert pagamento*/
INSERT INTO pagamento(idAluno,idPlano,numCartao, nomeTitular, vencimentoDia, vencimentoMes, vencimentoAno, dataCompra, parcelas) 
VALUES(1,1,1234567890, "Muçum", "2", "5", "20", '2020-12-01 10:34:20', 12);
INSERT INTO pagamento(idAluno,idPlano,numCartao, nomeTitular, vencimentoDia, vencimentoMes, vencimentoAno, dataCompra, parcelas) 
VALUES(2,3,6781234590, "Milton Nascimento", "6", "5", "20", '2020-11-01 20:12:11', 12);
INSERT INTO pagamento(idAluno,idPlano,numCartao, nomeTitular, vencimentoDia, vencimentoMes, vencimentoAno, dataCompra, parcelas) 
VALUES(3,3,6712345890, "Ozzy Osbourne", "3", "12", "20", '2020-05-21 05:10:55', 12);
INSERT INTO pagamento(idAluno,idPlano,numCartao, nomeTitular, vencimentoDia, vencimentoMes, vencimentoAno, dataCompra, parcelas) 
VALUES(4,2,4123567890, "Falcão", "7", "9", "20", '2020-11-23 09:12:43', 12);
INSERT INTO pagamento(idAluno,idPlano,numCartao, nomeTitular, vencimentoDia, vencimentoMes, vencimentoAno, dataCompra, parcelas) 
VALUES(5,1,9123456780, "John Francis Bongiovi", "5", "4", "20", '2020-07-03 10:20:21', 12);

/*Insert respostas*/
INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(1, NULL, 1, "Procure no site oficial","2020-02-01 13:40:24", "certa");

INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(2, NULL, 2, "Reveja a aula","2020-05-10 11:20:10", "certa");

INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(2, NULL, 2, "Reveja a aula","2020-05-10 11:20:10", "certa");

INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(2, 3, NULL, "Tenta fazer um getText()","2020-06-23 11:12:10", "errada");

INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(3, 5, NULL, "Deve ser o Google Map","2020-06-23 11:40:30", "errada");

INSERT INTO respostas(idForum, idAluno, idProfessor, textoResposta,dataResposta, status)
VALUES(3, 2, NULL, "Use um forEach ou lambda","2020-06-07 09:23:55", "certa");

/*Insert professor_curso*/
INSERT INTO professor_curso(idProfessor,idCurso) VALUES(1,1);
INSERT INTO professor_curso(idProfessor,idCurso) VALUES(2,2);
INSERT INTO professor_curso(idProfessor,idCurso) VALUES(1,3);

/*Insert parcelas*/
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,1,100.0,"2020-12-01","QUITADO");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,2,100.0,"2021-01-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,3,100.0,"2021-02-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,4,100.0,"2021-03-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,5,100.0,"2021-04-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,6,100.0,"2021-05-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,7,100.0,"2021-06-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,8,100.0,"2021-07-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,9,100.0,"2021-08-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,10,100.0,"2021-09-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,11,100.0,"2021-10-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(1,12,100.0,"2021-11-01","A_PAGAR");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(2,1,1000.0,"2021-11-01","QUITADO");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(3,1,1000.0,"2021-11-01","QUITADO");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(4,1,1000.0,"2021-11-01","QUITADO");
INSERT INTO parcelas(idPagamento,parcelaNum,valor,vencimentoData,status) VALUES(5,1,1000.0,"2021-11-01","QUITADO");

/*Insert tópico*/
INSERT INTO topico(idAula,titulo,video,trancricao,observacao,pontos,status)
VALUES(1,"Apresentação","#","Lorem Impsu","Lorem Impsu","10","INCONCLUIDO");

INSERT INTO topico(idAula,titulo,video,trancricao,observacao,pontos,status)
VALUES(1,"História","#","Lorem Impsu","Lorem Impsu","10","INCONCLUIDO");

INSERT INTO topico(idAula,titulo,video,trancricao,observacao,pontos,status)
VALUES(1,"Instalação do ambiente","#","Lorem Impsu","Lorem Impsu","10","INCONCLUIDO");

/*Insert exercicio*/
INSERT INTO exercicio(idTopico,questao,alternativaCorreta,pontos) VALUES(1,"O que é java?",4,10);

/*Insert alternativa*/
INSERT INTO alternativa(texto,idExercicio) VALUES("É um animal.", 1);
INSERT INTO alternativa(texto,idExercicio) VALUES("É uma marca de café.", 1);
INSERT INTO alternativa(texto,idExercicio) VALUES("É a musica do Mr. Love Man.", 1);
INSERT INTO alternativa(texto,idExercicio) VALUES("É uma linguágem de programação.", 1);

/**Consultas*/

/*Quais cursos cada aluno está matriculado*/ 
SELECT  nomeAluno,titulo,nomeCurso 
FROM aluno 
LEFT JOIN aluno_aula ON aluno.idAluno = aluno_aula.idAluno
LEFT JOIN aula ON aula.idAula = aluno_aula.idAula
INNER JOIN curso ON aula.idCurso = curso.idCurso;

/*Quais aulas cada aluno está matriculado*/
SELECT  idAluno,idPlano,nomeAluno,emailAluno,cpf,
imagem,pONtuacao,dataEntrada,idAula,idCurso,titulo,status 
FROM aluno 
LEFT JOIN aluno_aula ON aluno.idAluno = aluno_aula.idAluno
LEFT JOIN aula ON aula.idAula = aluno_aula.idAula;

/*Quais aulas,curso e carreira cada aluno está matriculado*/
SELECT  aluno.idAluno,nomeAluno,aula.idAula,titulo,curso.idCurso,nomeCurso,carreira.idCarreira,nomeCarreira 
FROM aluno 
LEFT JOIN aluno_aula ON aluno.idAluno = aluno_aula.idAluno
LEFT JOIN aula ON aula.idAula = aluno_aula.idAula
INNER JOIN curso ON aula.idCurso = curso.idCurso
INNER JOIN curso_carreira ON curso.idCurso = curso_carreira.idCurso
INNER JOIN carreira ON carreira.idCarreira = curso_carreira.idCarreira;

/*Exibe grade curricular completa*/
SELECT carreira.idCarreira,nomeCarreira,curso.idCurso,nomeCurso,dataCadastro,ultimaAtualizacao,titulo FROM carreira 
INNER JOIN curso_carreira ON carreira.idCarreira = curso_carreira.idCarreira
INNER JOIN curso ON curso_carreira.idCurso = curso.idCurso
INNER JOIN aula ON aula.idCurso = curso.idCurso;
SELECT * FROM aluno_aula;

/*Busca aluno e o plano que cada um assinou*/
SELECT idAluno,nomeAluno,emailAluno,cpf,imagem,pONtuacao,dataEntrada,nomeplano,dataInicio,dataTermino FROM aluno
INNER JOIN plano ON aluno.idPlano = plano.idPlano;

/*Todos os alunos que tem parcelas à pagar*/
SELECT * FROM aluno
RIGHT JOIN pagamento ON aluno.idAluno = pagamento.idAluno
LEFT JOIN parcelas ON pagamento.idPagamento = parcelas.idPagamento
WHERE status = 'A_PAGAR';



/*Busca tudo do forum*/
SELECT forum.idForum,idAula,forum.idAluno AS Quem_perguntou_id,aluno.nomeAluno AS Quem_perguntou_nome,
pergunta,dataPostagem,forum.status,respostas.idAluno AS Quem_respondeu_aluno,
idProfessor AS Quem_respondeu_professor,textoResposta,dataResposta,respostas.status  FROM forum
 INNER JOIN respostas ON forum.idForum = respostas.idForum
 INNER JOIN aluno ON aluno.idAluno = respostas.idAluno;
 
 /*Busca as perguntas não resolvidas do forum*/
 SELECT forum.idForum,idAula,forum.idAluno as Quem_perguntou_id,aluno.nomeAluno as Quem_perguntou_nome,pergunta,dataPostagem,forum.status,respostas.idAluno as Quem_respondeu_aluno,idProfessor as Quem_respondeu_professor,textoResposta,dataResposta,respostas.status 
 FROM forum
 INNER JOIN respostas ON forum.idForum = respostas.idForum
 INNER JOIN aluno ON aluno.idAluno = respostas.idAluno
 WHERE forum.status = 'ABERTO';