-- 1. Карточка клиента со счетами, валютами и статусами
SELECT 
    c.name AS client_name,
    ba.code AS account_number,
    ba.open_dt,
    ba.balance,
    ba.balance_national,
    cur.name AS currency_name,
    cur.symbol,
    sei.name AS status_name
FROM CLIENT c
JOIN BANK_ACCOUNT ba ON c.id = ba.client_id
JOIN CURRENCY cur ON ba.currency = cur.code
JOIN sys_enum_item sei ON ba.status = sei.id
WHERE c.code = 'CL-002'
ORDER BY ba.open_dt DESC;
