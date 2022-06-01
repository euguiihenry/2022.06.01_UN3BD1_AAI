/*
Trabalho Autoinstrucional de BD1:

Alunos:	Guilherme Henrique & Matheus de Oliveria.	
			
*/ 

/*
PARTE 01 - SELECT:
==========================================================================================================================*/
	/*
	Quest�o 01:
	======================================================================================================================*/
		SELECT	SUM(p.PIB) AS 'Total_PIB'
		FROM	PAIS p 
		WHERE	p.DT_INDEP >= CONVERT(DATETIME, '01/01/1920', 102) AND
				p.RENDA_PERCAPTA <= 1000 OR 
				p.CODGRUPO = 2;


	/*
	Quest�o 02:
	======================================================================================================================*/
		SELECT	MIN(PIB) AS 'Menor_PIB'
		FROM	PAIS p INNER JOIN continente c
				ON c.CODCONTINENTE = p.CODCONTINENTE
		WHERE	(c.CONTINENTE = 'AFRICA' OR c.CONTINENTE = 'ASIA') 
				AND p.RENDA_PERCAPTA < 150.00;


	/*
	Quest�o 03:
	======================================================================================================================*/
		SELECT		p.pais AS 'Pa�s',
					p.PIB/p.QTDE_HAB AS 'PIBXQTDEHAB'
		FROM		PAIS p
		ORDER BY	p.pais ASC;


	/*
	Quest�o 04:
	======================================================================================================================*/
		SELECT		p.pais AS 'PAIS',
					(p.RENDA_PERCAPTA * p.QTDE_HAB) AS 'PercXQtdeHab'
		FROM		PAIS p
		WHERE		(p.RENDA_PERCAPTA * P.QTDE_HAB) < 10000000
		ORDER BY	PercXQtdeHab DESC;


	/*
	Quest�o 05:
	======================================================================================================================*/
		SELECT	p.codpais AS 'CODPAIS',
				p.pais AS 'PAIS',
				g.grupo AS 'GRUPO',            
				(p.PIB - p.QTDE_HAB) AS 'PIB_QTDEHAB'
		FROM	PAIS p INNER JOIN grupo g
				ON p.codgrupo = g.codgrupo
		WHERE	grupo = 'MERCOSUL' OR grupo = 'OUTROS'	


	/*
	Quest�o 06:
	======================================================================================================================*/
		SELECT	AVG(p.QTDE_HAB) AS 'Media_Habitantes'
		FROM	PAIS p 
		WHERE	p.DT_INDEP IS NULL;


	/*
	Quest�o 07:
	======================================================================================================================*/
		SELECT	SUM(p.PIB) AS 'Soma_PIB'
		FROM	PAIS p INNER JOIN grupo g
				ON p.codgrupo = g.codgrupo
		WHERE	YEAR(p.DT_INDEP) >= 1950 and (p.RENDA_PERCAPTA <= 1000 OR g.GRUPO = 'OUTROS');


	/*
	Quest�o 08:
	======================================================================================================================*/
		SELECT	p.PAIS AS 'PAIS',
				p.QTDE_HAB AS 'QTDE_HAB',
				p.PIB AS 'PIB'
		FROM	pais p INNER JOIN grupo g
				ON p.codgrupo = g.codgrupo
				INNER JOIN continente c
				ON p.codcontinente = c.codcontinente
		WHERE   c.CONTINENTE = 'OCEANIA' OR (p.QTDE_HAB > 500000 AND g.grupo = 'ALCA');


	/*
	Quest�o 09:

	!!!! The app says that there's a mistake in the row of WHERE, I'm not finding it! Check it later on!
	======================================================================================================================*/
		SELECT		c.continente AS 'CONTINENTE',
					p.pais AS 'PAIS',
					ps.VALORNEGOCIADO AS 'VALOR NEGOCIADO'
		FROM		continente c INNER JOIN pais p
					INNER JOIN paisxseg ps
					ON p.CODPAIS = ps.CODPAIS
					INNER JOIN SEGMENTO seg
					ON seg.CODSEGMENTO = ps.CODSEGMENTO
		WHERE		s.CODSEGMENTO = 3 AND (c.continente = 'EUROPA' OR c.continente = 'AMERICA DO NORTE')
		ORDER BY	VALORNEGOCIADO ASC;


	/*
	Quest�o 10:
	======================================================================================================================*/
		SELECT		c.continente,
					AVG(p.RENDA_PERCAPTA)
		FROM		continente c INNER JOIN pais p
					ON c.CODCONTINENTE = p.CODCONTINENTE
		GROUP BY	c.continente;


	/*
	Quest�o 11:
	======================================================================================================================*/
		SELECT		g.grupo AS 'GRUPO',
					SUM(ps.VALORNEGOCIADO) AS 'TOTAL VLR NEGOCIADO'
		FROM		grupo g INNER JOIN pais p
					ON g.CODGRUPO = p.CODGRUPO
					INNER JOIN PAISXSEG ps
					ON ps.CODPAIS = p.CODPAIS
		GROUP BY	g.grupo;


	/*
	Quest�o 12:
	======================================================================================================================*/
		SELECT		s.segmento AS 'SEGMENTO',
					AVG(p.PIB) AS 'MEDIA DO PIB'
		FROM		grupo g INNER JOIN pais p
					ON g.CODGRUPO = p.CODGRUPO
					INNER JOIN paisxseg ps
					ON p.CODPAIS = ps.CODPAIS
					INNER JOIN segmento s
					ON ps.CODSEGMENTO = s.CODSEGMENTO
		WHERE		g.grupo = 'UNIAO EUROPEIA'
		GROUP BY	s.segmento;	


	/*
	Quest�o 13:
	======================================================================================================================*/
		SELECT		c.continente,
					AVG(p.renda_percapta) AS 'Media Per Capta'
		FROM		continente c INNER JOIN pais p
					ON c.CODCONTINENTE = p.CODCONTINENTE
		GROUP BY	c.continente
		HAVING		AVG(p.renda_percapta) > 2000.00


	/*
	Quest�o 14:
	======================================================================================================================*/
		SELECT		g.GRUPO,
					SUM(ps.VALORNEGOCIADO) AS 'TOTAL VLR NEGOCIADO'
		FROM		grupo g INNER JOIN pais p
					ON g.CODGRUPO = p.CODGRUPO
					INNER JOIN PAISXSEG ps
					ON p.CODPAIS = ps.CODPAIS
		GROUP BY	g.GRUPO
		HAVING		SUM(ps.VALORNEGOCIADO) > 20000000000.00;


	/*
	Quest�o 15:
	======================================================================================================================*/
		SELECT		s.segmento AS 'SEGMENTO',
					AVG(p.pib) AS 'MEDIA PIB'
		FROM		grupo g INNER JOIN pais p
					ON g.CODGRUPO = p.CODGRUPO
					INNER JOIN continente c
					ON c.CODCONTINENTE = p.CODCONTINENTE
					INNER JOIN paisxseg ps
					ON ps.CODPAIS = p.CODPAIS
					INNER JOIN segmento s
					ON s.CODSEGMENTO = ps.CODSEGMENTO
		WHERE		(g.GRUPO = 'ONGS' OR c.CONTINENTE = 'ASIA')
		GROUP BY	s.segmento
		HAVING		AVG(p.pib) < 2000000000;


/*
PARTE 02 - INSERT, UPDATE e DELETE
==========================================================================================================================*/
	/*
	Quest�o 01:
	======================================================================================================================*/
		
		
	/*
	Quest�o 02:
	======================================================================================================================*/
			
		
	/*
	Quest�o 03:
	======================================================================================================================*/
			
		
	/*
	Quest�o 04:
	======================================================================================================================*/
			
		
	/*
	Quest�o 05:
	======================================================================================================================*/


	
/*
Tabelas Para Trabalho:
==========================================================================================================================*/
SELECT	*
FROM	CONTINENTE;

SELECT	*
FROM	GRUPO;

SELECT	*
FROM	PAIS;

SELECT	*
FROM	PAISXSEG;

SELECT	*
FROM	SEGMENTO;