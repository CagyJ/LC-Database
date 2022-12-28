SELECT d.Name Department, e.Name Employee, e.Salary Salary 
FROM Employee e, Department d, 
(select max(salary) max_salary,departmentid from Employee group by departmentid) t
WHERE e.Salary = t.max_salary AND e.DepartmentId = t.DepartmentId AND e.DepartmentId = d.Id;



SELECT d.Name Department, e.Name Employee, e.Salary Salary 
FROM Employee e INNER JOIN (SELECT max(salary) max_salary,departmentId FROM Employee GROUP BY departmentId) t
ON e.Salary = t.max_salary AND e.DepartmentId = t.DepartmentId
LEFT JOIN Department d ON e.DepartmentId = d.Id
WHERE d.Name is not null;