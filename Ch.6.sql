/*6-2*/
/*個人顧客全員の姓名と行員全員の姓名を検索する複合クエリ*/
select c.fname '姓', c.lname '名'
from individual c
union
select e.fname, e.lname
from employee e
;

/*6-3*/
/*6-2の結果をlname列で並べ替える。*/
select c.fname fname, c.lname lname
from individual c
union
select e.fname, e.lname
from employee e
order by lname;
