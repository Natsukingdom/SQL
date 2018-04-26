/*9-1*/
/*account テーブルから口座ID,商品コード,顧客ID,口座の残高を取得するためのクエリを作成する。このクエリでは、フィルタ条件として、productテーブルからすべてのローン口座(product.product_type_cd = 'LOAN')を検索するためのサブクエリを使用する。*/
select a.account_id, a.product_cd, a.cust_id, a.avail_balance
from account a
where a.product_cd in
  (
   select product_cd
   from product
   where product_type_cd = 'LOAN'
  );
/*
+------------+------------+---------+---------------+
| account_id | product_cd | cust_id | avail_balance |
+------------+------------+---------+---------------+
| 25         | BUS        | 10      |     0.0       |
| 27         | BUS        | 11      |  9345.55      |
| 29         | SBL        | 13      | 50000.0       |
+------------+------------+---------+---------------+
3 rows in set
Time: 0.030s
*/

/*9-2*/
/*練習問題9-1のクエリを、productテーブルへの相関サブクエリを使って同じ結果を得るものに書き換える。*/
select a.account_id, a.product_cd, a.cust_id, a.avail_balance
from account a
where exists
    ( select 1
      from product p
      where a.product_cd = p.product_cd and
            p.product_type_cd = 'LOAN'
    )
;
/*
+------------+------------+---------+---------------+
| account_id | product_cd | cust_id | avail_balance |
+------------+------------+---------+---------------+
| 25         | BUS        | 10      |     0.0       |
| 27         | BUS        | 11      |  9345.55      |
| 29         | SBL        | 13      | 50000.0       |
+------------+------------+---------+---------------+
3 rows in set
Time: 0.007s
*/

/*9-3*/
/*
各行員の経験度を表示するために、以下のクエリをemployeeテーブルに結合する。
サブクエリは"levels"というエイリアスを持ち、行員ID、姓名、経験度（levels.name)が含まれるものとする。
ヒント：employee.start_date列がどの経験度に属するかを判断する不等価条件に基づいて、結合条件を作成する。
*/
select e.emp_id, e.fname, e.lname, levels.name
from employee e inner join
  (select 'trainee' name, '2004-01-01' start_dt, '2005-12-31' end_dt
  union all
  select 'worker' name, '2002-01-01' start_dt, '2003-12-31' end_dt
  union all
  select 'mentor' name, '2000-01-01' start_dt, '2001-12-31' end_dt) levels
on e.start_date between levels.start_dt and levels.end_dt;
/*
+--------+----------+-----------+---------+
| emp_id | fname    | lname     | name    |
+--------+----------+-----------+---------+
| 1      | Michael  | Smith     | mentor  |
| 2      | Susan    | Barker    | worker  |
| 3      | Robert   | Tyler     | mentor  |
| 4      | Susan    | Hawthorne | worker  |
| 5      | John     | Gooding   | worker  |
| 6      | Helen    | Fleming   | trainee |
| 7      | Chris    | Tucker    | trainee |
| 8      | Sarah    | Parker    | worker  |
| 9      | Jane     | Grossman  | worker  |
| 10     | Paula    | Roberts   | worker  |
| 11     | Thomas   | Ziegler   | mentor  |
| 12     | Samantha | Jameson   | worker  |
| 13     | John     | Blake     | mentor  |
| 14     | Cindy    | Mason     | worker  |
| 15     | Frank    | Portman   | worker  |
| 16     | Theresa  | Markham   | mentor  |
| 17     | Beth     | Fowler    | worker  |
| 18     | Rick     | Tulman    | worker  |
+--------+----------+-----------+---------+
18 rows in set
Time: 0.008s
*/

/*9-4*/
/*employeeテーブルから行員IDと姓名を取得し、行員が配属されている部署と支店の名前を取得するためのクエリを作成する。ただし、テーブルを結合してはならない。*/
select e.emp_id, e.fname, e.lname,
    (select d.name
     from department d
     where d.dept_id = e.dept_id) department,
    (select b.name
     from branch b
     where b.branch_id = e.assigned_branch_id) branch
from employee e;
/*
+--------+----------+-----------+----------------+---------------+
| emp_id | fname    | lname     | department     | branch        |
+--------+----------+-----------+----------------+---------------+
| 1      | Michael  | Smith     | Administration | Headquarters  |
| 2      | Susan    | Barker    | Administration | Headquarters  |
| 3      | Robert   | Tyler     | Administration | Headquarters  |
| 4      | Susan    | Hawthorne | Operations     | Headquarters  |
| 5      | John     | Gooding   | Loans          | Headquarters  |
| 6      | Helen    | Fleming   | Operations     | Headquarters  |
| 7      | Chris    | Tucker    | Operations     | Headquarters  |
| 8      | Sarah    | Parker    | Operations     | Headquarters  |
| 9      | Jane     | Grossman  | Operations     | Headquarters  |
| 10     | Paula    | Roberts   | Operations     | Woburn Branch |
| 11     | Thomas   | Ziegler   | Operations     | Woburn Branch |
| 12     | Samantha | Jameson   | Operations     | Woburn Branch |
| 13     | John     | Blake     | Operations     | Quincy Branch |
| 14     | Cindy    | Mason     | Operations     | Quincy Branch |
| 15     | Frank    | Portman   | Operations     | Quincy Branch |
| 16     | Theresa  | Markham   | Operations     | So. NH Branch |
| 17     | Beth     | Fowler    | Operations     | So. NH Branch |
| 18     | Rick     | Tulman    | Operations     | So. NH Branch |
+--------+----------+-----------+----------------+---------------+
18 rows in set
Time: 0.008s
*/
