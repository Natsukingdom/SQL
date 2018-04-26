/*8-1*/
/*account テーブルの 行の数をカウントするクエリを作成する*/
select count(*)
from account;
/*
+----------+
| count(*) |
+----------+
| 24       |
+----------+
1 row in set
Time: 0.123s
*/

/*8-2*/
/*上記のクエリを書く顧客が開いている口座の数をカウントするものに書き換える。顧客ごとに顧客IDと口座の数を表示する。*/
select cust_id, count(account_id)
from account
group by cust_id;
/*
+---------+-------------------+
| cust_id | count(account_id) |
+---------+-------------------+
| 1       | 3                 |
| 2       | 2                 |
| 3       | 2                 |
| 4       | 3                 |
| 5       | 1                 |
| 6       | 2                 |
| 7       | 1                 |
| 8       | 2                 |
| 9       | 3                 |
| 10      | 2                 |
| 11      | 1                 |
| 12      | 1                 |
| 13      | 1                 |
+---------+-------------------+
13 rows in set
Time: 0.016s
*/

/*8-2*/
/*練習問題8-2のクエリを口座を２つ以上開いている顧客だけを表示するように書き換える*/
select cust_id, count(account_id)
from account
group by cust_id
having count(account_id) >= 2;
/*
+---------+-------------------+
| cust_id | count(account_id) |
+---------+-------------------+
| 1       | 3                 |
| 2       | 2                 |
| 3       | 2                 |
| 4       | 3                 |
| 6       | 2                 |
| 8       | 2                 |
| 9       | 3                 |
| 10      | 2                 |
+---------+-------------------+
8 rows in set
Time: 0.019s
*/
/*8-4*/
/*口座が複数開かれている商品と支店の組み合わせごとに、商品と支店の平均合計残高を求め、結果を合計残高の多い順に並び替える。*/
SELECT product_cd, open_branch_id, SUM(avail_balance) sum
FROM account
GROUP BY product_cd, open_branch_id
HAVING COUNT(*) > 1
ORDER BY sum DESC;
/*
+------------+----------------+----------+
| product_cd | open_branch_id | sum      |
+------------+----------------+----------+
| CHK        | 4              | 67852.33 |
| MM         | 1              | 14832.64 |
| CD         | 1              | 11500.0  |
| CD         | 2              |  8000.0  |
| CHK        | 2              |  3315.77 |
| CHK        | 1              |   782.16 |
| SAV        | 2              |   700.0  |
+------------+----------------+----------+
7 rows in set
Time: 0.007s
*/
