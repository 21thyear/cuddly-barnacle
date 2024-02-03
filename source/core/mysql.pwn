#include "../source/core/mysql_data.pwn"

stock SetMySQLConnection()
{
    dbHandle = mysql_connect(
        SQL_HOST,
        SQL_USER,
        SQL_PASS,
        SQL_BASE
    );

    return mysql_errno(dbHandle);
}

stock CreateMySQLTables()
{
    static const accounts_fmt_table[] = "\
        CREATE TABLE IF NOT EXISTS accounts ( \
            uID SERIAL PRIMARY KEY,  \
            uName VARCHAR(24),  \
            uPassword VARCHAR(64),  \
            uMail VARCHAR(32) NOT NULL,  \
            uPromocode VARCHAR(16) NOT NULL,  \
            uSkin INT  \
        ); \
        ";
    mysql_query(dbHandle, accounts_fmt_table, false);

    static const promocode_fmt_table[] = "\
        CREATE TABLE IF NOT EXISTS promocodes ( \
            pID SERIAL PRIMARY KEY,  \
            pName VARCHAR(16),  \
            pAuthorID INT(11) NOT NULL,  \
            pBonus INT(11) NOT NULL  \
        ); \
        ";
    mysql_query(dbHandle, promocode_fmt_table, false);
}