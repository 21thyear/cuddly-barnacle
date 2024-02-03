#if defined is_core__included
    #endinput
#endif
#define is_core__included

#include "../source/libs/a_mysql"
#include "../source/libs/sscanf2"
#include "../source/libs/Pawn.CMD"
#include "../source/libs/foreach"
#include "../source/libs/mdialog"
#include "../source/libs/bcrypt"

#include "../source/core/mysql.pwn"
#include "../source/libs/colors"

#if !defined MAX_PLAYER_PROMO
    #define MAX_PLAYER_PROMO                    (16)
#endif
#if !defined MAX_PLAYER_EMAIL
    #define MAX_PLAYER_EMAIL                    (32)
#endif
#if !defined MAX_PLAYER_PASS
    #define MAX_PLAYER_PASS                     (64)
#endif

#if !defined PLAYER_SEX_MAN
    #define PLAYER_SEX_MAN                      (0)
#endif

#if !defined PLAYER_SEX_WOMEN
    #define PLAYER_SEX_WOMEN                    (1)
#endif

#if !defined MINIMAL_CODE_VALUE
    #define MINIMAL_CODE_VALUE                  (100_000)
#endif  

#if !defined MAXIMUM_CODE_VALUE
    #define MAXIMUM_CODE_VALUE                  (1_000_000)
#endif

#define BCRYPT_COST                             (12)

#if !defined function
    #define function:%0(%1)                     forward %0(%1); public %0(%1)
#endif