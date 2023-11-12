USE exer_ddl_dml02
-- Quanto projetos não tem usuarios associados a ele
SELECT COUNT(*) qty_projects_no_users
FROM projetos p LEFT OUTER JOIN usuario_projetos up
ON p.id = up.projetos_id
WHERE up.projetos_id IS NULL

--Id do projeto, nome do projeto, qty_users_project (quantidade de usuários por projeto)
--em ordem alfabética crescente pelo nome do projeto

SELECT p.id, p.nome, COUNT(u.id) AS qty_users_project
FROM projetos p, usuario u, usuario_projetos up
WHERE p.id = up.projetos_id
      AND u.id = up.usuario_id
GROUP BY p.id, p.nome
ORDER BY p.nome