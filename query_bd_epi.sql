ALTER TABLE funcionario ADD COLUMN email VARCHAR(20);
ALTER TABLE entrega ADD COLUMN qtd_entrega VARCHAR(50);
ALTER TABLE funcionario MODIFY COLUMN  cpf CHAR(11) UNIQUE;
describe fornecedor; 
describe setor;
describe funcionario; 
describe epi;
describe inspecao_epi;
describe estoque;
describe entrega;
select * from setor; 
select * from funcionario;
select * from epi;
select * from estoque;
select * from entrega;
INSERT INTO estoque(id_epi, qtd_disponivel) VALUES (2, '20'), (1, '22'), ('3', '25'), ('4', '13'), ('5', '63');
INSERT INTO setor(nome_setor) VALUES ('Produção'), ('Manutenção'), ('Recursos Humanos'), ('Qualidade'), ('Almoxarifado');
INSERT INTO funcionario(nome, id_setor) Values ('Giovani Neves','1'), ('Beatriz Camillo', '2'), ('Enzo Turco', '3'), ('Bruno Henrique','4'), ('Caio Gabriel','5');
INSERT INTO funcionario(nome, id_setor) Values ('Jorge aragão','1');
INSERT INTO epi(nome, dt_validade, numero_ca) VALUES ('Capacete', '2026-11-27', '123456'), ('Bota', '2026-11-27', '654321'), ('Luva', '2026-05-13', '456789'), ('Protetor Auricular', '2026-02-20', '987654'), ('Colete', '2026-04-22', '220760'), ('Oculos', '2026-06-06', '525516');
INSERT INTO entrega(id_funcionario, id_epi ,dt_entrega, assinatura) VALUES (16,1,'2026-06-01',TRUE), (17,2,'2026-06-11',TRUE), (18,3,'2026-06-21',TRUE), (19,4,'2026-06-01',TRUE), (20,5,'2026-06-15',TRUE), (16,1,'2026-07-01',TRUE), (17,3,'2026-07-11',TRUE), (18,1,'2026-06-01',TRUE), (19,4,'2026-09-01',TRUE), (20,5,'2026-08-01',TRUE);
UPDATE entrega 
set dt_devolucao = '2026-07-09'
Where id_entrega = 13;

SELECT f.id_funcionario
FROM Funcionario f
LEFT JOIN Entrega e 
    ON f.id_funcionario = e.id_funcionario
WHERE e.id_funcionario IS NULL;

SELECT nome, numero_ca, dt_validade,
	DATEDIFF(dt_validade, CURDATE()) AS dias_restantes
FROM epi
WHERE dt_validade <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY dt_validade;

SELECT s.nome_setor, f.nome AS funcionario,e.nome AS epi
FROM entrega em
JOIN funcionario f ON en.id_funcionario = f.id_funcionario
JOIN setor s ON f.id_setor = s.id_setor
JOIN epi e ON en.id_epi = e.id_epi
ORDER BY s.nome_setor;

SELECT s.nome_setor,
    COUNT(e.id_entrega) AS total_epis_entregues
FROM setor s
LEFT JOIN funcionario f 	
    ON s.id_setor = f.id_setor
LEFT JOIN entrega e 
    ON f.id_funcionario = e.id_funcionario
GROUP BY s.nome_setor;

SELECT f.nome, e.nome AS epi, en.dt_entrega
FROM entrega en
JOIN funcionario f ON en.id_funcionario = f.id_funcionario
JOIN epi e ON en.id_epi = e.id_epi
WHERE en.assinatura = FALSE;

SELECT f.nome AS funcionario, e.nome AS epi,e.numero_ca, en.dt_entrega, en.assinatura
FROM entrega en
JOIN funcionario f ON en.id_funcionario = f.id_funcionario
JOIN epi e ON en.id_epi = e.id_epi
WHERE f.id_funcionario;

INSERT INTO entrega(id_funcionario, id_epi ,dt_entrega, assinatura) VALUES (89,1,'2026-06-01',TRUE);

Delete from entrega


