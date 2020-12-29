


DROP DATABASE escola_online;

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

