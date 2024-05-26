USE publications;
-- Challenge 1 - Who Have Published What At Where?

CREATE VIEW all_publications AS
SELECT titleauthor.au_id AS author_id, authors.au_lname AS last_name , authors.au_fname AS first_name, title, publishers.pub_name AS publisher
FROM titleauthor 
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers  ON titles.pub_id = publishers.pub_id;

SELECT * FROM all_publications;

-- Challenge 2 - Who Have Published How Many At Where?

SELECT author_id, last_name , first_name, publisher, COUNT(title)
FROM all_publications
GROUP BY 1,2,4
ORDER BY 5 DESC;

-- Challenge 3 - Best Selling Authors

SELECT * FROM sales;

SELECT titleauthor.au_id AS author_id, authors.au_lname AS last_name , authors.au_fname AS first_name, SUM(qty) AS total
FROM sales
LEFT JOIN titleauthor ON sales.title_id = titleauthor.title_id 
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
GROUP BY 1,2,3
ORDER BY 4 DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking

SELECT titleauthor.au_id AS author_id, 
    authors.au_lname AS last_name, 
    authors.au_fname AS first_name, 
    SUM(CASE WHEN qty != 0 THEN qty ELSE 0 END) AS total
FROM  authors
LEFT JOIN  titleauthor ON titleauthor.au_id = authors.au_id
LEFT JOIN  sales ON sales.title_id = titleauthor.title_id 
GROUP BY titleauthor.au_id, authors.au_lname, authors.au_fname
ORDER BY total DESC;








