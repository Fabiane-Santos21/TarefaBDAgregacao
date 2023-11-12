USE locadora_02
--Consultar, num_cadastro do cliente, nome do cliente, titulo do filme, data_fabricação do dvd
--valor da locação, dos dvds que tem a maior data de fabricação dentre todos os cadastrados

SELECT c.num_cadastro, c.nome, f.titulo, 
       CONVERT(CHAR(10), d.data_fabricacao, 103) AS data_fabricacao,
       l.valor
FROM locacao l, cliente c, filme f, dvd d
WHERE c.num_cadastro = l.clientenum_cadastro
      AND d.num = l.dvdnum
	  AND d.filmeid = f.id
	  AND d.data_fabricacao IN (
	       SELECT MAX(data_fabricacao)
		   FROM dvd
		   )

-- Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA)
-- quantidade de DVD´s alugados por cliente (Chamar essa coluna de qtd), por data de locação

SELECT c.num_cadastro, c.nome,
       CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	   COUNT(l.dvdnum) AS qtd
FROM cliente c, locacao l
WHERE c.num_cadastro = l.clientenum_cadastro
GROUP BY c.num_cadastro, c.nome, l.data_locacao
ORDER BY l.data_locacao

-- Consultar, num_cadastro do cliente, nome do cliente, data de locação (Formato DD/MM/AAAA)
-- valor total de todos os dvd´s alugados (Chamar essa coluna de valor_total), por data de locação

SELECT c.num_cadastro, c.nome,
       CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	   SUM(l.valor) AS valor_total
FROM cliente c, locacao l
WHERE c.num_cadastro = l.clientenum_cadastro
GROUP BY c.num_cadastro, c.nome, l.data_locacao
ORDER BY l.data_locacao

--Consultar, num_cadastro do cliente, nome do cliente
--Endereço concatenado de logradouro e numero como Endereco, data de locação (Formato DD/MM/AAAA)
--dos clientes que alugaram mais de 2 filmes simultaneamente

SELECT c.num_cadastro, c.nome, 
	c.logradouro +','+ CAST(c.num AS VARCHAR(5)) AS endereco, 
	CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao
FROM cliente c, locacao l
WHERE c.num_cadastro = l.clientenum_cadastro
GROUP BY c.num_cadastro, c.nome, 
	c.logradouro +','+ CAST(c.num AS VARCHAR(5)), l.data_locacao
HAVING COUNT(l.dvdnum) > 2