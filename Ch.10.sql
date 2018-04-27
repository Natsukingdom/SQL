/*10-1*/
/*すべての商品名とその商品に基づく口座をすべて取得するためのクエリを作成する.(accuountテーブルのproduct_cd列に基づいてproductテーブルをリンクする.)
その商品の口座が開かれていない場合であっても、すべての商品が含まれるようにする.*/
select p.product_cd, a.account_id
from product p left outer join account a
on p.product_cd = a.product_cd;
/*
+------------+------------+
| product_cd | account_id |
+------------+------------+
| CD         | 3          |
| CD         | 15         |
| CD         | 17         |
| CD         | 23         |
| CHK        | 1          |
| CHK        | 4          |
| CHK        | 7          |
| CHK        | 10         |
| CHK        | 13         |
| CHK        | 14         |
| CHK        | 18         |
| CHK        | 21         |
| CHK        | 24         |
| CHK        | 28         |
| MM         | 8          |
| MM         | 12         |
| MM         | 22         |
| SAV        | 2          |
| SAV        | 5          |
| SAV        | 11         |
| SAV        | 19         |
| AUT        | <null>     |
| BUS        | 25         |
| BUS        | 27         |
| MRT        | <null>     |
| SBL        | 29         |
+------------+------------+
26 rows in set
Time: 0.009s
*/

/*10-2*/
/*練習問題10-1のクエリを他の外部結合を利用して同じ結果が得られるように書き換える.*/
select p.product_cd, a.account_id
from account a right outer join product p
  on  a.product_cd = p.product_cd;
/*
+------------+------------+
| product_cd | account_id |
+------------+------------+
| CD         | 3          |
| CD         | 15         |
| CD         | 17         |
| CD         | 23         |
| CHK        | 1          |
| CHK        | 4          |
| CHK        | 7          |
| CHK        | 10         |
| CHK        | 13         |
| CHK        | 14         |
| CHK        | 18         |
| CHK        | 21         |
| CHK        | 24         |
| CHK        | 28         |
| MM         | 8          |
| MM         | 12         |
| MM         | 22         |
| SAV        | 2          |
| SAV        | 5          |
| SAV        | 11         |
| SAV        | 19         |
| AUT        | <null>     |
| BUS        | 25         |
| BUS        | 27         |
| MRT        | <null>     |
| SBL        | 29         |
+------------+------------+
26 rows in set
Time: 0.011s
*/

/*10-3*/
/*accountテーブルを(account.cust_id列に基づいて)individual テーブルと buisiness テーブルに外部結合し、結果セットが口座ごとに一行のデータで構成されるようにする。結果セットに含まれる列は、account.account_id, account.product_cd, indivisdual.fname, individual.lname, buisiness.name)*/
select a.account_id,
       a.product_cd,
       concat(i.fname,i.lname) name,
       b.name
from account a left outer join individual i
  on a.cust_id = i.cust_id
  left outer join business b
    on a.cust_id = b.cust_id
order by a.account_id;
/*
+------------+------------+----------------+------------------------+
| account_id | product_cd | name           | name                   |
+------------+------------+----------------+------------------------+
| 1          | CHK        | JamesHadley    | <null>                 |
| 2          | SAV        | JamesHadley    | <null>                 |
| 3          | CD         | JamesHadley    | <null>                 |
| 4          | CHK        | SusanTingley   | <null>                 |
| 5          | SAV        | SusanTingley   | <null>                 |
| 7          | CHK        | FrankTucker    | <null>                 |
| 8          | MM         | FrankTucker    | <null>                 |
| 10         | CHK        | JohnHayward    | <null>                 |
| 11         | SAV        | JohnHayward    | <null>                 |
| 12         | MM         | JohnHayward    | <null>                 |
| 13         | CHK        | CharlesFrasier | <null>                 |
| 14         | CHK        | JohnSpencer    | <null>                 |
| 15         | CD         | JohnSpencer    | <null>                 |
| 17         | CD         | MargaretYoung  | <null>                 |
| 18         | CHK        | LouisBlake     | <null>                 |
| 19         | SAV        | LouisBlake     | <null>                 |
| 21         | CHK        | RichardFarley  | <null>                 |
| 22         | MM         | RichardFarley  | <null>                 |
| 23         | CD         | RichardFarley  | <null>                 |
| 24         | CHK        | <null>         | Chilton Engineering    |
| 25         | BUS        | <null>         | Chilton Engineering    |
| 27         | BUS        | <null>         | Northeast Cooling Inc. |
| 28         | CHK        | <null>         | Superior Auto Body     |
| 29         | SBL        | <null>         | AAA Insurance Inc.     |
+------------+------------+----------------+------------------------+
24 rows in set
Time: 0.011s
*/

/*10-4*/
/*集合(1,2,3,...,99,100)を生成するクエリを考案する。
ヒント:直積とfrom節のサブクエリを２つ以上しようする*/
select (a.num + b.num * 10) numbers
from
(   select 1 num union all
    select 2 num union all
    select 3 num union all
    select 4 num union all
    select 5 num union all
    select 6 num union all
    select 7 num union all
    select 8 num union all
    select 9 num union all
    select 10 num
) a
cross join
(   select 0 num union all
    select 1 num union all
    select 2 num union all
    select 3 num union all
    select 4 num union all
    select 5 num union all
    select 6 num union all
    select 7 num union all
    select 8 num union all
    select 9 num 
) b
order by numbers
;
/*
+---------+
| numbers |
+---------+
| 1       |
| 2       |
| 3       |
| 4       |
| 5       |
| 6       |
| 7       |
| 8       |
| 9       |
| 10      |
| 11      |
| 12      |
| 13      |
| 14      |
| 15      |
| 16      |
| 17      |
| 18      |
| 19      |
| 20      |
| 21      |
| 22      |
| 23      |
| 24      |
| 25      |
| 26      |
| 27      |
| 28      |
| 29      |
| 30      |
| 31      |
| 32      |
| 33      |
| 34      |
| 35      |
| 36      |
| 37      |
| 38      |
| 39      |
| 40      |
| 41      |
| 42      |
| 43      |
| 44      |
| 45      |
| 46      |
| 47      |
| 48      |
| 49      |
| 50      |
| 51      |
| 52      |
| 53      |
| 54      |
| 55      |
| 56      |
| 57      |
| 58      |
| 59      |
| 60      |
| 61      |
| 62      |
| 63      |
| 64      |
| 65      |
| 66      |
| 67      |
| 68      |
| 69      |
| 70      |
| 71      |
| 72      |
| 73      |
| 74      |
| 75      |
| 76      |
| 77      |
| 78      |
| 79      |
| 80      |
| 81      |
| 82      |
| 83      |
| 84      |
| 85      |
| 86      |
| 87      |
| 88      |
| 89      |
| 90      |
| 91      |
| 92      |
| 93      |
| 94      |
| 95      |
| 96      |
| 97      |
| 98      |
| 99      |
| 100     |
+---------+
100 rows in set
Time: 0.010s
*/
