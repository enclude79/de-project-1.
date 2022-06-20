DROP VIEW IF EXISTS analysis.orders CASCADE;
create view analysis.orders as
WITH last_order_status AS
  (SELECT order_id,
          status_id AS status,
          dttm,
          ROW_NUMBER() OVER(PARTITION BY order_id
                            ORDER BY status_id DESC)
   FROM production.orderstatuslog ord
   ORDER BY order_id ASC, status DESC)
SELECT ord.order_id, --ord.order_ts,
 ord.user_id,
 ord.bonus_payment,
 ord.payment,
 ord."cost",
 ord.bonus_grant,
 los.status AS status,
 los.dttm AS order_ts
FROM production.orders ord
INNER JOIN last_order_status los ON ord.order_id = los.order_id
WHERE los.row_number = 1;