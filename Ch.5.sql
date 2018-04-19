/*5-2*/
/*法人顧客ではない顧客の口座ID,FederalID,口座の商品名*/
select a.account_id, c.fed_id, p.name
from customer c inner join account a
using(cust_id)
   inner join product p
   using(product_cd)
where c.cust_type_cd = 'I'
order by a.account_id;

/*5-3*/
/*上司と違う部署の部下*/
select e1.emp_id '社員id', e1.fname '姓'
from employee e1 inner join employee e2
on e1.superior_emp_id = e2.emp_id
where e1.dept_id != e2.dept_id;


