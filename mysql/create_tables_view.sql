DROP VIEW IF EXISTS t;
CREATE VIEW t AS
SELECT table_name, table_type, engine, rows,
  TRUNCATE((data_length / (1024 * 1024)),1) AS dMB,
  TRUNCATE((index_length / (1024 * 1024)),1) AS iMB,
  table_comment AS comment
FROM information_schema.tables
WHERE table_schema = database();
