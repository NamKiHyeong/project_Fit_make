DROP USER fm CASCADE;

CREATE USER fm IDENTIFIED BY fm1234;

GRANT CONNECT, RESOURCE TO fm;