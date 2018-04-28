/*11-1*/
/*単純ケース式を使用している以下のクエリを書き換えて、検索case式を使用して同じ結果が得られるようにする。when節の数はできるだけ少なくすること。*/
/*
SELECT emp_id,
  CASE title
    WHEN 'President' THEN 'Management'
    WHEN 'Vice President' THEN 'Management'
    WHEN 'Treasurer' THEN 'Management'
    WHEN 'Loan Manager' THEN 'Management'
    WHEN 'Operations Manager' THEN 'Operations'
    WHEN 'Head Teller' THEN 'Operations'
    ELSE 'Unknown'
  END title
FROM employee;
*/
SELECT emp_id,
  CASE
    WHEN title LIKE '%President'
         OR title = 'Treasurer'
         OR title = 'Loan Manager'
      THEN 'Management'
    WHEN title = 'Operations Manager'
         OR title = 'Head Teller'
      THEN 'Operations'
    ELSE 'Unknown'
  END title
FROM employee;
/*
+--------+------------+
| emp_id | title      |
+--------+------------+
| 1      | Management |
| 2      | Management |
| 3      | Management |
| 4      | Operations |
| 5      | Management |
| 6      | Operations |
| 7      | Unknown    |
| 8      | Unknown    |
| 9      | Unknown    |
| 10     | Operations |
| 11     | Unknown    |
| 12     | Unknown    |
| 13     | Operations |
| 14     | Unknown    |
| 15     | Unknown    |
| 16     | Operations |
| 17     | Unknown    |
| 18     | Unknown    |
+--------+------------+
18 rows in set
Time: 0.007s
*/

/*11-2*/
/*以下のクエリを書き換えて、結果セットに4つの列（支店ごとに１つ）からなる行が一つだけ含まれるようにする。この４つの列には、branch_1 ~ branch_4 という名前をつける。*/
/*
SELECT open_branch_id, COUNT(*)
FROM account
GROUP BY open_branch_id;
*/
SELECT
SUM(CASE WHEN open_branch_id = 1 THEN 1 ELSE 0 END) branch_1,
SUM(CASE WHEN open_branch_id = 2 THEN 1 ELSE 0 END) branch_2,
SUM(CASE WHEN open_branch_id = 3 THEN 1 ELSE 0 END) branch_3,
SUM(CASE WHEN open_branch_id = 4 THEN 1 ELSE 0 END) branch_4
FROM account;
/*
+----------+----------+----------+----------+
| branch_1 | branch_2 | branch_3 | branch_4 |
+----------+----------+----------+----------+
| 8        | 7        | 3        | 6        |
+----------+----------+----------+----------+
1 row in set
Time: 0.008s
*/
