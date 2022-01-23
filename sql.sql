drop table if exists tbl_emp;
create table tbl_emp(
    emp_id int(11) primary key auto_increment,
    emp_name varchar(255) not null,
    gender char(1),
    email varchar(255),
    d_id int(11),
    constraint fk_emp_dept foreign key(d_id) references tbl_dept(dept_id)
);

# ------------------------------------------------------------------
drop table if exists tbl_dept;
create table tbl_dept(
    dept_id int(11) primary key auto_increment,
    dept_name varchar(255) not null
);

# ------------------------------------------------------------------
insert into tbl_dept(dept_id, dept_name) values(1,'开发部');
insert into tbl_dept(dept_id, dept_name) values(2,'生产部');

insert into tbl_emp(emp_name, gender, email, d_id)
values('kazuha','男','2345234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('albedo','男','09452234@qq.com',1);

insert into tbl_emp(emp_name, gender, email, d_id)
values('diona','女','78565234@qq.com',1);

insert into tbl_emp(emp_name, gender, email, d_id)
values('ayaka','女','2345234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('venti','男','2345234@qq.com',1);

insert into tbl_emp(emp_name, gender, email, d_id)
values('bennett','男','98092234@qq.com',1);

insert into tbl_emp(emp_name, gender, email, d_id)
values('xiangning','女','397845234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('kokomi','女','786843923@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('xiao','男','8990045234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('mona','女','978677845234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('hutao','女','176845234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('chongyun','男','897845234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('ganyu','女','70045234@qq.com',2);

insert into tbl_emp(emp_name, gender, email, d_id)
values('eula','女','907845234@qq.com',2);
