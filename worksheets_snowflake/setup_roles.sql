USE ROLE USERADMIN;

-- Create Roles
CREATE ROLE IF NOT EXISTS job_ads_dlt_role;
CREATE ROLE IF NOT EXISTS job_ads_dbt_role;
CREATE ROLE IF NOT EXISTS job_ads_reporter_role;


USE ROLE securityadmin;

-- DLT role
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;
GRANT SELECT ON ALL TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;

-- DBT role
GRANT ROLE job_ads_dlt_role TO ROLE job_ads_dbt_role;
GRANT USAGE,
CREATE TABLE,
CREATE VIEW ON SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; --note that job_ads_dlt_role already has the usage privilege on database job_ads
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role;
GRANT SELECT,
INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role;

-- Reporter role
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE job_ads_reporter_role;
GRANT USAGE ON DATABASE job_ads TO ROLE job_ads_reporter_role;
GRANT USAGE ON SCHEMA job_ads.marts TO ROLE job_ads_reporter_role;
GRANT SELECT ON ALL TABLES IN SCHEMA job_ads.marts TO ROLE job_ads_reporter_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA job_ads.marts TO ROLE job_ads_reporter_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA job_ads.marts TO ROLE job_ads_reporter_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA job_ads.marts TO ROLE job_ads_reporter_role;