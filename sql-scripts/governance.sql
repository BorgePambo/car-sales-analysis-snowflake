-- ===============================
-- 1️⃣ Criar Roles
-- ===============================
CREATE ROLE IF NOT EXISTS data_engineers;
CREATE ROLE IF NOT EXISTS data_analysts;
CREATE ROLE IF NOT EXISTS data_scientists;

-- ===============================
-- 2️⃣ Criar Usuários
-- ===============================
CREATE USER IF NOT EXISTS bastos98 PASSWORD = '*******';
CREATE USER IF NOT EXISTS ana_analyst PASSWORD = '******';
CREATE USER IF NOT EXISTS carlos_ds PASSWORD = '*******';

-- ===============================
-- 3️⃣ Atribuir Roles aos Usuários
-- ===============================
GRANT ROLE data_engineers TO USER bastos98;
GRANT ROLE data_analysts   TO USER ana_analyst;
GRANT ROLE data_scientists TO USER carlos_ds;

-- ===============================
-- 4️⃣ Conceder acesso ao Warehouse
-- ===============================
GRANT USAGE ON WAREHOUSE compute_wh TO ROLE data_engineers;
GRANT USAGE ON WAREHOUSE compute_wh TO ROLE data_analysts;
GRANT USAGE ON WAREHOUSE compute_wh TO ROLE data_scientists;

-- ===============================
-- 5️⃣ Conceder acesso ao Database e Schemas
-- ===============================
GRANT USAGE ON DATABASE dealership TO ROLE data_engineers;
GRANT USAGE ON DATABASE dealership TO ROLE data_analysts;
GRANT USAGE ON DATABASE dealership TO ROLE data_scientists;

GRANT USAGE ON SCHEMA dealership.bronze TO ROLE data_engineers;
GRANT USAGE ON SCHEMA dealership.bronze TO ROLE data_analysts;

GRANT USAGE ON SCHEMA dealership.silver TO ROLE data_engineers;
GRANT USAGE ON SCHEMA dealership.silver TO ROLE data_analysts;

GRANT USAGE ON SCHEMA dealership.gold TO ROLE data_analysts;
GRANT USAGE ON SCHEMA dealership.gold TO ROLE data_scientists;

-- ===============================
-- 6️⃣ Conceder Permissões nas Tabelas
-- ===============================
-- BRONZE: somente leitura para analistas e cientistas
GRANT SELECT ON ALL TABLES IN SCHEMA dealership.bronze TO ROLE data_analysts;
GRANT SELECT ON ALL TABLES IN SCHEMA dealership.bronze TO ROLE data_scientists;

-- SILVER: leitura e escrita para engenheiros, leitura para analistas
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA dealership.silver TO ROLE data_engineers;
GRANT SELECT ON ALL TABLES IN SCHEMA dealership.silver TO ROLE data_analysts;

-- GOLD: somente leitura para analistas e cientistas
GRANT SELECT ON ALL TABLES IN SCHEMA dealership.gold TO ROLE data_analysts;
GRANT SELECT ON ALL TABLES IN SCHEMA dealership.gold TO ROLE data_scientists;
